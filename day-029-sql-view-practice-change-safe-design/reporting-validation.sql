-- Day 029: Reporting Validation
-- Purpose: Validate reporting outputs before trusting a view change.
-- Safety: Read-only examples only. No production view is deployed or replaced.

-- Proposed valid-order output being validated.
WITH proposed_valid_orders AS (
    SELECT
        order_id,
        customer_id,
        order_date,
        order_status,
        order_amount,
        updated_at
    FROM orders_source
    WHERE customer_id IS NOT NULL
      AND order_amount > 0
      AND order_status IN ('COMPLETED', 'REFUNDED')
)
SELECT COUNT(*) AS row_count
FROM proposed_valid_orders;

-- Distinct-key check.
WITH proposed_valid_orders AS (
    SELECT order_id, customer_id, order_amount
    FROM orders_source
    WHERE customer_id IS NOT NULL
      AND order_amount > 0
      AND order_status IN ('COMPLETED', 'REFUNDED')
)
SELECT COUNT(DISTINCT order_id) AS distinct_order_count
FROM proposed_valid_orders;

-- Duplicate-key check.
WITH proposed_valid_orders AS (
    SELECT order_id, customer_id, order_amount
    FROM orders_source
    WHERE customer_id IS NOT NULL
      AND order_amount > 0
      AND order_status IN ('COMPLETED', 'REFUNDED')
)
SELECT order_id, COUNT(*) AS row_count
FROM proposed_valid_orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Null-count check.
SELECT
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS null_customer_id_count,
    SUM(CASE WHEN order_amount IS NULL THEN 1 ELSE 0 END) AS null_order_amount_count
FROM orders_source;

-- Total reconciliation.
WITH proposed_valid_orders AS (
    SELECT order_id, order_amount
    FROM orders_source
    WHERE customer_id IS NOT NULL
      AND order_amount > 0
      AND order_status IN ('COMPLETED', 'REFUNDED')
)
SELECT SUM(order_amount) AS proposed_total_amount
FROM proposed_valid_orders;

-- Status distribution check.
SELECT
    order_status,
    COUNT(*) AS row_count,
    SUM(order_amount) AS total_amount
FROM orders_source
GROUP BY order_status
ORDER BY order_status;

-- Date-boundary check.
WITH proposed_valid_orders AS (
    SELECT order_id, order_date
    FROM orders_source
    WHERE customer_id IS NOT NULL
      AND order_amount > 0
      AND order_status IN ('COMPLETED', 'REFUNDED')
)
SELECT
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS latest_order_date
FROM proposed_valid_orders;

-- Unmatched-join check.
SELECT
    o.order_id,
    o.customer_id
FROM orders_source AS o
LEFT JOIN customers_source AS c
    ON o.customer_id = c.customer_id
WHERE o.customer_id IS NOT NULL
  AND c.customer_id IS NULL;

-- Excluded-row check.
SELECT
    order_id,
    customer_id,
    order_status,
    order_amount,
    'EXCLUDED_FROM_VALID_ORDER_OUTPUT' AS review_reason
FROM orders_source
WHERE customer_id IS NULL
   OR order_amount <= 0
   OR order_status NOT IN ('COMPLETED', 'REFUNDED');

-- Representative-sample review.
SELECT
    order_id,
    customer_id,
    order_status,
    order_amount,
    updated_at
FROM orders_source
ORDER BY order_id, updated_at
LIMIT 10;

-- Combined validation summary.
WITH proposed_valid_orders AS (
    SELECT order_id, customer_id, order_amount
    FROM orders_source
    WHERE customer_id IS NOT NULL
      AND order_amount > 0
      AND order_status IN ('COMPLETED', 'REFUNDED')
),
checks AS (
    SELECT
        'DUPLICATE_ORDER_KEYS' AS check_name,
        COUNT(*) AS issue_count,
        'Expected one row per order_id.' AS review_message
    FROM (
        SELECT order_id
        FROM proposed_valid_orders
        GROUP BY order_id
        HAVING COUNT(*) > 1
    ) duplicate_orders
    UNION ALL
    SELECT
        'NULL_CUSTOMER_ID',
        COUNT(*),
        'Customer ID should be present in proposed valid orders.'
    FROM proposed_valid_orders
    WHERE customer_id IS NULL
)
SELECT
    check_name,
    issue_count,
    CASE WHEN issue_count = 0 THEN 'PASS' ELSE 'REVIEW' END AS status,
    review_message
FROM checks;
