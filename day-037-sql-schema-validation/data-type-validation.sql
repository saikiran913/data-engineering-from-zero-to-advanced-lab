-- Day 037: Data-Type Validation
-- Purpose: Compare expected data types with observed data types.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Type validation reports differences only; it does not cast or migrate stored data.
-- Expected schema version: expected_order_schema.
-- Observed schema versions: observed_order_schema_v1 and observed_order_schema_v2.
-- Comparison key: column_name.

-- Query 1: expected versus observed V1 data types.
SELECT
    e.column_name,
    e.expected_data_type,
    o.observed_data_type,
    CASE
        WHEN o.column_name IS NULL THEN 'COLUMN_MISSING'
        WHEN e.expected_data_type = o.observed_data_type THEN 'TYPE_MATCH'
        ELSE 'TYPE_REVIEW'
    END AS type_status,
    CASE
        WHEN o.column_name IS NULL THEN 'Column is missing, so type cannot be compared.'
        WHEN e.expected_data_type = o.observed_data_type THEN 'Data type matches expected schema.'
        ELSE 'Observed data type differs from expected schema.'
    END AS review_message
FROM expected_order_schema AS e
LEFT JOIN observed_order_schema_v1 AS o
    ON e.column_name = o.column_name
ORDER BY e.expected_position;

-- Query 2: expected versus observed V2 data types.
SELECT
    e.column_name,
    e.expected_data_type,
    o.observed_data_type,
    CASE
        WHEN o.column_name IS NULL THEN 'COLUMN_MISSING'
        WHEN e.expected_data_type = o.observed_data_type THEN 'TYPE_MATCH'
        ELSE 'TYPE_REVIEW'
    END AS type_status,
    CASE
        WHEN o.column_name IS NULL THEN 'Column is missing, so type cannot be compared.'
        WHEN e.expected_data_type = o.observed_data_type THEN 'Data type matches expected schema.'
        ELSE 'Observed data type differs from expected schema and may affect consumers.'
    END AS review_message
FROM expected_order_schema AS e
LEFT JOIN observed_order_schema_v2 AS o
    ON e.column_name = o.column_name
ORDER BY e.expected_position;

-- Query 3: only V2 type mismatches.
SELECT
    e.column_name,
    e.expected_data_type,
    o.observed_data_type,
    e.consumer_sensitivity,
    'TYPE_MISMATCH' AS issue_type,
    CASE
        WHEN e.consumer_sensitivity = 'High' THEN 'HIGH_REVIEW'
        ELSE 'REVIEW'
    END AS severity,
    'Observed data type differs from the expected contract.' AS review_message
FROM expected_order_schema AS e
JOIN observed_order_schema_v2 AS o
    ON e.column_name = o.column_name
WHERE e.expected_data_type <> o.observed_data_type
ORDER BY e.expected_position;

-- Query 4: type family review for common beginner cases.
-- This is a simple educational classification, not a universal platform rule.
SELECT
    e.column_name,
    e.expected_data_type,
    o.observed_data_type,
    CASE
        WHEN e.expected_data_type = o.observed_data_type THEN 'MATCH'
        WHEN e.expected_data_type = 'DATE'
          AND o.observed_data_type = 'TIMESTAMP' THEN 'DATE_TO_TIMESTAMP_REVIEW'
        WHEN e.expected_data_type = 'TIMESTAMP'
          AND o.observed_data_type = 'DATE' THEN 'TIMESTAMP_TO_DATE_REVIEW'
        WHEN e.expected_data_type = 'DECIMAL'
          AND o.observed_data_type = 'TEXT' THEN 'NUMERIC_TO_TEXT_RISK'
        ELSE 'TYPE_REVIEW'
    END AS educational_type_review,
    'Type compatibility varies by SQL platform and consumer logic.' AS platform_note
FROM expected_order_schema AS e
JOIN observed_order_schema_v2 AS o
    ON e.column_name = o.column_name
ORDER BY e.expected_position;

