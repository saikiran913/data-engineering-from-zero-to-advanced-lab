-- Day 037: Renamed and Removed Column Review
-- Purpose: Review removed expected columns and possible renamed columns.
-- Safety: All executable SQL is read-only and SELECT-based.
-- These queries do not rename columns. They only create review evidence.
-- Expected schema version: expected_order_schema.
-- Observed schema version: observed_order_schema_v2.
-- Comparison key: column_name.

-- Query 1: expected columns missing from V2.
SELECT
    e.column_name,
    e.expected_data_type,
    e.required_flag,
    e.key_role,
    'REMOVED_OR_RENAMED_COLUMN' AS issue_type,
    CASE
        WHEN e.required_flag = 'Yes' THEN 'HIGH_REVIEW'
        ELSE 'REVIEW'
    END AS severity,
    'Expected column is missing from V2; it may be removed or renamed.' AS review_message
FROM expected_order_schema AS e
LEFT JOIN observed_order_schema_v2 AS o
    ON e.column_name = o.column_name
WHERE o.column_name IS NULL
ORDER BY e.expected_position;

-- Query 2: unexpected V2 columns that may be additions or possible renames.
SELECT
    o.column_name,
    o.observed_data_type,
    o.observed_position,
    'ADDED_OR_POSSIBLE_RENAME' AS issue_type,
    'REVIEW' AS severity,
    'Observed column is not expected. Review whether it is new or a possible rename.' AS review_message
FROM observed_order_schema_v2 AS o
LEFT JOIN expected_order_schema AS e
    ON o.column_name = e.column_name
WHERE e.column_name IS NULL
ORDER BY o.observed_position;

-- Query 3: educational possible-rename review for customer_id.
-- SQL should not automatically decide semantic equivalence.
SELECT
    e.column_name AS missing_expected_column,
    o.column_name AS unexpected_observed_column,
    e.expected_data_type,
    o.observed_data_type,
    'POSSIBLE_RENAME_REVIEW' AS issue_type,
    'HIGH_REVIEW' AS severity,
    'customer_identifier may be related to customer_id, but human review is required.' AS review_message
FROM expected_order_schema AS e
CROSS JOIN observed_order_schema_v2 AS o
WHERE e.column_name = 'customer_id'
  AND o.column_name = 'customer_identifier';

-- Query 4: removed audit column review.
SELECT
    e.column_name,
    e.key_role,
    e.consumer_sensitivity,
    'REMOVED_AUDIT_COLUMN' AS issue_type,
    'HIGH_REVIEW' AS severity,
    'Required audit or lineage column is missing from V2.' AS review_message
FROM expected_order_schema AS e
LEFT JOIN observed_order_schema_v2 AS o
    ON e.column_name = o.column_name
WHERE e.key_role = 'Audit field'
  AND o.column_name IS NULL
ORDER BY e.expected_position;

