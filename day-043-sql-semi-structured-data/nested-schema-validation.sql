-- Day 043: Nested Schema Validation
-- Purpose: Review expected nested paths and schema drift.
-- Safety: All executable SQL is read-only.
-- Parent grain: one row per expected path or schema-version path.
-- Output grain: one row per path or drift summary.

-- Section 1: expected nested paths.
SELECT
    path_id,
    event_type,
    json_path,
    required_flag,
    expected_value_type,
    expected_array_flag,
    severity
FROM expected_json_paths
ORDER BY event_type, json_path;

-- Section 2: required paths.
SELECT
    event_type,
    json_path,
    expected_value_type,
    severity
FROM expected_json_paths
WHERE required_flag = 'YES'
ORDER BY event_type, json_path;

-- Section 3: optional paths.
SELECT
    event_type,
    json_path,
    expected_value_type,
    severity
FROM expected_json_paths
WHERE required_flag = 'NO'
ORDER BY event_type, json_path;

-- Section 4: added, removed, renamed, and changed paths.
SELECT
    schema_version,
    event_type,
    json_path,
    expected_value_type,
    required_flag,
    change_type,
    review_note
FROM nested_schema_versions
WHERE change_type IN (
    'ADDED_PATH',
    'REMOVED_PATH',
    'POSSIBLE_RENAME',
    'TYPE_CHANGED',
    'REQUIREDNESS_CHANGED',
    'SHAPE_CHANGED',
    'REVIEW'
)
ORDER BY event_type, change_type, json_path;

-- Section 5: unchanged paths.
SELECT
    schema_version,
    event_type,
    json_path,
    expected_value_type,
    required_flag,
    review_note
FROM nested_schema_versions
WHERE change_type = 'UNCHANGED'
ORDER BY event_type, json_path, schema_version;

-- Section 6: schema drift summary.
SELECT
    change_type,
    COUNT(*) AS path_count
FROM nested_schema_versions
GROUP BY change_type
ORDER BY change_type;

-- Section 7: relational schema can stay unchanged while nested schema changes.
SELECT
    'Relational payload column may remain the same while nested paths are added, removed, renamed, or changed.' AS schema_drift_warning;

