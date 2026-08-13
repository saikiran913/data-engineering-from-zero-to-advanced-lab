-- Day 036: Integrated Exception Workflow
-- Purpose: Build a combined review queue and summary from several exception families.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Exception queries do not modify or correct data.

-- Query 1: integrated review queue.
WITH null_customer AS (
    SELECT 'RECORD' AS exception_level, 'SOURCE' AS stage_name, order_id AS entity_key, 'REQUIRED_FIELD' AS issue_category, 'NULL_CUSTOMER_ID' AS issue_type, 'NON_NULL_CUSTOMER_ID' AS expected_value, 'NULL' AS actual_value, NULL AS difference_value, 'HIGH_REVIEW' AS severity, source_file, order_date AS record_date, 'Customer ID is missing.' AS review_message
    FROM source_order_data
    WHERE customer_id IS NULL
),
duplicate_clean AS (
    SELECT 'STAGE' AS exception_level, 'CLEAN' AS stage_name, order_id AS entity_key, 'DUPLICATE_KEY' AS issue_category, 'DUPLICATE_ORDER_ID' AS issue_type, 1 AS expected_value, COUNT(*) AS actual_value, COUNT(*) - 1 AS difference_value, 'HIGH_REVIEW' AS severity, NULL AS source_file, NULL AS record_date, 'Clean-order grain should be one row per order.' AS review_message
    FROM clean_order_data
    GROUP BY order_id
    HAVING COUNT(*) > 1
),
target_only AS (
    SELECT 'RECORD' AS exception_level, 'CLEAN' AS stage_name, c.order_id AS entity_key, 'UNEXPECTED_RECORD' AS issue_category, 'CLEAN_ONLY_ORDER' AS issue_type, 'SOURCE_RECORD' AS expected_value, 'CLEAN_ONLY_RECORD' AS actual_value, NULL AS difference_value, 'HIGH_REVIEW' AS severity, c.source_file, c.order_date AS record_date, 'Clean order has no matching source record.' AS review_message
    FROM clean_order_data AS c
    LEFT JOIN source_order_data AS s
        ON c.order_id = s.order_id
    WHERE s.order_id IS NULL
)
SELECT *
FROM null_customer
UNION ALL
SELECT *
FROM duplicate_clean
UNION ALL
SELECT *
FROM target_only
ORDER BY severity, stage_name, issue_type, entity_key;

-- Query 2: integrated summary.
WITH exception_queue AS (
    SELECT 'SOURCE' AS stage_name, order_id AS entity_key, 'REQUIRED_FIELD' AS issue_category, 'NULL_CUSTOMER_ID' AS issue_type, 'HIGH_REVIEW' AS severity
    FROM source_order_data
    WHERE customer_id IS NULL
    UNION ALL
    SELECT 'CLEAN', order_id, 'DUPLICATE_KEY', 'DUPLICATE_ORDER_ID', 'HIGH_REVIEW'
    FROM clean_order_data
    GROUP BY order_id
    HAVING COUNT(*) > 1
)
SELECT
    stage_name,
    issue_category,
    issue_type,
    severity,
    COUNT(*) AS exception_row_count,
    COUNT(DISTINCT entity_key) AS affected_entity_count
FROM exception_queue
GROUP BY stage_name, issue_category, issue_type, severity
ORDER BY stage_name, issue_category, issue_type;
