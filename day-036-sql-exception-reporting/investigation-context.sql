-- Day 036: Investigation Context
-- Purpose: Add source lineage and audit fields to exception outputs.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Exception queries do not modify or correct data.

-- Query 1: source-to-clean amount mismatch with source and clean context.
SELECT
    'RECORD' AS exception_level,
    'STAGE_TO_CLEAN' AS stage_name,
    s.order_id AS entity_key,
    'VALUE_MISMATCH' AS issue_category,
    'ORDER_AMOUNT_MISMATCH' AS issue_type,
    s.order_amount AS expected_value,
    c.order_amount AS actual_value,
    c.order_amount - s.order_amount AS difference_value,
    'REVIEW' AS severity,
    s.source_file AS source_file,
    s.order_date AS record_date,
    s.extracted_at,
    c.cleaned_at,
    'Order amount differs between source and clean output.' AS review_message
FROM source_order_data AS s
INNER JOIN clean_order_data AS c
    ON s.order_id = c.order_id
WHERE s.order_amount <> c.order_amount;

-- Query 2: source-to-clean status mismatch with audit context.
SELECT
    'RECORD' AS exception_level,
    'STAGE_TO_CLEAN' AS stage_name,
    s.order_id AS entity_key,
    'STATUS_MISMATCH' AS issue_category,
    'ORDER_STATUS_MISMATCH' AS issue_type,
    s.order_status AS expected_value,
    c.order_status AS actual_value,
    NULL AS difference_value,
    'REVIEW' AS severity,
    s.source_file AS source_file,
    s.order_date AS record_date,
    s.extracted_at,
    c.cleaned_at,
    'Order status differs between source and clean output.' AS review_message
FROM source_order_data AS s
INNER JOIN clean_order_data AS c
    ON s.order_id = c.order_id
WHERE s.order_status <> c.order_status;

-- Query 3: reporting exception with reporting loaded timestamp.
SELECT
    'METRIC' AS exception_level,
    'REPORTING' AS stage_name,
    report_date || '|' || country_group AS entity_key,
    'REQUIRED_FIELD' AS issue_category,
    'NULL_REPORTING_METRIC' AS issue_type,
    'NON_NULL_METRIC' AS expected_value,
    'NULL_METRIC_PRESENT' AS actual_value,
    NULL AS difference_value,
    'HIGH_REVIEW' AS severity,
    NULL AS source_file,
    report_date AS record_date,
    reporting_loaded_at,
    'Reporting metric is null. Review reporting aggregation.' AS review_message
FROM reporting_order_data
WHERE total_completed_amount IS NULL;
