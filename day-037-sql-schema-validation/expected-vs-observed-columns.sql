-- Day 037: Expected versus Observed Columns
-- Purpose: Compare a documented schema contract with observed schema versions.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Schema validation does not alter, add, remove, rename, or migrate database objects.
-- Expected schema version: expected_order_schema.
-- Observed schema versions: observed_order_schema_v1 and observed_order_schema_v2.
-- Comparison key: column_name.

-- Query 1: inspect the expected schema contract.
SELECT
    column_name,
    expected_data_type,
    required_flag,
    nullable_flag,
    business_meaning,
    key_role,
    consumer_sensitivity,
    expected_position
FROM expected_order_schema
ORDER BY expected_position;

-- Query 2: inspect the observed V1 schema.
-- V1 mostly matches the expected schema, with one mild additive column.
SELECT
    column_name,
    observed_data_type,
    nullable_flag,
    observed_position,
    source_version,
    observed_at
FROM observed_order_schema_v1
ORDER BY observed_position;

-- Query 3: inspect the observed V2 schema.
-- V2 includes missing, unexpected, type, nullability, and position changes.
SELECT
    column_name,
    observed_data_type,
    nullable_flag,
    observed_position,
    source_version,
    observed_at
FROM observed_order_schema_v2
ORDER BY observed_position;

-- Query 4: compare expected columns with observed V1.
SELECT
    e.column_name,
    e.expected_data_type,
    o.observed_data_type,
    e.required_flag,
    e.expected_position,
    o.observed_position,
    CASE
        WHEN o.column_name IS NULL THEN 'MISSING_FROM_V1'
        ELSE 'PRESENT_IN_V1'
    END AS column_presence_status
FROM expected_order_schema AS e
LEFT JOIN observed_order_schema_v1 AS o
    ON e.column_name = o.column_name
ORDER BY e.expected_position;

-- Query 5: compare expected columns with observed V2.
SELECT
    e.column_name,
    e.expected_data_type,
    o.observed_data_type,
    e.required_flag,
    e.expected_position,
    o.observed_position,
    CASE
        WHEN o.column_name IS NULL THEN 'MISSING_FROM_V2'
        ELSE 'PRESENT_IN_V2'
    END AS column_presence_status
FROM expected_order_schema AS e
LEFT JOIN observed_order_schema_v2 AS o
    ON e.column_name = o.column_name
ORDER BY e.expected_position;

-- Query 6: find observed V1 columns that are not in the expected contract.
SELECT
    o.column_name,
    o.observed_data_type,
    o.nullable_flag,
    o.observed_position,
    'UNEXPECTED_IN_V1' AS review_status,
    'Observed V1 column is not listed in the expected schema contract.' AS review_message
FROM observed_order_schema_v1 AS o
LEFT JOIN expected_order_schema AS e
    ON o.column_name = e.column_name
WHERE e.column_name IS NULL
ORDER BY o.observed_position;

-- Query 7: find observed V2 columns that are not in the expected contract.
SELECT
    o.column_name,
    o.observed_data_type,
    o.nullable_flag,
    o.observed_position,
    'UNEXPECTED_IN_V2' AS review_status,
    'Observed V2 column is not listed in the expected schema contract.' AS review_message
FROM observed_order_schema_v2 AS o
LEFT JOIN expected_order_schema AS e
    ON o.column_name = e.column_name
WHERE e.column_name IS NULL
ORDER BY o.observed_position;

