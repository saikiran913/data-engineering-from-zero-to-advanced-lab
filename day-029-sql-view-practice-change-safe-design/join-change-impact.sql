-- Day 029: Join Change Impact
-- Purpose: Compare join changes for row retention, multiplication, and unmatched records.
-- Safety: Read-only examples only. No production view is deployed or replaced.

-- Inner join versus left join.
WITH inner_join_logic AS (
    SELECT o.order_id, o.customer_id, c.country, o.order_amount
    FROM orders_source AS o
    INNER JOIN customers_source AS c
        ON o.customer_id = c.customer_id
),
left_join_logic AS (
    SELECT o.order_id, o.customer_id, c.country, o.order_amount
    FROM orders_source AS o
    LEFT JOIN customers_source AS c
        ON o.customer_id = c.customer_id
)
SELECT
    'CUSTOMER_JOIN_ROW_COUNT' AS check_name,
    (SELECT COUNT(*) FROM inner_join_logic) AS old_row_count,
    (SELECT COUNT(*) FROM left_join_logic) AS new_row_count,
    (SELECT COUNT(*) FROM left_join_logic) - (SELECT COUNT(*) FROM inner_join_logic) AS difference,
    'Left join may retain orders that have no matching customer.' AS review_message;

-- Adding payments to orders.
WITH orders_only AS (
    SELECT order_id, customer_id, order_amount
    FROM orders_source
),
orders_with_payments AS (
    SELECT
        o.order_id,
        o.customer_id,
        o.order_amount,
        p.payment_id,
        p.payment_status
    FROM orders_source AS o
    LEFT JOIN payments_source AS p
        ON o.order_id = p.order_id
)
SELECT
    'PAYMENT_JOIN_ROW_COUNT' AS check_name,
    (SELECT COUNT(*) FROM orders_only) AS old_row_count,
    (SELECT COUNT(*) FROM orders_with_payments) AS new_row_count,
    'Payment attempts can multiply order rows.' AS review_message;

-- Joining before aggregation versus after aggregation.
WITH aggregate_before_join AS (
    SELECT customer_id, SUM(order_amount) AS order_total
    FROM orders_source
    WHERE order_status = 'COMPLETED'
      AND order_amount > 0
    GROUP BY customer_id
),
join_before_aggregate AS (
    SELECT
        c.customer_id,
        SUM(o.order_amount) AS order_total
    FROM customers_source AS c
    INNER JOIN orders_source AS o
        ON c.customer_id = o.customer_id
    WHERE o.order_status = 'COMPLETED'
      AND o.order_amount > 0
    GROUP BY c.customer_id
)
SELECT
    'TOTAL_COMPARISON' AS check_name,
    (SELECT SUM(order_total) FROM aggregate_before_join) AS aggregate_before_join_total,
    (SELECT SUM(order_total) FROM join_before_aggregate) AS join_before_aggregate_total,
    'Duplicate customer versions can inflate the join-before-aggregate result.' AS review_message;

-- Duplicate customer rows multiplying orders.
SELECT
    o.order_id,
    o.customer_id,
    COUNT(*) AS joined_customer_rows
FROM orders_source AS o
INNER JOIN customers_source AS c
    ON o.customer_id = c.customer_id
GROUP BY o.order_id, o.customer_id
HAVING COUNT(*) > 1;

-- Wrong join key teaching check: show unmatched payment records by correct key.
SELECT
    p.payment_id,
    p.order_id,
    'PAYMENT_WITHOUT_MATCHING_ORDER' AS review_reason
FROM payments_source AS p
LEFT JOIN orders_source AS o
    ON p.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Additional join filter impact.
WITH all_customer_orders AS (
    SELECT o.order_id, o.order_amount
    FROM orders_source AS o
    INNER JOIN customers_source AS c
        ON o.customer_id = c.customer_id
),
active_customer_orders AS (
    SELECT o.order_id, o.order_amount
    FROM orders_source AS o
    INNER JOIN customers_source AS c
        ON o.customer_id = c.customer_id
    WHERE c.customer_status = 'ACTIVE'
)
SELECT
    'ACTIVE_CUSTOMER_JOIN_FILTER' AS check_name,
    (SELECT COUNT(*) FROM all_customer_orders) AS old_row_count,
    (SELECT COUNT(*) FROM active_customer_orders) AS new_row_count,
    'Adding a customer-status filter changes row retention.' AS review_message;

-- Join-impact summary.
WITH old_logic AS (
    SELECT order_id, order_amount
    FROM orders_source
),
new_logic AS (
    SELECT o.order_id, o.order_amount, p.payment_id
    FROM orders_source AS o
    LEFT JOIN payments_source AS p
        ON o.order_id = p.order_id
),
duplicates AS (
    SELECT order_id
    FROM new_logic
    GROUP BY order_id
    HAVING COUNT(*) > 1
),
unmatched AS (
    SELECT o.order_id
    FROM orders_source AS o
    LEFT JOIN payments_source AS p
        ON o.order_id = p.order_id
    WHERE p.order_id IS NULL
)
SELECT
    (SELECT COUNT(*) FROM old_logic) AS old_row_count,
    (SELECT COUNT(*) FROM new_logic) AS new_row_count,
    (SELECT COUNT(*) FROM duplicates) AS duplicate_key_count,
    (SELECT COUNT(*) FROM unmatched) AS unmatched_count,
    (SELECT SUM(order_amount) FROM new_logic) AS new_total_amount,
    CASE WHEN (SELECT COUNT(*) FROM duplicates) = 0 THEN 'PASS' ELSE 'REVIEW' END AS review_status;
