-- Day 036: Multi-Rule Exception Queue
-- Purpose: Combine multiple exception families with UNION ALL.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Exception queries do not modify or correct data.

-- Query 1: combined queue across required fields, duplicates, and missing records.
WITH null_customer AS (
    SELECT
        'RECORD' AS exception_level,
        'SOURCE' AS stage_name,
        order_id AS entity_key,
        'REQUIRED_FIELD' AS issue_category,
        'NULL_CUSTOMER_ID' AS issue_type,
        'NON_NULL_CUSTOMER_ID' AS expected_value,
        'NULL' AS actual_value,
        NULL AS difference_value,
        'HIGH_REVIEW' AS severity,
        source_file,
        order_date AS record_date,
        'Customer ID is missing.' AS review_message
    FROM source_order_data
    WHERE customer_id IS NULL
),
duplicate_clean AS (
    SELECT
        'STAGE' AS exception_level,
        'CLEAN' AS stage_name,
        order_id AS entity_key,
        'DUPLICATE_KEY' AS issue_category,
        'DUPLICATE_ORDER_ID' AS issue_type,
        1 AS expected_value,
        COUNT(*) AS actual_value,
        COUNT(*) - 1 AS difference_value,
        'HIGH_REVIEW' AS severity,
        NULL AS source_file,
        NULL AS record_date,
        'Clean-order grain should be one row per order.' AS review_message
    FROM clean_order_data
    GROUP BY order_id
    HAVING COUNT(*) > 1
),
source_missing_clean AS (
    SELECT
        'RECORD' AS exception_level,
        'STAGE_TO_CLEAN' AS stage_name,
        s.order_id AS entity_key,
        'MISSING_RECORD' AS issue_category,
        'SOURCE_ORDER_MISSING_FROM_CLEAN' AS issue_type,
        'ORDER_PRESENT_IN_CLEAN_OR_EXCLUDED' AS expected_value,
        'ORDER_MISSING_FROM_CLEAN' AS actual_value,
        NULL AS difference_value,
        'REVIEW' AS severity,
        s.source_file,
        s.order_date AS record_date,
        'Source order is missing from clean output. Review documented exclusions.' AS review_message
    FROM source_order_data AS s
    LEFT JOIN clean_order_data AS c
        ON s.order_id = c.order_id
    WHERE c.order_id IS NULL
)
SELECT *
FROM null_customer
UNION ALL
SELECT *
FROM duplicate_clean
UNION ALL
SELECT *
FROM source_missing_clean
ORDER BY stage_name, issue_category, issue_type, entity_key;
