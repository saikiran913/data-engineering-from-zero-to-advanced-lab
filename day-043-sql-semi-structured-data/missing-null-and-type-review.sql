-- Day 043: Missing, Null, and Type Review
-- Purpose: Distinguish missing keys, explicit nulls, blanks, and invalid types.
-- Safety: All executable SQL is read-only.
-- Parent grain: one row per event.
-- Output grain: one row per validation case or summary group.

-- Section 1: missing extracted value.
SELECT
    event_id,
    event_type,
    path_or_array,
    observed_condition,
    severity,
    review_message
FROM json_validation_cases
WHERE issue_category = 'MISSING_KEY'
ORDER BY event_id;

-- Section 2: explicit-null case.
SELECT
    event_id,
    event_type,
    path_or_array,
    observed_condition,
    severity,
    review_message
FROM json_validation_cases
WHERE issue_category = 'EXPLICIT_NULL'
ORDER BY event_id;

-- Section 3: blank string.
SELECT
    event_id,
    event_type,
    path_or_array,
    observed_condition,
    severity,
    review_message
FROM json_validation_cases
WHERE issue_category = 'BLANK_VALUE'
ORDER BY event_id;

-- Section 4: invalid numeric text.
SELECT
    event_id,
    event_type,
    amount_text,
    extraction_status
FROM extracted_json_fields
WHERE extraction_status = 'INVALID_TYPED_VALUE'
  AND amount_text IS NOT NULL
ORDER BY event_id;

-- Section 5: invalid date text.
SELECT
    event_id,
    event_type,
    event_date_text,
    extraction_status
FROM extracted_json_fields
WHERE event_date_text IN ('2026-99-99', 'bad-date')
ORDER BY event_id;

-- Section 6: boolean-like values from validation and event records concept.
SELECT
    event_id,
    event_type,
    payload_text
FROM event_records
WHERE payload_text LIKE '%active%'
ORDER BY event_id;

-- Section 7: unsupported type or value cases.
SELECT
    case_id,
    event_id,
    validation_type,
    path_or_array,
    issue_category,
    severity,
    review_message
FROM json_validation_cases
WHERE issue_category IN ('INVALID_NUMBER', 'INVALID_DATE', 'UNSUPPORTED_VALUE', 'UNEXPECTED_KEY')
ORDER BY case_id;

-- Section 8: review summary.
SELECT
    issue_category,
    COUNT(*) AS issue_count
FROM json_validation_cases
WHERE issue_category IN (
    'MISSING_KEY',
    'EXPLICIT_NULL',
    'BLANK_VALUE',
    'INVALID_NUMBER',
    'INVALID_DATE',
    'UNEXPECTED_TYPE'
)
GROUP BY issue_category
ORDER BY issue_category;

