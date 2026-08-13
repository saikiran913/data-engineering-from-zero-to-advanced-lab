-- Day 035: Integrated Completeness Workflow
-- Purpose: Combine field, key, date, category, file, percentage, and exception checks.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Completeness queries do not modify or fabricate data.

-- Query 1: integrated completeness summary.
WITH required_field_issues AS (
    SELECT COUNT(*) AS issue_count
    FROM source_customer_orders
    WHERE customer_id IS NULL
       OR order_date IS NULL
       OR order_amount IS NULL
       OR country_group IS NULL
       OR country_group = ''
),
missing_clean_orders AS (
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
missing_source_files AS (
    SELECT COUNT(*) AS issue_count
    FROM expected_records_catalog AS e
    LEFT JOIN source_customer_orders AS s
        ON e.source_file = s.source_file
    WHERE e.expectation_type = 'SOURCE_FILE'
      AND e.stage_name = 'SOURCE'
      AND s.source_file IS NULL
)
SELECT
    'REQUIRED_FIELD_ISSUES' AS check_name,
    issue_count,
    CASE WHEN issue_count = 0 THEN 'PASS' ELSE 'REVIEW' END AS completeness_status
FROM required_field_issues
UNION ALL
SELECT
    'MISSING_EXPECTED_CLEAN_ORDERS',
    issue_count,
    CASE WHEN issue_count = 0 THEN 'PASS' ELSE 'REVIEW' END
FROM missing_clean_orders
UNION ALL
SELECT
    'MISSING_REPORT_DATES',
    issue_count,
    CASE WHEN issue_count = 0 THEN 'PASS' ELSE 'REVIEW' END
FROM missing_report_dates
UNION ALL
SELECT
    'MISSING_SOURCE_FILES',
    issue_count,
    CASE WHEN issue_count = 0 THEN 'PASS' ELSE 'REVIEW' END
FROM missing_source_files
ORDER BY
    check_name;

-- Query 2: integrated missing expected records.
SELECT
    e.expectation_type,
    e.expected_value,
    e.expected_date,
    e.country_group,
    e.source_file,
    e.review_note
FROM expected_records_catalog AS e
LEFT JOIN clean_customer_orders AS c
    ON e.expected_value = c.order_id
   AND e.expectation_type = 'ORDER_ID'
LEFT JOIN reporting_customer_orders AS r
    ON e.expected_date = r.report_date
   AND e.expectation_type = 'REPORT_DATE'
LEFT JOIN source_customer_orders AS s
    ON e.source_file = s.source_file
   AND e.expectation_type = 'SOURCE_FILE'
WHERE (e.expectation_type = 'ORDER_ID' AND c.order_id IS NULL)
   OR (e.expectation_type = 'REPORT_DATE' AND r.report_date IS NULL)
   OR (e.expectation_type = 'SOURCE_FILE' AND s.source_file IS NULL)
ORDER BY
    e.expectation_type,
    e.expectation_id;
