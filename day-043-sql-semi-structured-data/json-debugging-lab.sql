-- Day 043: JSON Debugging Lab
-- Purpose: Practise spotting weak assumptions in semi-structured SQL work.
-- Safety: All executable SQL is read-only.
-- Parent grain: one row per event.
-- Output grain: one row per review query or issue.

-- Issue 1: JSON syntax assumed universal.
-- Safer approach: keep vendor-specific syntax in comments and validate with platform documentation.
-- PLATFORM-SPECIFIC CONCEPTUAL EXAMPLE
-- JSON_VALUE(payload_text, '$.customer.id')
SELECT 'JSON syntax varies by platform.' AS review_message;

-- Issue 2: missing key treated as null.
SELECT
    event_id,
    issue_category,
    observed_condition
FROM json_validation_cases
WHERE issue_category IN ('MISSING_KEY', 'EXPLICIT_NULL')
ORDER BY event_id;

-- Issue 3: null treated as blank.
SELECT
    event_id,
    issue_category,
    observed_condition
FROM json_validation_cases
WHERE issue_category IN ('EXPLICIT_NULL', 'BLANK_VALUE')
ORDER BY event_id;

-- Issue 4: numeric string treated as number without review.
SELECT
    event_id,
    amount_text,
    extraction_status
FROM extracted_json_fields
WHERE event_type = 'ORDER_CREATED'
ORDER BY event_id;

-- Issue 5: failing cast used directly.
-- PLATFORM-SPECIFIC CONCEPTUAL CAUTION
-- CAST(amount_text AS DECIMAL(12, 2)) may fail when amount_text = 'not_available'.
SELECT
    event_id,
    amount_text
FROM extracted_json_fields
WHERE amount_text = 'not_available';

-- Issue 6: invalid date ignored.
SELECT
    event_id,
    event_date_text
FROM extracted_json_fields
WHERE event_date_text IN ('2026-99-99', 'bad-date');

-- Issue 7: array flattened without parent key.
SELECT
    array_name,
    array_index,
    product_code,
    tag_value
FROM array_element_records
ORDER BY array_name, array_index;

-- Issue 8: safer array output preserves parent key.
SELECT
    event_id,
    array_name,
    array_index,
    product_code,
    tag_value
FROM array_element_records
ORDER BY event_id, array_name, array_index;

-- Issue 9: row multiplication mistaken for duplicates.
SELECT
    event_id,
    array_name,
    COUNT(*) AS element_count
FROM array_element_records
GROUP BY event_id, array_name
ORDER BY event_id, array_name;

-- Issue 10: duplicate array elements ignored.
SELECT
    event_id,
    tag_value,
    COUNT(*) AS tag_count
FROM array_element_records
WHERE tag_value IS NOT NULL
GROUP BY event_id, tag_value
HAVING COUNT(*) > 1;

-- Issue 11: empty array treated as missing key.
SELECT
    event_id,
    array_name,
    element_type
FROM array_element_records
WHERE element_type = 'EMPTY_ARRAY';

-- Issue 12: optional missing field treated as failure.
SELECT
    event_id,
    path_or_array,
    issue_category,
    severity,
    review_message
FROM json_validation_cases
WHERE issue_category = 'VALID_OPTIONAL_MISSING';

-- Issue 13: required field not event-type-specific.
SELECT
    event_type,
    json_path,
    required_flag
FROM expected_json_paths
ORDER BY event_type, json_path;

-- Issue 14: nested schema drift ignored.
SELECT
    schema_version,
    event_type,
    json_path,
    change_type
FROM nested_schema_versions
WHERE change_type <> 'UNCHANGED'
ORDER BY event_type, change_type;

-- Issue 15: renamed path assumed automatically.
SELECT
    event_id,
    issue_category,
    review_message
FROM json_validation_cases
WHERE issue_category = 'POSSIBLE_RENAME';

-- Issue 16: object treated as scalar or scalar treated as array.
SELECT
    event_type,
    json_path,
    expected_value_type,
    expected_array_flag
FROM expected_json_paths
ORDER BY event_type, json_path;

-- Issue 17: malformed JSON not separated.
SELECT
    event_id,
    event_type,
    extraction_status
FROM extracted_json_fields
WHERE extraction_status = 'MALFORMED_PAYLOAD';

-- Issue 18: unexpected extra key treated as harmless automatically.
SELECT
    event_id,
    path_or_array,
    review_message
FROM json_validation_cases
WHERE issue_category = 'UNEXPECTED_KEY';

-- Issue 19: extraction failure mixed with business null.
SELECT
    extraction_status,
    COUNT(*) AS event_count
FROM extracted_json_fields
GROUP BY extraction_status
ORDER BY extraction_status;

-- Issue 20: array-element grain not documented.
SELECT
    'array_element_records grain is one row per parent event and array element.' AS grain_note;

-- Issue 21: relational schema validation assumed sufficient.
SELECT
    'Relational columns can stay stable while nested paths drift.' AS review_message;

-- Issue 22: no exception output.
SELECT
    issue_category,
    severity,
    COUNT(*) AS issue_count
FROM json_validation_cases
GROUP BY issue_category, severity
ORDER BY severity, issue_category;

-- Issue 23: no path contract.
SELECT
    path_id,
    event_type,
    json_path,
    required_flag,
    expected_value_type
FROM expected_json_paths
ORDER BY event_type, json_path;

