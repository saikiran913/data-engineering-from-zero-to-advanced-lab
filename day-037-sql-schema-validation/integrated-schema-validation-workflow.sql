-- Day 037: Integrated Schema Validation Workflow
-- Purpose: Combine schema checks into a readable review workflow.
-- Safety: All executable SQL is read-only and SELECT-based.
-- This workflow detects and reports schema issues only; it does not migrate schema objects.
-- Expected schema version: expected_order_schema.
-- Observed schema version: observed_order_schema_v2.
-- Comparison key: column_name.

-- Step 1: build a combined schema exception queue.
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
        'Required expected column is missing from observed V2 schema.' AS review_message
    FROM expected_order_schema AS e
    LEFT JOIN observed_order_schema_v2 AS o
        ON e.column_name = o.column_name
    WHERE e.required_flag = 'Yes'
      AND o.column_name IS NULL
),
unexpected_columns AS (
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
        'Unexpected column should be reviewed before the contract changes.' AS review_message
    FROM observed_order_schema_v2 AS o
    LEFT JOIN expected_order_schema AS e
        ON o.column_name = e.column_name
    WHERE e.column_name IS NULL
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
        'Observed type differs from expected type.' AS review_message
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
    review_message
FROM unexpected_columns

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
    review_message
FROM nullability_mismatch;

-- Step 2: summarise schema-change cases by risk.
SELECT
    likely_risk,
    COUNT(*) AS case_count
FROM schema_change_cases
GROUP BY likely_risk
ORDER BY likely_risk;

-- Step 3: identify consumers that should be reviewed first.
SELECT
    consumer_id,
    consumer_type,
    consumer_name,
    change_sensitivity,
    select_star_usage,
    owner_role,
    'Review high-sensitivity and SELECT-star consumers after schema drift.' AS review_action
FROM schema_consumer_catalog
WHERE change_sensitivity = 'High'
   OR select_star_usage = 'Yes'
ORDER BY change_sensitivity, consumer_id;

