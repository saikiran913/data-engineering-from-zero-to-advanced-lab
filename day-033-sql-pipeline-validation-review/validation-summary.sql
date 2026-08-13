-- Day 033: Validation Summary
-- Purpose: Create compact evidence rows for validation sign-off review.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Validation queries do not modify source or target data.

-- Query 1: summary for core validation checks.
-- Each row describes a check, expected value, actual value, difference, status, and message.
WITH clean_duplicate_count AS (
    SELECT
        COUNT(*) AS issue_count
    FROM (
        SELECT order_id
        FROM clean_order_output
        GROUP BY order_id
        HAVING COUNT(*) > 1
    ) AS duplicate_keys
),
reporting_duplicate_count AS (
    SELECT
        COUNT(*) AS issue_count
    FROM (
        SELECT
            report_date,
            country_group
        FROM reporting_order_metrics
        GROUP BY
            report_date,
            country_group
        HAVING COUNT(*) > 1
    ) AS duplicate_report_keys
),
null_reporting_count AS (
    SELECT
        COUNT(*) AS issue_count
    FROM reporting_order_metrics
    WHERE completed_order_count IS NULL
       OR total_completed_amount IS NULL
       OR refund_order_count IS NULL
       OR total_refund_amount IS NULL
       OR pending_order_count IS NULL
),
accepted_review AS (
    SELECT
        COUNT(*) AS staged_count,
        SUM(CASE WHEN validation_status = 'ACCEPTED' THEN 1 ELSE 0 END) AS accepted_count,
        SUM(CASE WHEN validation_status = 'REVIEW' THEN 1 ELSE 0 END) AS review_count
    FROM staged_order_output
)
SELECT
    'CHECK001' AS check_id,
    'STAGE' AS stage_name,
    'ACCEPTED_REVIEW_RECONCILIATION' AS check_type,
    0 AS expected_value,
    staged_count - accepted_count - review_count AS actual_value,
    staged_count - accepted_count - review_count AS difference,
    CASE
        WHEN staged_count - accepted_count - review_count = 0 THEN 'PASS'
        ELSE 'REVIEW'
    END AS validation_status,
    'Accepted plus review should equal staged population.' AS review_message
FROM accepted_review
UNION ALL
SELECT
    'CHECK002',
    'CLEAN',
    'DUPLICATE_ORDER_ID',
    0,
    issue_count,
    issue_count,
    CASE WHEN issue_count = 0 THEN 'PASS' ELSE 'REVIEW' END,
    'Clean grain should be one row per order.'
FROM clean_duplicate_count
UNION ALL
SELECT
    'CHECK003',
    'REPORTING',
    'DUPLICATE_REPORTING_GRAIN',
    0,
    issue_count,
    issue_count,
    CASE WHEN issue_count = 0 THEN 'PASS' ELSE 'REVIEW' END,
    'Reporting grain should be one row per date and country group.'
FROM reporting_duplicate_count
UNION ALL
SELECT
    'CHECK004',
    'REPORTING',
    'NULL_REPORTING_METRIC',
    0,
    issue_count,
    issue_count,
    CASE WHEN issue_count = 0 THEN 'PASS' ELSE 'REVIEW' END,
    'Reporting metric columns should not be null.'
FROM null_reporting_count
ORDER BY
    check_id;

-- Query 2: rule catalog review.
SELECT
    rule_id,
    stage_name,
    check_type,
    check_name,
    expected_condition,
    severity,
    exception_output,
    validation_message
FROM validation_rule_catalog
ORDER BY
    rule_id;
