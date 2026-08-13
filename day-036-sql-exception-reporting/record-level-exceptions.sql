-- Day 036: Record-Level Exceptions
-- Purpose: Create investigation-friendly row-level exception outputs.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Exception queries do not modify or correct data.

-- Query 1: null customer ID exceptions.
-- Exception level: RECORD.
-- Stage: SOURCE.
-- Entity key: order_id.
-- Issue category: REQUIRED_FIELD.
-- Issue type: NULL_CUSTOMER_ID.
-- Severity: HIGH_REVIEW because customer_id is required by this lesson rule.
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
    'Customer ID is required for this source-order population.' AS review_message
FROM source_order_data
WHERE customer_id IS NULL;

-- Query 2: null amount exceptions.
SELECT
    'RECORD' AS exception_level,
    'SOURCE' AS stage_name,
    order_id AS entity_key,
    'REQUIRED_FIELD' AS issue_category,
    'NULL_ORDER_AMOUNT' AS issue_type,
    'NON_NULL_ORDER_AMOUNT' AS expected_value,
    'NULL' AS actual_value,
    NULL AS difference_value,
    'HIGH_REVIEW' AS severity,
    source_file,
    order_date AS record_date,
    'Order amount is required before downstream amount checks.' AS review_message
FROM source_order_data
WHERE order_amount IS NULL;

-- Query 3: negative amount exceptions.
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
WHERE order_amount < 0;

-- Query 4: unsupported status exceptions.
SELECT
    'RECORD' AS exception_level,
    'SOURCE' AS stage_name,
    order_id AS entity_key,
    'STATUS_MISMATCH' AS issue_category,
    'UNSUPPORTED_STATUS' AS issue_type,
    'SUPPORTED_STATUS' AS expected_value,
    order_status AS actual_value,
    NULL AS difference_value,
    'REVIEW' AS severity,
    source_file,
    order_date AS record_date,
    'Unsupported status requires mapping or business review.' AS review_message
FROM source_order_data
WHERE order_status IN ('UNKNOWN', 'FAILED');
