-- Day 035: Completeness Summary
-- Purpose: Build compact completeness validation evidence.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Completeness queries do not modify or fabricate data.

-- Query 1: summary checks.
WITH source_missing_customer AS (
    SELECT COUNT(*) AS issue_count
    FROM source_customer_orders
    WHERE customer_id IS NULL
),
missing_expected_clean AS (
    SELECT COUNT(*) AS issue_count
    FROM expected_records_catalog AS e
    LEFT JOIN clean_customer_orders AS c
        ON e.expected_value = c.order_id
    WHERE e.expectation_type = 'ORDER_ID'
      AND e.stage_name = 'CLEAN'
      AND c.order_id IS NULL
),
missing_report_dates AS (
    SELECT COUNT(*) AS issue_count
    FROM expected_records_catalog AS e
    LEFT JOIN reporting_customer_orders AS r
        ON e.expected_date = r.report_date
    WHERE e.expectation_type = 'REPORT_DATE'
      AND r.report_date IS NULL
),
null_report_metrics AS (
    SELECT COUNT(*) AS issue_count
    FROM reporting_customer_orders
    WHERE completed_order_count IS NULL
       OR total_completed_amount IS NULL
       OR refund_order_count IS NULL
       OR total_refund_amount IS NULL
       OR pending_order_count IS NULL
)
SELECT
    'COMP001' AS check_id,
    'SOURCE' AS stage_name,
    'REQUIRED_CUSTOMER_ID' AS check_name,
    issue_count,
    CASE WHEN issue_count = 0 THEN 'PASS' ELSE 'REVIEW' END AS completeness_status
FROM source_missing_customer
UNION ALL
SELECT
    'COMP002',
    'CLEAN',
    'EXPECTED_CLEAN_ORDERS',
    issue_count,
    CASE WHEN issue_count = 0 THEN 'PASS' ELSE 'REVIEW' END
FROM missing_expected_clean
UNION ALL
SELECT
    'COMP003',
    'REPORTING',
    'EXPECTED_REPORT_DATES',
    issue_count,
    CASE WHEN issue_count = 0 THEN 'PASS' ELSE 'REVIEW' END
FROM missing_report_dates
UNION ALL
SELECT
    'COMP004',
    'REPORTING',
    'NULL_REPORTING_METRICS',
    issue_count,
    CASE WHEN issue_count = 0 THEN 'PASS' ELSE 'REVIEW' END
FROM null_report_metrics
ORDER BY
    check_id;

-- Query 2: completeness rule catalogue.
SELECT
    rule_id,
    stage_name,
    completeness_type,
    field_or_population,
    expected_condition,
    severity,
    review_message
FROM completeness_rules
ORDER BY
    rule_id;
