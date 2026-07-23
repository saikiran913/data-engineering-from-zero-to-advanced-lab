-- Day 023: Step-by-Step CTE Building
-- Topic: Build, validate, and extend named SQL steps.
-- Safety note: every query in this file is read-only.

-- Worked example 1: Active customers with completed orders.
WITH active_customers AS (
    SELECT customer_id, customer_name, country
    FROM customers
    WHERE customer_status = 'ACTIVE'
),
completed_orders AS (
    SELECT order_id, customer_id, order_amount
    FROM raw_orders
    WHERE order_status = 'COMPLETED'
      AND order_amount > 0
)
SELECT
    c.customer_id,
    c.customer_name,
    c.country,
    o.order_id,
    o.order_amount
FROM active_customers AS c
JOIN completed_orders AS o
    ON c.customer_id = o.customer_id
ORDER BY c.customer_id, o.order_id;

-- Validate example 1:
-- Run active_customers alone, then completed_orders alone, then check join row count.

-- Worked example 2: Latest valid order version.
WITH ranked_orders AS (
    SELECT
        order_id,
        customer_id,
        order_status,
        order_amount,
        updated_at,
        source_file,
        ROW_NUMBER() OVER (
            PARTITION BY order_id
            ORDER BY updated_at DESC, source_file DESC
        ) AS row_num
    FROM raw_orders
),
latest_orders AS (
    SELECT *
    FROM ranked_orders
    WHERE row_num = 1
),
valid_latest_orders AS (
    SELECT *
    FROM latest_orders
    WHERE customer_id IS NOT NULL
      AND order_amount > 0
)
SELECT order_id, customer_id, order_status, order_amount, updated_at, source_file
FROM valid_latest_orders
ORDER BY order_id;

-- Worked example 3: Customer revenue summary.
WITH valid_orders AS (
    SELECT order_id, customer_id, order_amount
    FROM raw_orders
    WHERE customer_id IS NOT NULL
      AND order_status = 'COMPLETED'
      AND order_amount > 0
),
customer_totals AS (
    SELECT
        customer_id,
        COUNT(*) AS order_count,
        SUM(order_amount) AS total_order_value
    FROM valid_orders
    GROUP BY customer_id
)
SELECT *
FROM customer_totals
WHERE total_order_value > 500
ORDER BY total_order_value DESC;

-- Worked example 4: Source-target missing records.
WITH source_keys AS (
    SELECT record_id, business_key
    FROM source_records
),
target_keys AS (
    SELECT record_id, business_key
    FROM target_records
),
missing_keys AS (
    SELECT s.record_id, s.business_key
    FROM source_keys AS s
    LEFT JOIN target_keys AS t
        ON s.record_id = t.record_id
    WHERE t.record_id IS NULL
)
SELECT *
FROM missing_keys
ORDER BY record_id;

-- Worked example 5: Validation report.
WITH invalid_orders AS (
    SELECT order_id AS record_id, 'INVALID_ORDER' AS issue_type
    FROM raw_orders
    WHERE customer_id IS NULL
       OR order_amount <= 0
),
orphan_payments AS (
    SELECT p.payment_id AS record_id, 'PAYMENT_WITHOUT_ORDER' AS issue_type
    FROM payments AS p
    LEFT JOIN raw_orders AS o
        ON p.order_id = o.order_id
    WHERE o.order_id IS NULL
),
source_target_mismatches AS (
    SELECT s.record_id, 'SOURCE_TARGET_MISMATCH' AS issue_type
    FROM source_records AS s
    JOIN target_records AS t
        ON s.record_id = t.record_id
    WHERE s.record_value <> t.record_value
       OR s.record_status <> t.record_status
       OR s.record_value IS NULL
       OR t.record_value IS NULL
)
SELECT record_id, issue_type
FROM invalid_orders
UNION ALL
SELECT record_id, issue_type
FROM orphan_payments
UNION ALL
SELECT record_id, issue_type
FROM source_target_mismatches
ORDER BY issue_type, record_id;

-- Debugging checklist:
-- 1. Run each inner SELECT separately.
-- 2. Inspect row counts.
-- 3. Inspect nulls.
-- 4. Inspect duplicates.
-- 5. Validate keys.
-- 6. Reconcile totals.
-- 7. Confirm final filters.
-- 8. Confirm no unexpected row multiplication.
