-- Day 030: Raw, Clean, and Reporting Layers
-- Purpose: Review layer thinking using raw events, clean customers, orders, and reporting rows.
-- Safety: Non-destructive examples only. No table or view is deployed automatically.

-- Raw layer: preserve delivered source events and audit fields.
SELECT
    event_id,
    customer_id,
    event_type,
    event_timestamp,
    received_at,
    source_file
FROM raw_customer_events
ORDER BY event_id, received_at;

-- Raw investigation: repeated deliveries.
SELECT
    event_id,
    COUNT(*) AS delivery_count
FROM raw_customer_events
GROUP BY event_id
HAVING COUNT(*) > 1;

-- Clean layer: one row per customer.
SELECT
    customer_id,
    customer_name,
    country,
    customer_status,
    updated_at,
    source_file
FROM clean_customers;

-- Cleaned order logic using a CTE.
WITH valid_orders AS (
    SELECT
        order_id,
        customer_id,
        order_date,
        order_amount,
        updated_at,
        source_file
    FROM order_transactions
    WHERE customer_id IS NOT NULL
      AND order_amount > 0
      AND order_status = 'COMPLETED'
)
SELECT
    order_id,
    customer_id,
    order_amount,
    updated_at,
    source_file
FROM valid_orders;

-- Reporting layer: one row per region-date.
SELECT
    report_date,
    region,
    total_orders,
    total_sales,
    total_refunds,
    reporting_loaded_at
FROM daily_sales_reporting
ORDER BY report_date, region;

-- Raw-to-clean conceptual flow using CTEs.
WITH ranked_events AS (
    SELECT
        event_id,
        customer_id,
        event_type,
        event_timestamp,
        event_value,
        received_at,
        source_file,
        ROW_NUMBER() OVER (
            PARTITION BY event_id
            ORDER BY received_at DESC, source_file DESC
        ) AS row_num
    FROM raw_customer_events
)
SELECT
    event_id,
    customer_id,
    event_type,
    event_timestamp,
    event_value,
    received_at,
    source_file
FROM ranked_events
WHERE row_num = 1;

-- Clean-to-reporting conceptual flow.
WITH valid_orders AS (
    SELECT
        order_date,
        customer_id,
        order_amount
    FROM order_transactions
    WHERE customer_id IS NOT NULL
      AND order_status = 'COMPLETED'
      AND order_amount > 0
),
daily_customer_sales AS (
    SELECT
        order_date,
        COUNT(*) AS completed_order_count,
        SUM(order_amount) AS completed_order_amount
    FROM valid_orders
    GROUP BY order_date
)
SELECT
    order_date,
    completed_order_count,
    completed_order_amount
FROM daily_customer_sales
ORDER BY order_date;

-- Exception outputs: review invalid orders rather than removing source rows.
SELECT
    order_id AS entity_key,
    'ORDER_REVIEW' AS issue_type,
    order_amount AS issue_value,
    'Null customer or invalid amount should be reviewed.' AS review_message
FROM order_transactions
WHERE customer_id IS NULL
   OR order_amount <= 0;

-- Validation summary.
WITH valid_orders AS (
    SELECT order_id
    FROM order_transactions
    WHERE customer_id IS NOT NULL
      AND order_amount > 0
      AND order_status = 'COMPLETED'
),
review_orders AS (
    SELECT order_id
    FROM order_transactions
    WHERE customer_id IS NULL
       OR order_amount <= 0
),
duplicate_customers AS (
    SELECT customer_id
    FROM clean_customers
    GROUP BY customer_id
    HAVING COUNT(*) > 1
)
SELECT
    'RAW_EVENT_COUNT' AS check_name,
    COUNT(*) AS check_value
FROM raw_customer_events
UNION ALL
SELECT 'ACCEPTED_ORDER_COUNT', COUNT(*) FROM valid_orders
UNION ALL
SELECT 'REVIEW_ORDER_COUNT', COUNT(*) FROM review_orders
UNION ALL
SELECT 'CLEAN_CUSTOMER_KEY_ISSUES', COUNT(*) FROM duplicate_customers
UNION ALL
SELECT 'REPORTING_ROW_COUNT', COUNT(*) FROM daily_sales_reporting;
