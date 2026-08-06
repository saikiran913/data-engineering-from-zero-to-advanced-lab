-- Day 031: Clean to Reporting Validation
-- Purpose: Validate reporting output built from clean orders.
-- Safety: Read-only SELECT examples only. No temporary or staging object is deployed automatically.

-- Clean source row count.
SELECT COUNT(*) AS clean_order_row_count
FROM clean_orders;

-- Reporting row count.
SELECT COUNT(*) AS reporting_row_count
FROM reporting_order_summary;

-- Reporting grain uniqueness.
SELECT
    report_date,
    country_group,
    COUNT(*) AS row_count
FROM reporting_order_summary
GROUP BY report_date, country_group
HAVING COUNT(*) > 1;

-- Total completed amount reconciliation.
SELECT
    (SELECT SUM(order_amount) FROM clean_orders WHERE order_status = 'COMPLETED') AS clean_completed_total,
    (SELECT SUM(total_completed_amount) FROM reporting_order_summary) AS reporting_completed_total;

-- Total refund amount reconciliation.
SELECT
    (SELECT SUM(order_amount) FROM clean_orders WHERE order_status IN ('REFUNDED', 'REFUND_REQUESTED')) AS clean_refund_total,
    (SELECT SUM(total_refund_amount) FROM reporting_order_summary) AS reporting_refund_total;

-- Completed order-count reconciliation.
SELECT
    (SELECT COUNT(*) FROM clean_orders WHERE order_status = 'COMPLETED') AS clean_completed_count,
    (SELECT SUM(completed_order_count) FROM reporting_order_summary) AS reporting_completed_count;

-- Refund order-count reconciliation.
SELECT
    (SELECT COUNT(*) FROM clean_orders WHERE order_status IN ('REFUNDED', 'REFUND_REQUESTED')) AS clean_refund_count,
    (SELECT SUM(refund_order_count) FROM reporting_order_summary) AS reporting_refund_count;

-- Date-boundary validation.
SELECT
    MIN(order_date) AS first_clean_order_date,
    MAX(order_date) AS latest_clean_order_date
FROM clean_orders;

SELECT
    MIN(report_date) AS first_report_date,
    MAX(report_date) AS latest_report_date
FROM reporting_order_summary;

-- Null reporting metrics.
SELECT
    report_date,
    country_group,
    completed_order_count,
    total_completed_amount
FROM reporting_order_summary
WHERE completed_order_count IS NULL
   OR total_completed_amount IS NULL;

-- Grouping-column validation.
SELECT
    country_group,
    COUNT(*) AS reporting_rows
FROM reporting_order_summary
GROUP BY country_group
ORDER BY country_group;

-- Reporting summary.
WITH duplicate_reporting AS (
    SELECT report_date, country_group
    FROM reporting_order_summary
    GROUP BY report_date, country_group
    HAVING COUNT(*) > 1
),
null_metrics AS (
    SELECT report_date, country_group
    FROM reporting_order_summary
    WHERE completed_order_count IS NULL
       OR total_completed_amount IS NULL
)
SELECT
    'REPORTING_GRAIN_DUPLICATES' AS check_name,
    COUNT(*) AS issue_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'REVIEW' END AS status,
    'Reporting should be one row per report date and country group.' AS review_message
FROM duplicate_reporting
UNION ALL
SELECT
    'NULL_REPORTING_METRICS',
    COUNT(*),
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'REVIEW' END,
    'Null reporting metrics should be reviewed before dashboard handoff.'
FROM null_metrics;
