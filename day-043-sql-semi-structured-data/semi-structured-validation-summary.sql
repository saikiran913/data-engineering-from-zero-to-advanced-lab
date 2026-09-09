-- Day 043: Semi-Structured Validation Summary
-- Purpose: Build compact summaries for nested-data quality checks.
-- Safety: All executable SQL is read-only.
-- Parent grain: one row per event.
-- Output grain: one row per validation check.

-- Check 1: payload presence.
SELECT
    'CHECK001' AS check_id,
    event_type,
    'PAYLOAD_PRESENCE' AS validation_type,
    'payload_text' AS path_or_array,
    COUNT(*) AS expected_count,
    SUM(CASE WHEN payload_text IS NOT NULL AND payload_text <> '' THEN 1 ELSE 0 END) AS actual_count,
    SUM(CASE WHEN payload_text IS NULL OR payload_text = '' THEN 1 ELSE 0 END) AS issue_count,
    'HIGH_REVIEW' AS severity,
    CASE WHEN SUM(CASE WHEN payload_text IS NULL OR payload_text = '' THEN 1 ELSE 0 END) = 0 THEN 'PASS' ELSE 'REVIEW' END AS status,
    'Payload should be present before nested validation.' AS review_message
FROM event_records
GROUP BY event_type;

-- Check 2: extraction success.
SELECT
    'CHECK002' AS check_id,
    event_type,
    'EXTRACTION_STATUS' AS validation_type,
    'all extracted fields' AS path_or_array,
    COUNT(*) AS expected_count,
    SUM(CASE WHEN extraction_status LIKE 'SUCCESS%' THEN 1 ELSE 0 END) AS actual_count,
    SUM(CASE WHEN extraction_status NOT LIKE 'SUCCESS%' THEN 1 ELSE 0 END) AS issue_count,
    'REVIEW' AS severity,
    CASE WHEN SUM(CASE WHEN extraction_status NOT LIKE 'SUCCESS%' THEN 1 ELSE 0 END) = 0 THEN 'PASS' ELSE 'REVIEW' END AS status,
    'Review extraction failures separately from business nulls.' AS review_message
FROM extracted_json_fields
GROUP BY event_type;

-- Check 3: issue summary.
SELECT
    'CHECK003' AS check_id,
    event_type,
    validation_type,
    path_or_array,
    0 AS expected_count,
    0 AS actual_count,
    COUNT(*) AS issue_count,
    severity,
    CASE WHEN severity = 'INFO' THEN 'INFO' ELSE 'REVIEW' END AS status,
    'Review validation cases by issue category.' AS review_message
FROM json_validation_cases
GROUP BY event_type, validation_type, path_or_array, severity
ORDER BY event_type, validation_type;

-- Check 4: array element count.
SELECT
    'CHECK004' AS check_id,
    parent_event_type AS event_type,
    'ARRAY_ELEMENT_COUNT' AS validation_type,
    array_name AS path_or_array,
    COUNT(DISTINCT event_id) AS expected_count,
    COUNT(*) AS actual_count,
    0 AS issue_count,
    'INFO' AS severity,
    'INFO' AS status,
    'Array expansion changes grain from parent event to array element.' AS review_message
FROM array_element_records
GROUP BY parent_event_type, array_name;

-- Check 5: schema drift count.
SELECT
    'CHECK005' AS check_id,
    event_type,
    'SCHEMA_DRIFT' AS validation_type,
    change_type AS path_or_array,
    0 AS expected_count,
    COUNT(*) AS actual_count,
    COUNT(*) AS issue_count,
    'REVIEW' AS severity,
    CASE WHEN change_type = 'UNCHANGED' THEN 'PASS' ELSE 'REVIEW' END AS status,
    'Nested schema changes can happen while the relational payload column stays unchanged.' AS review_message
FROM nested_schema_versions
GROUP BY event_type, change_type
ORDER BY event_type, change_type;

