-- Day 037: Required Column Validation
-- Purpose: Identify required and optional expected columns missing from observed schemas.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Schema validation reports structural issues only; it does not alter database objects.
-- Expected schema version: expected_order_schema.
-- Observed schema versions: observed_order_schema_v1 and observed_order_schema_v2.
-- Comparison key: column_name.

-- Query 1: list required columns in the expected schema contract.
SELECT
    column_name,
    expected_data_type,
    nullable_flag,
    key_role,
    consumer_sensitivity,
    expected_position
FROM expected_order_schema
WHERE required_flag = 'Yes'
ORDER BY expected_position;

-- Query 2: required columns missing from observed V1.
SELECT
    e.column_name,
    e.expected_data_type,
    e.required_flag,
    e.key_role,
    'MISSING_REQUIRED_COLUMN' AS issue_type,
    'HIGH_REVIEW' AS severity,
    'Required column is missing from observed V1 schema.' AS review_message
FROM expected_order_schema AS e
LEFT JOIN observed_order_schema_v1 AS o
    ON e.column_name = o.column_name
WHERE e.required_flag = 'Yes'
  AND o.column_name IS NULL
ORDER BY e.expected_position;

-- Query 3: required columns missing from observed V2.
SELECT
    e.column_name,
    e.expected_data_type,
    e.required_flag,
    e.key_role,
    'MISSING_REQUIRED_COLUMN' AS issue_type,
    'HIGH_REVIEW' AS severity,
    'Required column is missing from observed V2 schema.' AS review_message
FROM expected_order_schema AS e
LEFT JOIN observed_order_schema_v2 AS o
    ON e.column_name = o.column_name
WHERE e.required_flag = 'Yes'
  AND o.column_name IS NULL
ORDER BY e.expected_position;

-- Query 4: optional columns missing from observed V2.
-- This returns no rows in the supplied sample because all expected columns are required.
-- The pattern is useful when a contract contains optional fields.
SELECT
    e.column_name,
    e.expected_data_type,
    e.required_flag,
    'MISSING_OPTIONAL_COLUMN' AS issue_type,
    'REVIEW' AS severity,
    'Optional column is absent; check whether consumers expected it.' AS review_message
FROM expected_order_schema AS e
LEFT JOIN observed_order_schema_v2 AS o
    ON e.column_name = o.column_name
WHERE e.required_flag = 'No'
  AND o.column_name IS NULL
ORDER BY e.expected_position;

-- Query 5: key-related required columns missing from observed V2.
SELECT
    e.column_name,
    e.key_role,
    e.consumer_sensitivity,
    'KEY_COLUMN_MISSING' AS issue_type,
    'HIGH_REVIEW' AS severity,
    'A key-related expected column is missing and may affect downstream joins or grouping.' AS review_message
FROM expected_order_schema AS e
LEFT JOIN observed_order_schema_v2 AS o
    ON e.column_name = o.column_name
WHERE e.required_flag = 'Yes'
  AND e.key_role <> 'None'
  AND o.column_name IS NULL
ORDER BY e.expected_position;

