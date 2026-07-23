-- Day 023: CTE Clean-Layer Patterns
-- Topic: Model safe clean-layer transformations without changing source data.
-- Safety note: every query in this file is read-only.

-- Pattern 1 and 2: Filter invalid raw orders and keep latest order version.
WITH ranked_orders AS (
    SELECT
        order_id,
        customer_id,
        order_date,
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
valid_raw_orders AS (
    SELECT *
    FROM latest_orders
    WHERE customer_id IS NOT NULL
      AND order_amount > 0
      AND order_status IN ('COMPLETED', 'PENDING')
)
SELECT
    order_id,
    customer_id,
    order_date,
    order_status,
    order_amount,
    updated_at,
    source_file
FROM valid_raw_orders
ORDER BY order_id;

-- Pattern 3 and 4: Standardise status labels and create business-ready output.
WITH latest_orders AS (
    SELECT
        order_id,
        customer_id,
        order_date,
        order_status,
        order_amount,
        updated_at,
        source_file
    FROM raw_orders
),
business_ready_orders AS (
    SELECT
        order_id,
        customer_id,
        order_date,
        CASE
            WHEN order_status = 'COMPLETED' THEN 'COMPLETE'
            WHEN order_status = 'PENDING' THEN 'IN_PROGRESS'
            WHEN order_status = 'CANCELLED' THEN 'CANCELLED'
            WHEN order_status = 'REFUNDED' THEN 'REFUNDED'
            ELSE 'REVIEW'
        END AS standardised_status,
        order_amount,
        updated_at,
        source_file
    FROM latest_orders
    WHERE customer_id IS NOT NULL
      AND order_amount > 0
)
SELECT *
FROM business_ready_orders
ORDER BY order_id;

-- Pattern 5: Create customer sales summary.
WITH valid_orders AS (
    SELECT order_id, customer_id, order_amount
    FROM raw_orders
    WHERE customer_id IS NOT NULL
      AND order_status = 'COMPLETED'
      AND order_amount > 0
),
customer_sales_summary AS (
    SELECT
        c.customer_id,
        c.customer_name,
        c.country,
        COUNT(v.order_id) AS order_count,
        SUM(v.order_amount) AS total_order_value
    FROM customers AS c
    JOIN valid_orders AS v
        ON c.customer_id = v.customer_id
    GROUP BY c.customer_id, c.customer_name, c.country
)
SELECT *
FROM customer_sales_summary
ORDER BY total_order_value DESC;

-- Pattern 6: Preserve rejected records separately as a review queue.
WITH accepted_records AS (
    SELECT order_id, customer_id, order_amount, source_file
    FROM raw_orders
    WHERE customer_id IS NOT NULL
      AND order_amount > 0
),
rejected_records AS (
    SELECT
        order_id,
        customer_id,
        order_amount,
        source_file,
        CASE
            WHEN customer_id IS NULL THEN 'MISSING_CUSTOMER_ID'
            WHEN order_amount <= 0 THEN 'NON_POSITIVE_AMOUNT'
            ELSE 'REVIEW'
        END AS issue_type
    FROM raw_orders
    WHERE customer_id IS NULL
       OR order_amount <= 0
)
SELECT
    order_id AS record_id,
    issue_type,
    'Review rejected raw order' AS suggested_action,
    source_file
FROM rejected_records
ORDER BY record_id;

-- Pattern 7: Add validation metrics.
WITH source_metrics AS (
    SELECT COUNT(*) AS source_count
    FROM raw_orders
),
accepted_metrics AS (
    SELECT COUNT(*) AS accepted_count
    FROM raw_orders
    WHERE customer_id IS NOT NULL
      AND order_amount > 0
),
rejected_metrics AS (
    SELECT COUNT(*) AS rejected_count
    FROM raw_orders
    WHERE customer_id IS NULL
       OR order_amount <= 0
),
duplicate_metrics AS (
    SELECT COUNT(*) AS duplicate_order_groups
    FROM (
        SELECT order_id
        FROM raw_orders
        GROUP BY order_id
        HAVING COUNT(*) > 1
    ) AS duplicate_groups
)
SELECT
    s.source_count,
    a.accepted_count,
    r.rejected_count,
    d.duplicate_order_groups
FROM source_metrics AS s
JOIN accepted_metrics AS a
    ON 1 = 1
JOIN rejected_metrics AS r
    ON 1 = 1
JOIN duplicate_metrics AS d
    ON 1 = 1;

-- A real pipeline may write clean and rejected records into tables.
-- Day 023 keeps the learning workflow read-only.
