-- Day 037: Schema Debugging Lab
-- Purpose: Show broken or misleading schema-validation patterns and safer alternatives.
-- Safety: All executable SQL is read-only and SELECT-based.
-- The examples report schema issues only and do not alter database objects.
-- Expected schema version: expected_order_schema.
-- Observed schema version: observed_order_schema_v2.
-- Comparison key: column_name.

-- Mistake 1: risky because it inspects only observed columns and ignores the contract.
SELECT
    column_name,
    observed_data_type
FROM observed_order_schema_v2;

-- Safer 1: compare expected and observed schemas.
SELECT
    e.column_name,
    e.expected_data_type,
    o.observed_data_type
FROM expected_order_schema AS e
LEFT JOIN observed_order_schema_v2 AS o
    ON e.column_name = o.column_name
ORDER BY e.expected_position;

-- Mistake 2: risky because it treats all unexpected columns as defects.
SELECT
    o.column_name,
    'DEFECT' AS status
FROM observed_order_schema_v2 AS o
LEFT JOIN expected_order_schema AS e
    ON o.column_name = e.column_name
WHERE e.column_name IS NULL;

-- Safer 2: mark unexpected columns for review.
SELECT
    o.column_name,
    'REVIEW' AS status,
    'Unexpected column may be intentional additive change.' AS review_message
FROM observed_order_schema_v2 AS o
LEFT JOIN expected_order_schema AS e
    ON o.column_name = e.column_name
WHERE e.column_name IS NULL;

-- Mistake 3: risky because it assumes a rename automatically.
SELECT
    'customer_id was renamed to customer_identifier' AS unsupported_conclusion;

-- Safer 3: report a possible rename that needs human review.
SELECT
    'customer_id' AS missing_expected_column,
    'customer_identifier' AS unexpected_observed_column,
    'POSSIBLE_RENAME_REVIEW' AS issue_type,
    'Human review is required before treating these as equivalent.' AS review_message;

-- Mistake 4: risky because it ignores consumer impact.
SELECT
    column_name,
    change_type
FROM schema_change_cases
WHERE review_required = 'Yes';

-- Safer 4: include likely risk and consumer impact.
SELECT
    column_name,
    change_type,
    likely_risk,
    consumer_impact,
    review_required
FROM schema_change_cases
WHERE review_required = 'Yes';

-- Mistake 5: risky because it confuses nullability metadata with actual null values.
SELECT
    column_name,
    nullable_flag,
    'NO_NULL_VALUES_FOUND' AS unsupported_conclusion
FROM observed_order_schema_v2;

-- Safer 5: state that metadata and row-level null checks are different.
SELECT
    column_name,
    nullable_flag,
    'NULLABILITY_METADATA_ONLY' AS review_status,
    'Actual row-level null checks require data-value validation.' AS review_message
FROM observed_order_schema_v2;

-- Mistake 6: risky because it relies on column position as the only contract.
SELECT
    e.column_name,
    e.expected_position,
    o.observed_position
FROM expected_order_schema AS e
JOIN observed_order_schema_v2 AS o
    ON e.expected_position = o.observed_position;

-- Safer 6: compare by column name and report position separately.
SELECT
    e.column_name,
    e.expected_position,
    o.observed_position,
    CASE
        WHEN e.expected_position = o.observed_position THEN 'POSITION_MATCH'
        ELSE 'POSITION_REVIEW'
    END AS position_status
FROM expected_order_schema AS e
JOIN observed_order_schema_v2 AS o
    ON e.column_name = o.column_name;

