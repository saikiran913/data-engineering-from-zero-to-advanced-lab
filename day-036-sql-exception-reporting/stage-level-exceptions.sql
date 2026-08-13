-- Day 036: Stage-Level Exceptions
-- Purpose: Create exception rows for stage and population-level issues.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Exception queries do not modify or correct data.

-- Query 1: duplicate clean key as a stage-level grain issue.
WITH duplicate_orders AS (
    SELECT
        order_id,
        COUNT(*) AS row_count
    FROM clean_order_data
    GROUP BY order_id
    HAVING COUNT(*) > 1
)
SELECT
    'STAGE' AS exception_level,
    'CLEAN' AS stage_name,
    order_id AS entity_key,
    'DUPLICATE_KEY' AS issue_category,
    'DUPLICATE_ORDER_ID' AS issue_type,
    1 AS expected_value,
    row_count AS actual_value,
    row_count - 1 AS difference_value,
    'HIGH_REVIEW' AS severity,
    NULL AS source_file,
    NULL AS record_date,
    'Clean-order grain should be one row per order.' AS review_message
FROM duplicate_orders;

-- Query 2: duplicate reporting grain.
WITH duplicate_reporting AS (
    SELECT
        report_date,
        country_group,
        COUNT(*) AS row_count
    FROM reporting_order_data
    GROUP BY report_date, country_group
    HAVING COUNT(*) > 1
)
SELECT
    'STAGE' AS exception_level,
    'REPORTING' AS stage_name,
    report_date || '|' || country_group AS entity_key,
    'REPORTING_GRAIN' AS issue_category,
    'DUPLICATE_REPORTING_KEY' AS issue_type,
    1 AS expected_value,
    row_count AS actual_value,
    row_count - 1 AS difference_value,
    'HIGH_REVIEW' AS severity,
    NULL AS source_file,
    report_date AS record_date,
    'Reporting grain should be one row per date and country group.' AS review_message
FROM duplicate_reporting;

-- Query 3: expected reporting group missing.
SELECT
    'STAGE' AS exception_level,
    'REPORTING' AS stage_name,
    e.report_date || '|' || e.country_group AS entity_key,
    'DATE_COVERAGE' AS issue_category,
    'MISSING_REPORTING_GROUP' AS issue_type,
    'GROUP_PRESENT' AS expected_value,
    'GROUP_MISSING' AS actual_value,
    NULL AS difference_value,
    'REVIEW' AS severity,
    NULL AS source_file,
    e.report_date AS record_date,
    'Expected reporting date-country group is missing.' AS review_message
FROM expected_reporting_catalog AS e
LEFT JOIN reporting_order_data AS r
    ON e.report_date = r.report_date
   AND e.country_group = r.country_group
WHERE e.expected_presence = 'Yes'
  AND r.report_date IS NULL;
