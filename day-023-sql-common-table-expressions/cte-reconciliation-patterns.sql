-- Day 023: CTE Reconciliation Patterns
-- Topic: Source-versus-target checks with named query steps.
-- Safety note: every query in this file is read-only.

-- Pattern 1: Source records missing in target.
WITH source_data AS (
    SELECT record_id, business_key, record_value, record_status
    FROM source_records
),
target_data AS (
    SELECT record_id, business_key, record_value, record_status
    FROM target_records
)
SELECT s.record_id, s.business_key, s.record_value, s.record_status
FROM source_data AS s
LEFT JOIN target_data AS t
    ON s.record_id = t.record_id
WHERE t.record_id IS NULL
ORDER BY s.record_id;

-- Pattern 2: Target records missing in source.
WITH source_data AS (
    SELECT record_id
    FROM source_records
),
target_data AS (
    SELECT record_id, business_key, record_value, record_status
    FROM target_records
)
SELECT t.record_id, t.business_key, t.record_value, t.record_status
FROM target_data AS t
LEFT JOIN source_data AS s
    ON t.record_id = s.record_id
WHERE s.record_id IS NULL
ORDER BY t.record_id;

-- Pattern 3: Value mismatches.
WITH matched_records AS (
    SELECT
        s.record_id,
        s.record_value AS source_value,
        t.record_value AS target_value
    FROM source_records AS s
    JOIN target_records AS t
        ON s.record_id = t.record_id
)
SELECT *
FROM matched_records
WHERE source_value <> target_value
   OR source_value IS NULL
   OR target_value IS NULL
ORDER BY record_id;

-- Pattern 4: Status mismatches.
WITH matched_status AS (
    SELECT
        s.record_id,
        s.record_status AS source_status,
        t.record_status AS target_status
    FROM source_records AS s
    JOIN target_records AS t
        ON s.record_id = t.record_id
)
SELECT *
FROM matched_status
WHERE source_status <> target_status
ORDER BY record_id;

-- Pattern 5: Null mismatches.
WITH matched_values AS (
    SELECT
        s.record_id,
        s.record_value AS source_value,
        t.record_value AS target_value
    FROM source_records AS s
    JOIN target_records AS t
        ON s.record_id = t.record_id
)
SELECT *
FROM matched_values
WHERE (source_value IS NULL AND target_value IS NOT NULL)
   OR (source_value IS NOT NULL AND target_value IS NULL)
ORDER BY record_id;

-- Pattern 6: Count reconciliation.
WITH source_summary AS (
    SELECT COUNT(*) AS source_count
    FROM source_records
),
target_summary AS (
    SELECT COUNT(*) AS target_count
    FROM target_records
)
SELECT
    s.source_count,
    t.target_count,
    s.source_count - t.target_count AS count_difference
FROM source_summary AS s
JOIN target_summary AS t
    ON 1 = 1;

-- Pattern 7: Total reconciliation.
WITH source_summary AS (
    SELECT SUM(record_value) AS source_total
    FROM source_records
),
target_summary AS (
    SELECT SUM(record_value) AS target_total
    FROM target_records
)
SELECT
    s.source_total,
    t.target_total,
    s.source_total - t.target_total AS total_difference
FROM source_summary AS s
JOIN target_summary AS t
    ON 1 = 1;

-- Pattern 8: Combined reconciliation summary.
WITH missing_target AS (
    SELECT s.record_id
    FROM source_records AS s
    LEFT JOIN target_records AS t
        ON s.record_id = t.record_id
    WHERE t.record_id IS NULL
),
missing_source AS (
    SELECT t.record_id
    FROM target_records AS t
    LEFT JOIN source_records AS s
        ON t.record_id = s.record_id
    WHERE s.record_id IS NULL
),
value_mismatch AS (
    SELECT s.record_id
    FROM source_records AS s
    JOIN target_records AS t
        ON s.record_id = t.record_id
    WHERE s.record_value <> t.record_value
       OR s.record_value IS NULL
       OR t.record_value IS NULL
)
SELECT
    'missing_target_records' AS check_name,
    COUNT(*) AS issue_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'REVIEW' END AS status,
    'Source records should exist in target' AS review_message
FROM missing_target
UNION ALL
SELECT
    'missing_source_records' AS check_name,
    COUNT(*) AS issue_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'REVIEW' END AS status,
    'Target records should be traceable to source' AS review_message
FROM missing_source
UNION ALL
SELECT
    'value_mismatches' AS check_name,
    COUNT(*) AS issue_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'REVIEW' END AS status,
    'Matched records should have aligned values' AS review_message
FROM value_mismatch;

-- Pattern 9: Detailed review queue.
WITH matched_records AS (
    SELECT
        s.record_id,
        s.business_key,
        s.record_value AS source_value,
        t.record_value AS target_value,
        s.record_status AS source_status,
        t.record_status AS target_status
    FROM source_records AS s
    JOIN target_records AS t
        ON s.record_id = t.record_id
)
SELECT *
FROM matched_records
WHERE source_value <> target_value
   OR source_status <> target_status
   OR source_value IS NULL
   OR target_value IS NULL
ORDER BY record_id;

-- Pattern 10: Reconciliation sign-off checklist.
-- Check row counts, key completeness, value comparison, status comparison,
-- null differences, and unresolved exceptions before sign-off.
