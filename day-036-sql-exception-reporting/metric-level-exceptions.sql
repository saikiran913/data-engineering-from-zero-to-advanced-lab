-- Day 036: Metric-Level Exceptions
-- Purpose: Create exception rows for totals and reporting metric mismatches.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Exception queries do not modify or correct data.

-- Query 1: completed amount mismatch.
-- Exception level: METRIC.
-- Stage: REPORTING.
-- Entity key: COMPLETED_AMOUNT_TOTAL.
-- Issue category: CONTROL_TOTAL.
-- Issue type: COMPLETED_AMOUNT_MISMATCH.
-- Severity: HIGH_REVIEW because completed totals drive reporting trust.
WITH clean_completed AS (
    SELECT
        SUM(order_amount) AS completed_amount
    FROM clean_order_data
    WHERE order_status = 'COMPLETED'
),
reporting_completed AS (
    SELECT
        SUM(total_completed_amount) AS completed_amount
    FROM reporting_order_data
)
SELECT
    'METRIC' AS exception_level,
    'REPORTING' AS stage_name,
    'COMPLETED_AMOUNT_TOTAL' AS entity_key,
    'CONTROL_TOTAL' AS issue_category,
    'COMPLETED_AMOUNT_MISMATCH' AS issue_type,
    c.completed_amount AS expected_value,
    r.completed_amount AS actual_value,
    r.completed_amount - c.completed_amount AS difference_value,
    'HIGH_REVIEW' AS severity,
    NULL AS source_file,
    NULL AS record_date,
    'Completed amount differs between clean and reporting outputs.' AS review_message
FROM clean_completed AS c
CROSS JOIN reporting_completed AS r
WHERE c.completed_amount <> r.completed_amount;

-- Query 2: null reporting metric exceptions.
SELECT
    'METRIC' AS exception_level,
    'REPORTING' AS stage_name,
    report_date || '|' || country_group AS entity_key,
    'REQUIRED_FIELD' AS issue_category,
    'NULL_REPORTING_METRIC' AS issue_type,
    'NON_NULL_METRICS' AS expected_value,
    'NULL_METRIC_PRESENT' AS actual_value,
    NULL AS difference_value,
    'HIGH_REVIEW' AS severity,
    NULL AS source_file,
    report_date AS record_date,
    'Reporting metric columns should be populated for reviewable output.' AS review_message
FROM reporting_order_data
WHERE completed_order_count IS NULL
   OR total_completed_amount IS NULL
   OR refund_order_count IS NULL
   OR total_refund_amount IS NULL
   OR pending_order_count IS NULL;

-- Query 3: grouped reporting mismatch.
WITH clean_grouped AS (
    SELECT
        order_date AS report_date,
        country_group,
        SUM(CASE WHEN order_status = 'COMPLETED' THEN order_amount ELSE 0 END)
            AS completed_amount
    FROM clean_order_data
    GROUP BY order_date, country_group
),
report_grouped AS (
    SELECT
        report_date,
        country_group,
        SUM(total_completed_amount) AS completed_amount
    FROM reporting_order_data
    GROUP BY report_date, country_group
)
SELECT
    'METRIC' AS exception_level,
    'REPORTING' AS stage_name,
    c.report_date || '|' || c.country_group AS entity_key,
    'CONTROL_TOTAL' AS issue_category,
    'GROUPED_COMPLETED_AMOUNT_MISMATCH' AS issue_type,
    c.completed_amount AS expected_value,
    r.completed_amount AS actual_value,
    r.completed_amount - c.completed_amount AS difference_value,
    'REVIEW' AS severity,
    NULL AS source_file,
    c.report_date AS record_date,
    'Grouped completed amount differs between clean and reporting.' AS review_message
FROM clean_grouped AS c
LEFT JOIN report_grouped AS r
    ON c.report_date = r.report_date
   AND c.country_group = r.country_group
WHERE r.completed_amount IS NULL
   OR c.completed_amount <> r.completed_amount;
