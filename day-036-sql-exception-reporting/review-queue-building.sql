-- Day 036: Review Queue Building
-- Purpose: Build an aligned review queue from a small set of exception rules.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Exception queries do not modify or correct data.

-- Query 1: aligned review queue with one row per issue.
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
negative_amount AS (
    SELECT
        'RECORD' AS exception_level,
        'SOURCE' AS stage_name,
        order_id AS entity_key,
        'VALUE_MISMATCH' AS issue_category,
        'NEGATIVE_ORDER_AMOUNT' AS issue_type,
        'NON_NEGATIVE_OR_DOCUMENTED_EXCEPTION' AS expected_value,
        order_amount AS actual_value,
        order_amount AS difference_value,
        'REVIEW' AS severity,
        source_file,
        order_date AS record_date,
        'Negative amount requires business-context review.' AS review_message
    FROM source_order_data
    WHERE order_amount < 0
)
SELECT *
FROM null_customer
UNION ALL
SELECT *
FROM negative_amount
ORDER BY severity, issue_type, entity_key;

-- Query 2: target-only clean records as review queue rows.
SELECT
    'RECORD' AS exception_level,
    'CLEAN' AS stage_name,
    c.order_id AS entity_key,
    'UNEXPECTED_RECORD' AS issue_category,
    'CLEAN_ONLY_ORDER' AS issue_type,
    'SOURCE_OR_DOCUMENTED_EXCEPTION' AS expected_value,
    'CLEAN_RECORD_ONLY' AS actual_value,
    NULL AS difference_value,
    'HIGH_REVIEW' AS severity,
    c.source_file,
    c.order_date AS record_date,
    'Clean order has no matching source record. Review lineage.' AS review_message
FROM clean_order_data AS c
LEFT JOIN source_order_data AS s
    ON c.order_id = s.order_id
WHERE s.order_id IS NULL
ORDER BY c.order_id;
