-- Day 037: Additive Change Review
-- Purpose: Review new observed columns as possible additive schema changes.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Additive-change review does not approve or apply schema changes automatically.
-- Expected schema version: expected_order_schema.
-- Observed schema versions: observed_order_schema_v1 and observed_order_schema_v2.
-- Comparison key: column_name.

-- Query 1: additive-looking columns in V1.
SELECT
    o.column_name,
    o.observed_data_type,
    o.nullable_flag,
    o.observed_position,
    'ADDITIVE_CHANGE_REVIEW' AS issue_type,
    'INFO' AS severity,
    'New V1 column may be an intentional additive change; document the contract if accepted.' AS review_message
FROM observed_order_schema_v1 AS o
LEFT JOIN expected_order_schema AS e
    ON o.column_name = e.column_name
WHERE e.column_name IS NULL
ORDER BY o.observed_position;

-- Query 2: additive-looking columns in V2.
SELECT
    o.column_name,
    o.observed_data_type,
    o.nullable_flag,
    o.observed_position,
    CASE
        WHEN o.column_name LIKE '%audit%'
          OR o.column_name LIKE '%source%'
        THEN 'ADDITIVE_AUDIT_COLUMN'
        ELSE 'ADDITIVE_BUSINESS_COLUMN'
    END AS issue_type,
    CASE
        WHEN o.column_name LIKE '%audit%'
          OR o.column_name LIKE '%source%'
        THEN 'INFO'
        ELSE 'REVIEW'
    END AS severity,
    'Unexpected column may be additive, but downstream consumers should be checked.' AS review_message
FROM observed_order_schema_v2 AS o
LEFT JOIN expected_order_schema AS e
    ON o.column_name = e.column_name
WHERE e.column_name IS NULL
ORDER BY o.observed_position;

-- Query 3: consumers that may be affected by additive changes.
SELECT
    c.consumer_id,
    c.consumer_type,
    c.consumer_name,
    c.select_star_usage,
    c.change_sensitivity,
    'SELECT_STAR_ADDITIVE_CHANGE_RISK' AS issue_type,
    'REVIEW' AS severity,
    'SELECT star consumers may receive new columns when additive changes appear.' AS review_message
FROM schema_consumer_catalog AS c
WHERE c.select_star_usage = 'Yes'
ORDER BY c.change_sensitivity, c.consumer_id;

-- Query 4: change-case catalog rows for additive changes.
SELECT
    case_id,
    column_name,
    change_type,
    likely_risk,
    consumer_impact,
    review_required
FROM schema_change_cases
WHERE change_type = 'add'
ORDER BY case_id;

