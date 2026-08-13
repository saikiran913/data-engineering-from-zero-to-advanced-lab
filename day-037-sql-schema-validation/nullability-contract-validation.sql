-- Day 037: Nullability Contract Validation
-- Purpose: Compare expected nullability with observed nullability metadata.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Nullability validation does not alter schemas or fill missing values.
-- Expected schema version: expected_order_schema.
-- Observed schema versions: observed_order_schema_v1 and observed_order_schema_v2.
-- Comparison key: column_name.

-- Query 1: expected nullability contract.
SELECT
    column_name,
    nullable_flag AS expected_nullable_flag,
    required_flag,
    business_meaning,
    expected_position
FROM expected_order_schema
ORDER BY expected_position;

-- Query 2: compare nullability expectations with V1.
SELECT
    e.column_name,
    e.nullable_flag AS expected_nullable_flag,
    o.nullable_flag AS observed_nullable_flag,
    CASE
        WHEN o.column_name IS NULL THEN 'COLUMN_MISSING'
        WHEN e.nullable_flag = o.nullable_flag THEN 'NULLABILITY_MATCH'
        ELSE 'NULLABILITY_REVIEW'
    END AS nullability_status,
    'Schema nullability metadata is different from actual row-level null checks.' AS learning_note
FROM expected_order_schema AS e
LEFT JOIN observed_order_schema_v1 AS o
    ON e.column_name = o.column_name
ORDER BY e.expected_position;

-- Query 3: compare nullability expectations with V2.
SELECT
    e.column_name,
    e.nullable_flag AS expected_nullable_flag,
    o.nullable_flag AS observed_nullable_flag,
    CASE
        WHEN o.column_name IS NULL THEN 'COLUMN_MISSING'
        WHEN e.nullable_flag = o.nullable_flag THEN 'NULLABILITY_MATCH'
        ELSE 'NULLABILITY_REVIEW'
    END AS nullability_status,
    CASE
        WHEN o.column_name IS NULL THEN 'Column is missing, so nullability cannot be compared.'
        WHEN e.nullable_flag = o.nullable_flag THEN 'Nullability metadata matches expected contract.'
        ELSE 'Observed nullability differs from expected contract.'
    END AS review_message
FROM expected_order_schema AS e
LEFT JOIN observed_order_schema_v2 AS o
    ON e.column_name = o.column_name
ORDER BY e.expected_position;

-- Query 4: only V2 nullability mismatches.
SELECT
    e.column_name,
    e.required_flag,
    e.nullable_flag AS expected_nullable_flag,
    o.nullable_flag AS observed_nullable_flag,
    'NULLABILITY_MISMATCH' AS issue_type,
    CASE
        WHEN e.required_flag = 'Yes'
          AND e.nullable_flag = 'No'
          AND o.nullable_flag = 'Yes'
        THEN 'HIGH_REVIEW'
        ELSE 'REVIEW'
    END AS severity,
    'Observed nullability metadata changed and may affect downstream assumptions.' AS review_message
FROM expected_order_schema AS e
JOIN observed_order_schema_v2 AS o
    ON e.column_name = o.column_name
WHERE e.nullable_flag <> o.nullable_flag
ORDER BY e.expected_position;

