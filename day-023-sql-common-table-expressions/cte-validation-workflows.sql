-- Day 023: CTE Validation Workflows
-- Topic: Use named steps for data-quality review.
-- Safety note: every query in this file is read-only.
-- Validation output should be reviewed before business decisions are made.

-- Validation 1: Invalid orders.
WITH invalid_orders AS (
    SELECT
        order_id,
        CASE
            WHEN customer_id IS NULL THEN 'MISSING_CUSTOMER_ID'
            WHEN order_amount <= 0 THEN 'NON_POSITIVE_AMOUNT'
            WHEN order_status NOT IN ('COMPLETED', 'PENDING', 'CANCELLED', 'REFUNDED') THEN 'INVALID_STATUS'
            ELSE 'REVIEW'
        END AS issue_type,
        source_file
    FROM raw_orders
    WHERE customer_id IS NULL
       OR order_amount <= 0
       OR order_status NOT IN ('COMPLETED', 'PENDING', 'CANCELLED', 'REFUNDED')
)
SELECT *
FROM invalid_orders
ORDER BY order_id;

-- Validation 2: Orders without customers.
WITH valid_customer_keys AS (
    SELECT customer_id
    FROM customers
),
unmatched_orders AS (
    SELECT o.order_id, o.customer_id, o.source_file
    FROM raw_orders AS o
    LEFT JOIN valid_customer_keys AS c
        ON o.customer_id = c.customer_id
    WHERE o.customer_id IS NOT NULL
      AND c.customer_id IS NULL
)
SELECT *
FROM unmatched_orders
ORDER BY order_id;

-- Validation 3: Payments without orders.
WITH order_keys AS (
    SELECT DISTINCT order_id
    FROM raw_orders
),
orphan_payments AS (
    SELECT p.payment_id, p.order_id, p.payment_amount
    FROM payments AS p
    LEFT JOIN order_keys AS o
        ON p.order_id = o.order_id
    WHERE o.order_id IS NULL
)
SELECT *
FROM orphan_payments
ORDER BY payment_id;

-- Validation 4: Orders without successful payments.
WITH successful_payment_orders AS (
    SELECT DISTINCT order_id
    FROM payments
    WHERE payment_status = 'SUCCESS'
),
orders_without_success AS (
    SELECT o.order_id, o.customer_id, o.order_amount
    FROM raw_orders AS o
    LEFT JOIN successful_payment_orders AS p
        ON o.order_id = p.order_id
    WHERE o.order_status = 'COMPLETED'
      AND o.order_amount > 0
      AND p.order_id IS NULL
)
SELECT *
FROM orders_without_success
ORDER BY order_id;

-- Validation 5: Duplicate order versions.
WITH order_version_counts AS (
    SELECT order_id, COUNT(*) AS version_count
    FROM raw_orders
    GROUP BY order_id
    HAVING COUNT(*) > 1
)
SELECT *
FROM order_version_counts
ORDER BY order_id;

-- Validation 6: Null critical fields.
WITH null_critical_fields AS (
    SELECT order_id, 'CUSTOMER_ID' AS field_name, source_file
    FROM raw_orders
    WHERE customer_id IS NULL
    UNION ALL
    SELECT order_id, 'ORDER_DATE' AS field_name, source_file
    FROM raw_orders
    WHERE order_date IS NULL
)
SELECT *
FROM null_critical_fields
ORDER BY order_id, field_name;

-- Validation 7: Daily sales anomalies.
WITH sales_anomalies AS (
    SELECT
        sale_date,
        product_id,
        customer_id,
        CASE
            WHEN product_id IS NULL THEN 'MISSING_PRODUCT'
            WHEN customer_id IS NULL THEN 'MISSING_CUSTOMER'
            WHEN quantity <= 0 THEN 'NON_POSITIVE_QUANTITY'
            WHEN sales_amount < 0 THEN 'NEGATIVE_AMOUNT'
            ELSE 'REVIEW'
        END AS issue_type
    FROM daily_sales
    WHERE product_id IS NULL
       OR customer_id IS NULL
       OR quantity <= 0
       OR sales_amount < 0
)
SELECT *
FROM sales_anomalies
ORDER BY sale_date, product_id;

-- Validation 8: Count reconciliation.
WITH source_count AS (
    SELECT COUNT(*) AS source_row_count
    FROM source_records
),
target_count AS (
    SELECT COUNT(*) AS target_row_count
    FROM target_records
)
SELECT
    s.source_row_count,
    t.target_row_count,
    s.source_row_count - t.target_row_count AS count_difference
FROM source_count AS s
JOIN target_count AS t
    ON 1 = 1;

-- Validation 9: Total reconciliation.
WITH source_total AS (
    SELECT SUM(record_value) AS source_value_total
    FROM source_records
),
target_total AS (
    SELECT SUM(record_value) AS target_value_total
    FROM target_records
)
SELECT
    s.source_value_total,
    t.target_value_total,
    s.source_value_total - t.target_value_total AS total_difference
FROM source_total AS s
JOIN target_total AS t
    ON 1 = 1;

-- Validation 10: Exception queue.
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
exception_queue AS (
    SELECT
        'ORDER_VALIDATION' AS validation_name,
        record_id,
        issue_type,
        'Review source data before clean-layer use' AS issue_description,
        'Check source file, key, and business rule' AS suggested_action
    FROM invalid_orders
    UNION ALL
    SELECT
        'PAYMENT_VALIDATION' AS validation_name,
        record_id,
        issue_type,
        'Payment references an unknown order' AS issue_description,
        'Confirm order extract completeness' AS suggested_action
    FROM orphan_payments
)
SELECT *
FROM exception_queue
ORDER BY validation_name, record_id;
