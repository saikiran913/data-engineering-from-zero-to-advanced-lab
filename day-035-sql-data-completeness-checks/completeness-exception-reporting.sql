-- Day 035: Completeness Exception Reporting
-- Purpose: Preserve completeness gaps for investigation.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Completeness queries do not modify or fabricate data.

-- Query 1: combined completeness exception queue.
WITH missing_expected_clean AS (
    SELECT
        e.expected_value AS entity_key,
        'EXPECTED_CLEAN_ORDER_MISSING' AS issue_type,
        e.review_note AS review_message
    FROM expected_records_catalog AS e
    LEFT JOIN clean_customer_orders AS c
        ON e.expected_value = c.order_id
    WHERE e.expectation_type = 'ORDER_ID'
      AND e.stage_name = 'CLEAN'
      AND c.order_id IS NULL
),
missing_dates AS (
    SELECT
        e.expected_date AS entity_key,
        'EXPECTED_REPORT_DATE_MISSING' AS issue_type,
        e.review_note AS review_message
    FROM expected_records_catalog AS e
    LEFT JOIN reporting_customer_orders AS r
        ON e.expected_date = r.report_date
    WHERE e.expectation_type = 'REPORT_DATE'
      AND r.report_date IS NULL
),
missing_files AS (
    SELECT
        e.source_file AS entity_key,
        'EXPECTED_SOURCE_FILE_MISSING' AS issue_type,
        e.review_note AS review_message
    FROM expected_records_catalog AS e
    LEFT JOIN source_customer_orders AS s
        ON e.source_file = s.source_file
    WHERE e.expectation_type = 'SOURCE_FILE'
      AND e.stage_name = 'SOURCE'
      AND s.source_file IS NULL
)
SELECT
    'CLEAN' AS stage_name,
    entity_key,
    issue_type,
    'HIGH_REVIEW' AS severity,
    review_message
FROM missing_expected_clean
UNION ALL
SELECT
    'REPORTING',
    entity_key,
    issue_type,
    'HIGH_REVIEW',
    review_message
FROM missing_dates
UNION ALL
SELECT
    'SOURCE',
    entity_key,
    issue_type,
    'HIGH_REVIEW',
    review_message
FROM missing_files
ORDER BY
    stage_name,
    issue_type,
    entity_key;

-- Query 2: null reporting metric exceptions.
SELECT
    'REPORTING' AS stage_name,
    report_date,
    country_group,
    'NULL_REPORTING_METRIC' AS issue_type,
    'HIGH_REVIEW' AS severity,
    reporting_loaded_at
FROM reporting_customer_orders
WHERE completed_order_count IS NULL
   OR total_completed_amount IS NULL
   OR refund_order_count IS NULL
   OR total_refund_amount IS NULL
   OR pending_order_count IS NULL
ORDER BY
    report_date,
    country_group;
