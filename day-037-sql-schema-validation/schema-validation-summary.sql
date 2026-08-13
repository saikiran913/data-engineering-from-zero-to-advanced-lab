-- Day 037: Schema Validation Summary
-- Purpose: Summarise schema validation findings for review.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Summary queries do not create tables, views, or schema changes.
-- Expected schema version: expected_order_schema.
-- Observed schema version: observed_order_schema_v2.
-- Comparison key: column_name.

-- Query 1: expected schema column counts by required flag.
SELECT
    required_flag,
    COUNT(*) AS column_count
FROM expected_order_schema
GROUP BY required_flag
ORDER BY required_flag;

-- Query 2: observed V2 column count.
SELECT
    source_version,
    COUNT(*) AS observed_column_count
FROM observed_order_schema_v2
GROUP BY source_version;

-- Query 3: missing required column count.
SELECT
    'MISSING_REQUIRED_COLUMNS' AS summary_name,
    COUNT(*) AS issue_count
FROM expected_order_schema AS e
LEFT JOIN observed_order_schema_v2 AS o
    ON e.column_name = o.column_name
WHERE e.required_flag = 'Yes'
  AND o.column_name IS NULL;

-- Query 4: unexpected V2 column count.
SELECT
    'UNEXPECTED_COLUMNS' AS summary_name,
    COUNT(*) AS issue_count
FROM observed_order_schema_v2 AS o
LEFT JOIN expected_order_schema AS e
    ON o.column_name = e.column_name
WHERE e.column_name IS NULL;

-- Query 5: V2 type mismatch count.
SELECT
    'TYPE_MISMATCHES' AS summary_name,
    COUNT(*) AS issue_count
FROM expected_order_schema AS e
JOIN observed_order_schema_v2 AS o
    ON e.column_name = o.column_name
WHERE e.expected_data_type <> o.observed_data_type;

-- Query 6: V2 nullability mismatch count.
SELECT
    'NULLABILITY_MISMATCHES' AS summary_name,
    COUNT(*) AS issue_count
FROM expected_order_schema AS e
JOIN observed_order_schema_v2 AS o
    ON e.column_name = o.column_name
WHERE e.nullable_flag <> o.nullable_flag;

-- Query 7: change cases by likely risk.
SELECT
    likely_risk,
    COUNT(*) AS change_case_count
FROM schema_change_cases
GROUP BY likely_risk
ORDER BY likely_risk;

-- Query 8: validation rules by severity.
SELECT
    severity,
    COUNT(*) AS rule_count
FROM schema_validation_rules
GROUP BY severity
ORDER BY severity;

