-- Day 029: Filter Change Impact
-- Purpose: Compare how filter changes add or remove records and alter business meaning.
-- Safety: Read-only examples only. No production view is deployed or replaced.

-- Completed-only versus completed-plus-refunded.
WITH old_logic AS (
    SELECT order_id, customer_id, order_status, order_amount
    FROM orders_source
    WHERE order_status = 'COMPLETED'
),
new_logic AS (
    SELECT order_id, customer_id, order_status, order_amount
    FROM orders_source
    WHERE order_status IN ('COMPLETED', 'REFUNDED', 'REFUND_REQUESTED')
)
SELECT
    'STATUS_FILTER_CHANGE' AS check_name,
    (SELECT COUNT(*) FROM old_logic) AS old_row_count,
    (SELECT COUNT(*) FROM new_logic) AS new_row_count,
    (SELECT SUM(order_amount) FROM old_logic) AS old_total,
    (SELECT SUM(order_amount) FROM new_logic) AS new_total,
    'Review whether refunded-like rows are expected in the new output.' AS review_message;

-- Active customers only versus all customers.
SELECT
    customer_status,
    COUNT(*) AS customer_rows
FROM customers_source
GROUP BY customer_status
ORDER BY customer_status;

-- Positive amount versus non-zero amount.
WITH positive_amount AS (
    SELECT order_id, order_amount
    FROM orders_source
    WHERE order_amount > 0
),
non_zero_amount AS (
    SELECT order_id, order_amount
    FROM orders_source
    WHERE order_amount <> 0
)
SELECT
    'AMOUNT_FILTER_CHANGE' AS check_name,
    (SELECT COUNT(*) FROM positive_amount) AS old_row_count,
    (SELECT COUNT(*) FROM non_zero_amount) AS new_row_count,
    (SELECT SUM(order_amount) FROM positive_amount) AS old_total,
    (SELECT SUM(order_amount) FROM non_zero_amount) AS new_total;

-- Date-range expansion.
WITH old_logic AS (
    SELECT order_id, order_date, order_amount
    FROM orders_source
    WHERE order_date BETWEEN '2026-01-01' AND '2026-01-07'
),
new_logic AS (
    SELECT order_id, order_date, order_amount
    FROM orders_source
    WHERE order_date BETWEEN '2026-01-01' AND '2026-01-10'
)
SELECT
    'DATE_RANGE_EXPANSION' AS check_name,
    (SELECT COUNT(*) FROM old_logic) AS old_row_count,
    (SELECT COUNT(*) FROM new_logic) AS new_row_count,
    (SELECT MIN(order_date) FROM new_logic) AS new_min_date,
    (SELECT MAX(order_date) FROM new_logic) AS new_max_date;

-- Null exclusion change.
SELECT
    CASE WHEN country IS NULL THEN 'NULL_COUNTRY' ELSE 'HAS_COUNTRY' END AS country_status,
    COUNT(*) AS row_count
FROM customers_source
GROUP BY CASE WHEN country IS NULL THEN 'NULL_COUNTRY' ELSE 'HAS_COUNTRY' END;

-- Country filter change.
WITH old_logic AS (
    SELECT customer_id, country
    FROM customers_source
    WHERE country = 'India'
),
new_logic AS (
    SELECT customer_id, country
    FROM customers_source
    WHERE country IN ('India', 'UK')
)
SELECT
    'COUNTRY_FILTER_CHANGE' AS check_name,
    (SELECT COUNT(*) FROM old_logic) AS old_row_count,
    (SELECT COUNT(*) FROM new_logic) AS new_row_count;

-- Status standardisation before filtering.
SELECT
    order_id,
    order_status,
    CASE
        WHEN order_status = 'REFUND_REQUESTED' THEN 'REFUNDED_LIKE'
        ELSE order_status
    END AS standard_order_status
FROM orders_source
ORDER BY order_id;

-- Added rows after filter change.
WITH old_logic AS (
    SELECT order_id
    FROM orders_source
    WHERE order_status = 'COMPLETED'
),
new_logic AS (
    SELECT order_id
    FROM orders_source
    WHERE order_status IN ('COMPLETED', 'REFUNDED', 'REFUND_REQUESTED')
)
SELECT
    n.order_id,
    'ADDED_BY_FILTER_CHANGE' AS review_reason
FROM new_logic AS n
LEFT JOIN old_logic AS o
    ON n.order_id = o.order_id
WHERE o.order_id IS NULL;
