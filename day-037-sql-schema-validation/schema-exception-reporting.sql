-- Day 037: Schema Exception Reporting
-- Purpose: Create investigation-friendly schema exception rows.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Schema exceptions do not alter, add, remove, rename, or migrate database objects.
-- Expected schema version: expected_order_schema.
-- Observed schema version: observed_order_schema_v2.
-- Comparison key: column_name.

-- Query 1: missing required column exceptions.
SELECT
    'SCHEMA' AS exception_level,
    'EXPECTED_TO_V2' AS comparison_scope,
    e.column_name AS entity_key,
    'MISSING_COLUMN' AS issue_category,
    'MISSING_REQUIRED_COLUMN' AS issue_type,
    e.expected_data_type AS expected_value,
    'COLUMN_NOT_PRESENT' AS actual_value,
    'HIGH_REVIEW' AS severity,
    e.consumer_sensitivity,
    'Required column is missing from observed V2 schema.' AS review_message
FROM expected_order_schema AS e
LEFT JOIN observed_order_schema_v2 AS o
    ON e.column_name = o.column_name
WHERE e.required_flag = 'Yes'
  AND o.column_name IS NULL;

-- Query 2: unexpected column exceptions.
SELECT
    'SCHEMA' AS exception_level,
    'EXPECTED_TO_V2' AS comparison_scope,
    o.column_name AS entity_key,
    'UNEXPECTED_COLUMN' AS issue_category,
    'UNEXPECTED_OBSERVED_COLUMN' AS issue_type,
    'COLUMN_IN_EXPECTED_SCHEMA' AS expected_value,
    o.observed_data_type AS actual_value,
    CASE
        WHEN o.column_name LIKE '%audit%'
          OR o.column_name LIKE '%source%'
        THEN 'INFO'
        ELSE 'REVIEW'
    END AS severity,
    'Unknown' AS consumer_sensitivity,
    'Observed column is not part of the expected contract.' AS review_message
FROM observed_order_schema_v2 AS o
LEFT JOIN expected_order_schema AS e
    ON o.column_name = e.column_name
WHERE e.column_name IS NULL;

-- Query 3: data-type mismatch exceptions.
SELECT
    'SCHEMA' AS exception_level,
    'EXPECTED_TO_V2' AS comparison_scope,
    e.column_name AS entity_key,
    'TYPE_MISMATCH' AS issue_category,
    'OBSERVED_TYPE_DIFFERS' AS issue_type,
    e.expected_data_type AS expected_value,
    o.observed_data_type AS actual_value,
    CASE
        WHEN e.consumer_sensitivity = 'High' THEN 'HIGH_REVIEW'
        ELSE 'REVIEW'
    END AS severity,
    e.consumer_sensitivity,
    'Observed data type differs from expected contract.' AS review_message
FROM expected_order_schema AS e
JOIN observed_order_schema_v2 AS o
    ON e.column_name = o.column_name
WHERE e.expected_data_type <> o.observed_data_type;

-- Query 4: combined schema exception queue.
WITH missing_required AS (
    SELECT
        'SCHEMA' AS exception_level,
        'EXPECTED_TO_V2' AS comparison_scope,
        e.column_name AS entity_key,
        'MISSING_COLUMN' AS issue_category,
        'MISSING_REQUIRED_COLUMN' AS issue_type,
        e.expected_data_type AS expected_value,
        'COLUMN_NOT_PRESENT' AS actual_value,
        'HIGH_REVIEW' AS severity,
        e.consumer_sensitivity,
        'Required column is missing from observed V2 schema.' AS review_message
    FROM expected_order_schema AS e
    LEFT JOIN observed_order_schema_v2 AS o
        ON e.column_name = o.column_name
    WHERE e.required_flag = 'Yes'
      AND o.column_name IS NULL
),
type_mismatch AS (
    SELECT
        'SCHEMA' AS exception_level,
        'EXPECTED_TO_V2' AS comparison_scope,
        e.column_name AS entity_key,
        'TYPE_MISMATCH' AS issue_category,
        'OBSERVED_TYPE_DIFFERS' AS issue_type,
        e.expected_data_type AS expected_value,
        o.observed_data_type AS actual_value,
        CASE
            WHEN e.consumer_sensitivity = 'High' THEN 'HIGH_REVIEW'
            ELSE 'REVIEW'
        END AS severity,
        e.consumer_sensitivity,
        'Observed data type differs from expected contract.' AS review_message
    FROM expected_order_schema AS e
    JOIN observed_order_schema_v2 AS o
        ON e.column_name = o.column_name
    WHERE e.expected_data_type <> o.observed_data_type
),
nullability_mismatch AS (
    SELECT
        'SCHEMA' AS exception_level,
        'EXPECTED_TO_V2' AS comparison_scope,
        e.column_name AS entity_key,
        'NULLABILITY_MISMATCH' AS issue_category,
        'OBSERVED_NULLABILITY_DIFFERS' AS issue_type,
        e.nullable_flag AS expected_value,
        o.nullable_flag AS actual_value,
        'REVIEW' AS severity,
        e.consumer_sensitivity,
        'Observed nullability metadata differs from expected contract.' AS review_message
    FROM expected_order_schema AS e
    JOIN observed_order_schema_v2 AS o
        ON e.column_name = o.column_name
    WHERE e.nullable_flag <> o.nullable_flag
)
SELECT
    exception_level,
    comparison_scope,
    entity_key,
    issue_category,
    issue_type,
    expected_value,
    actual_value,
    severity,
    consumer_sensitivity,
    review_message
FROM missing_required

UNION ALL

SELECT
    exception_level,
    comparison_scope,
    entity_key,
    issue_category,
    issue_type,
    expected_value,
    actual_value,
    severity,
    consumer_sensitivity,
    review_message
FROM type_mismatch

UNION ALL

SELECT
    exception_level,
    comparison_scope,
    entity_key,
    issue_category,
    issue_type,
    expected_value,
    actual_value,
    severity,
    consumer_sensitivity,
    review_message
FROM nullability_mismatch;

