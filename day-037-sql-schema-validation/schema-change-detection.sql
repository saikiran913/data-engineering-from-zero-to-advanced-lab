-- Day 037: Schema Change Detection
-- Purpose: Compare observed V1 and V2 schemas to detect structural drift.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Schema change detection reports differences only; it does not migrate schemas.
-- Expected schema version: expected_order_schema.
-- Observed schema versions: observed_order_schema_v1 and observed_order_schema_v2.
-- Comparison key: column_name.

-- Query 1: create a distinct list of observed column names across V1 and V2.
-- UNION is used only to create a distinct column-name list for comparison.
WITH all_observed_columns AS (
    SELECT column_name
    FROM observed_order_schema_v1

    UNION

    SELECT column_name
    FROM observed_order_schema_v2
)
SELECT
    column_name
FROM all_observed_columns
ORDER BY column_name;

-- Query 2: compare V1 and V2 observed schemas.
WITH all_observed_columns AS (
    SELECT column_name
    FROM observed_order_schema_v1

    UNION

    SELECT column_name
    FROM observed_order_schema_v2
)
SELECT
    a.column_name,
    v1.observed_data_type AS v1_data_type,
    v2.observed_data_type AS v2_data_type,
    v1.nullable_flag AS v1_nullable_flag,
    v2.nullable_flag AS v2_nullable_flag,
    v1.observed_position AS v1_position,
    v2.observed_position AS v2_position,
    CASE
        WHEN v1.column_name IS NULL THEN 'ADDED_IN_V2'
        WHEN v2.column_name IS NULL THEN 'REMOVED_IN_V2'
        WHEN v1.observed_data_type <> v2.observed_data_type THEN 'TYPE_CHANGED'
        WHEN v1.nullable_flag <> v2.nullable_flag THEN 'NULLABILITY_CHANGED'
        WHEN v1.observed_position <> v2.observed_position THEN 'POSITION_CHANGED'
        ELSE 'UNCHANGED'
    END AS change_type,
    'Review V1 to V2 schema drift before trusting downstream consumers.' AS review_message
FROM all_observed_columns AS a
LEFT JOIN observed_order_schema_v1 AS v1
    ON a.column_name = v1.column_name
LEFT JOIN observed_order_schema_v2 AS v2
    ON a.column_name = v2.column_name
ORDER BY a.column_name;

-- Query 3: schema-change cases that require review.
SELECT
    case_id,
    column_name,
    change_type,
    current_state,
    proposed_or_observed_state,
    likely_risk,
    consumer_impact,
    review_required
FROM schema_change_cases
WHERE review_required = 'Yes'
ORDER BY case_id;

-- Query 4: high-risk schema-change cases.
SELECT
    case_id,
    column_name,
    change_type,
    likely_risk,
    consumer_impact,
    'HIGH_REVIEW' AS severity,
    'High-risk schema change should be investigated before consumer use.' AS review_message
FROM schema_change_cases
WHERE likely_risk = 'High'
ORDER BY case_id;

