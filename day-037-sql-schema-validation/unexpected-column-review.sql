-- Day 037: Unexpected Column Review
-- Purpose: Review columns observed in a source schema but not listed in the expected contract.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Unexpected-column review does not add, remove, or approve schema changes automatically.
-- Expected schema version: expected_order_schema.
-- Observed schema versions: observed_order_schema_v1 and observed_order_schema_v2.
-- Comparison key: column_name.

-- Query 1: unexpected columns in observed V1.
SELECT
    o.column_name,
    o.observed_data_type,
    o.nullable_flag,
    o.observed_position,
    'UNEXPECTED_COLUMN' AS issue_type,
    CASE
        WHEN o.column_name LIKE '%audit%'
          OR o.column_name LIKE '%loaded%'
          OR o.column_name LIKE '%batch%'
        THEN 'INFO'
        ELSE 'REVIEW'
    END AS severity,
    'Unexpected V1 column should be reviewed and documented.' AS review_message
FROM observed_order_schema_v1 AS o
LEFT JOIN expected_order_schema AS e
    ON o.column_name = e.column_name
WHERE e.column_name IS NULL
ORDER BY o.observed_position;

-- Query 2: unexpected columns in observed V2.
-- Name-based audit detection is only an educational heuristic.
SELECT
    o.column_name,
    o.observed_data_type,
    o.nullable_flag,
    o.observed_position,
    'UNEXPECTED_COLUMN' AS issue_type,
    CASE
        WHEN o.column_name LIKE '%audit%'
          OR o.column_name LIKE '%loaded%'
          OR o.column_name LIKE '%source%'
        THEN 'INFO'
        ELSE 'REVIEW'
    END AS severity,
    'Unexpected V2 column may be additive, but consumer impact should be reviewed.' AS review_message
FROM observed_order_schema_v2 AS o
LEFT JOIN expected_order_schema AS e
    ON o.column_name = e.column_name
WHERE e.column_name IS NULL
ORDER BY o.observed_position;

-- Query 3: unexpected columns with SELECT-star consumer risk.
SELECT
    o.column_name,
    c.consumer_id,
    c.consumer_type,
    c.consumer_name,
    c.select_star_usage,
    c.change_sensitivity,
    'CONSUMER_IMPACT_REVIEW' AS issue_type,
    'REVIEW' AS severity,
    'Consumer uses SELECT star and may be affected by unexpected columns.' AS review_message
FROM observed_order_schema_v2 AS o
LEFT JOIN expected_order_schema AS e
    ON o.column_name = e.column_name
CROSS JOIN schema_consumer_catalog AS c
WHERE e.column_name IS NULL
  AND c.select_star_usage = 'Yes'
ORDER BY o.column_name, c.consumer_id;

