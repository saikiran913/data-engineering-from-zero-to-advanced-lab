-- Day 030: Interface Validation Queries
-- Purpose: Validate row counts, grain, keys, nulls, totals, dates, consumers, freshness, and audit fields.
-- Safety: Non-destructive examples only. No table or view is deployed automatically.

-- Row-count validation.
SELECT 'clean_customers' AS interface_name, COUNT(*) AS row_count
FROM clean_customers;

-- Grain validation: one row per customer.
SELECT
    customer_id,
    COUNT(*) AS row_count
FROM clean_customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Key uniqueness: daily sales should be one row per region-date.
SELECT
    report_date,
    region,
    COUNT(*) AS row_count
FROM daily_sales_reporting
GROUP BY report_date, region
HAVING COUNT(*) > 1;

-- Null critical columns.
SELECT
    customer_id,
    country,
    customer_status
FROM clean_customers
WHERE country IS NULL
   OR customer_status IS NULL;

-- Total reconciliation: completed order total.
SELECT
    SUM(order_amount) AS completed_order_total
FROM order_transactions
WHERE customer_id IS NOT NULL
  AND order_status = 'COMPLETED'
  AND order_amount > 0;

-- Date-range validation.
SELECT
    MIN(report_date) AS first_report_date,
    MAX(report_date) AS latest_report_date
FROM daily_sales_reporting;

-- Status-distribution validation.
SELECT
    order_status,
    COUNT(*) AS row_count,
    SUM(order_amount) AS status_amount
FROM order_transactions
GROUP BY order_status
ORDER BY order_status;

-- Source-to-interface reconciliation.
SELECT
    'raw_customer_events' AS interface_name,
    COUNT(*) AS row_count
FROM raw_customer_events
UNION ALL
SELECT
    'clean_customers',
    COUNT(*)
FROM clean_customers;

-- Consumer-required-column review is documented in interface_consumers.
SELECT
    consumer_name,
    required_interface,
    required_columns,
    expected_grain
FROM interface_consumers
ORDER BY required_interface, consumer_name;

-- Freshness review.
SELECT
    required_interface,
    freshness_need,
    COUNT(*) AS consumer_count
FROM interface_consumers
GROUP BY required_interface, freshness_need
ORDER BY required_interface;

-- Audit-column review.
SELECT
    event_id,
    received_at,
    source_file
FROM raw_customer_events
WHERE received_at IS NULL
   OR source_file IS NULL;

-- Combined validation summary.
WITH duplicate_customers AS (
    SELECT customer_id
    FROM clean_customers
    GROUP BY customer_id
    HAVING COUNT(*) > 1
),
duplicate_reporting AS (
    SELECT report_date, region
    FROM daily_sales_reporting
    GROUP BY report_date, region
    HAVING COUNT(*) > 1
),
null_reporting AS (
    SELECT report_date, region
    FROM daily_sales_reporting
    WHERE total_sales IS NULL
)
SELECT
    'clean_customers' AS interface_name,
    'DUPLICATE_CUSTOMER_IDS' AS check_name,
    COUNT(*) AS issue_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'REVIEW' END AS status,
    'Clean customer interface should be one row per customer.' AS review_message
FROM duplicate_customers
UNION ALL
SELECT
    'daily_sales_reporting',
    'DUPLICATE_REGION_DATE',
    COUNT(*),
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'REVIEW' END,
    'Daily reporting interface should be one row per region-date.'
FROM duplicate_reporting
UNION ALL
SELECT
    'daily_sales_reporting',
    'NULL_TOTAL_SALES',
    COUNT(*),
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'REVIEW' END,
    'Reporting metrics should be reviewed when null.'
FROM null_reporting;
