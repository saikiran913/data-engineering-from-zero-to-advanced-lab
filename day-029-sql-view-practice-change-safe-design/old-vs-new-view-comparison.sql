-- Day 029: Old Versus New View Comparison
-- Purpose: Compare current and proposed view logic without deploying or replacing a view.
-- Safety: Read-only examples only. No production view is deployed or replaced.

-- Example 1: Filter change.
-- Current grain: one row per completed order version.
-- Proposed grain: one row per completed or refunded-like order version.
WITH old_view_logic AS (
    SELECT order_id, customer_id, order_status, order_amount
    FROM orders_source
    WHERE order_status = 'COMPLETED'
      AND customer_id IS NOT NULL
      AND order_amount > 0
),
new_view_logic AS (
    SELECT order_id, customer_id, order_status, order_amount
    FROM orders_source
    WHERE order_status IN ('COMPLETED', 'REFUNDED', 'REFUND_REQUESTED')
      AND customer_id IS NOT NULL
      AND order_amount > 0
)
SELECT
    'ROW_COUNT' AS check_name,
    (SELECT COUNT(*) FROM old_view_logic) AS old_value,
    (SELECT COUNT(*) FROM new_view_logic) AS new_value,
    (SELECT COUNT(*) FROM new_view_logic) - (SELECT COUNT(*) FROM old_view_logic) AS difference,
    'Review expected added refunded-like records.' AS review_message;

-- Status distribution comparison for the filter change.
WITH old_view_logic AS (
    SELECT order_id, order_status, order_amount
    FROM orders_source
    WHERE order_status = 'COMPLETED'
      AND customer_id IS NOT NULL
      AND order_amount > 0
),
new_view_logic AS (
    SELECT order_id, order_status, order_amount
    FROM orders_source
    WHERE order_status IN ('COMPLETED', 'REFUNDED', 'REFUND_REQUESTED')
      AND customer_id IS NOT NULL
      AND order_amount > 0
)
SELECT 'old' AS logic_version, order_status, COUNT(*) AS row_count, SUM(order_amount) AS total_amount
FROM old_view_logic
GROUP BY order_status
UNION ALL
SELECT 'new', order_status, COUNT(*), SUM(order_amount)
FROM new_view_logic
GROUP BY order_status
ORDER BY logic_version, order_status;

-- Only-in-new records.
WITH old_view_logic AS (
    SELECT order_id, customer_id, order_status, order_amount
    FROM orders_source
    WHERE order_status = 'COMPLETED'
      AND customer_id IS NOT NULL
      AND order_amount > 0
),
new_view_logic AS (
    SELECT order_id, customer_id, order_status, order_amount
    FROM orders_source
    WHERE order_status IN ('COMPLETED', 'REFUNDED', 'REFUND_REQUESTED')
      AND customer_id IS NOT NULL
      AND order_amount > 0
)
SELECT
    n.order_id,
    n.customer_id,
    n.order_status,
    n.order_amount,
    'ONLY_IN_NEW' AS difference_type
FROM new_view_logic AS n
LEFT JOIN old_view_logic AS o
    ON n.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Example 2: Join change from orders only to orders plus payments.
-- Risk: one order can have multiple payment attempts.
WITH old_view_logic AS (
    SELECT order_id, customer_id, order_amount
    FROM orders_source
    WHERE customer_id IS NOT NULL
      AND order_amount > 0
),
new_view_logic AS (
    SELECT
        o.order_id,
        o.customer_id,
        o.order_amount,
        p.payment_id,
        p.payment_status
    FROM orders_source AS o
    LEFT JOIN payments_source AS p
        ON o.order_id = p.order_id
    WHERE o.customer_id IS NOT NULL
      AND o.order_amount > 0
)
SELECT
    'JOIN_ROW_COUNT' AS check_name,
    (SELECT COUNT(*) FROM old_view_logic) AS old_value,
    (SELECT COUNT(*) FROM new_view_logic) AS new_value,
    (SELECT COUNT(*) FROM new_view_logic) - (SELECT COUNT(*) FROM old_view_logic) AS difference,
    'If new row count is higher, payment attempts may be multiplying orders.' AS review_message;

-- Example 3: Column alias change using consumer contracts.
SELECT
    view_name,
    consumer_name,
    required_columns,
    'completed_order_amount renamed to revenue_amount' AS proposed_alias_change,
    CASE
        WHEN required_columns LIKE '%completed_order_amount%' THEN 'HIGH_REVIEW'
        ELSE 'LOW_REVIEW'
    END AS impact_level
FROM view_consumers
WHERE view_name = 'vw_customer_sales_summary';

-- Example 4: Null-handling change.
WITH old_view_logic AS (
    SELECT customer_id, country
    FROM customers_source
),
new_view_logic AS (
    SELECT
        customer_id,
        CASE WHEN country IS NULL THEN 'UNKNOWN' ELSE country END AS country
    FROM customers_source
)
SELECT 'old' AS logic_version, country, COUNT(*) AS row_count
FROM old_view_logic
GROUP BY country
UNION ALL
SELECT 'new', country, COUNT(*)
FROM new_view_logic
GROUP BY country
ORDER BY logic_version, country;

-- Example 5: Grain change from order to order-payment attempt.
WITH new_view_logic AS (
    SELECT
        o.order_id,
        p.payment_id
    FROM orders_source AS o
    LEFT JOIN payments_source AS p
        ON o.order_id = p.order_id
)
SELECT
    order_id,
    COUNT(*) AS rows_per_order
FROM new_view_logic
GROUP BY order_id
HAVING COUNT(*) > 1;
