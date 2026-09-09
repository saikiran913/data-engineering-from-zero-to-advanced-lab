-- Day 043: Semi-Structured Exception Reporting
-- Purpose: Create investigation-friendly exceptions for nested JSON-like data.
-- Safety: All executable SQL is read-only.
-- Parent grain: one row per event.
-- Output grain: one row per issue.

-- Section 1: missing required nested key.
SELECT
    'FIELD' AS exception_level,
    e.event_id,
    e.event_type,
    v.path_or_array,
    v.issue_category,
    v.validation_type AS issue_type,
    v.expected_condition,
    v.observed_condition AS observed_value,
    v.severity,
    e.source_file,
    v.review_message
FROM json_validation_cases AS v
INNER JOIN event_records AS e
    ON v.event_id = e.event_id
WHERE v.issue_category = 'MISSING_KEY';

-- Section 2: explicit null and blank required values.
SELECT
    'FIELD' AS exception_level,
    e.event_id,
    e.event_type,
    v.path_or_array,
    v.issue_category,
    v.validation_type AS issue_type,
    v.expected_condition,
    v.observed_condition AS observed_value,
    v.severity,
    e.source_file,
    v.review_message
FROM json_validation_cases AS v
INNER JOIN event_records AS e
    ON v.event_id = e.event_id
WHERE v.issue_category IN ('EXPLICIT_NULL', 'BLANK_VALUE');

-- Section 3: invalid numeric and date text.
SELECT
    'TYPE' AS exception_level,
    e.event_id,
    e.event_type,
    v.path_or_array,
    v.issue_category,
    v.validation_type AS issue_type,
    v.expected_condition,
    v.observed_condition AS observed_value,
    v.severity,
    e.source_file,
    v.review_message
FROM json_validation_cases AS v
INNER JOIN event_records AS e
    ON v.event_id = e.event_id
WHERE v.issue_category IN ('INVALID_NUMBER', 'INVALID_DATE', 'UNSUPPORTED_VALUE');

-- Section 4: malformed payload and schema drift.
SELECT
    'PAYLOAD' AS exception_level,
    e.event_id,
    e.event_type,
    v.path_or_array,
    v.issue_category,
    v.validation_type AS issue_type,
    v.expected_condition,
    v.observed_condition AS observed_value,
    v.severity,
    e.source_file,
    v.review_message
FROM json_validation_cases AS v
INNER JOIN event_records AS e
    ON v.event_id = e.event_id
WHERE v.issue_category IN ('MALFORMED_JSON', 'POSSIBLE_RENAME', 'UNEXPECTED_KEY');

-- Section 5: array element missing required key or invalid type.
SELECT
    'ARRAY_ELEMENT' AS exception_level,
    e.event_id,
    e.event_type,
    v.path_or_array,
    v.issue_category,
    v.validation_type AS issue_type,
    v.expected_condition,
    v.observed_condition AS observed_value,
    v.severity,
    e.source_file,
    v.review_message
FROM json_validation_cases AS v
INNER JOIN event_records AS e
    ON v.event_id = e.event_id
WHERE v.issue_category LIKE 'ARRAY_ELEMENT%';

-- Section 6: combined review queue.
SELECT
    v.severity AS exception_level,
    e.event_id,
    e.event_type,
    v.path_or_array,
    v.issue_category,
    v.validation_type AS issue_type,
    v.expected_condition,
    v.observed_condition AS observed_value,
    v.severity,
    e.source_file,
    v.review_message
FROM json_validation_cases AS v
INNER JOIN event_records AS e
    ON v.event_id = e.event_id
WHERE v.severity IN ('REVIEW', 'HIGH_REVIEW')
ORDER BY v.severity DESC, e.event_id, v.path_or_array;

