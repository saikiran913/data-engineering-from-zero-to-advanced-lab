-- Day 043: Integrated Semi-Structured Workflow
-- Workflow: Validate Nested JSON Data from Parent Event to Array Elements
-- Safety: All executable SQL is read-only.

-- Part 1: define parent event grain.
SELECT
    'event_records' AS source_table,
    'one row per event_id' AS parent_grain;

-- Part 2: inspect event types.
SELECT
    event_type,
    COUNT(*) AS event_count
FROM event_records
GROUP BY event_type
ORDER BY event_type;

-- Part 3: review payload and extraction status.
SELECT
    extraction_status,
    COUNT(*) AS event_count
FROM extracted_json_fields
GROUP BY extraction_status
ORDER BY extraction_status;

-- Part 4: validate required nested paths.
SELECT
    event_type,
    json_path,
    required_flag,
    expected_value_type,
    severity
FROM expected_json_paths
WHERE required_flag = 'YES'
ORDER BY event_type, json_path;

-- Part 5: distinguish missing, null, and blank.
SELECT
    issue_category,
    COUNT(*) AS issue_count
FROM json_validation_cases
WHERE issue_category IN ('MISSING_KEY', 'EXPLICIT_NULL', 'BLANK_VALUE')
GROUP BY issue_category
ORDER BY issue_category;

-- Part 6: validate typed values.
SELECT
    event_id,
    event_type,
    amount_text,
    event_date_text,
    extraction_status
FROM extracted_json_fields
WHERE extraction_status IN ('INVALID_TYPED_VALUE', 'SUCCESS_WITH_TEXT_NUMBER')
   OR event_date_text IN ('2026-99-99', 'bad-date')
ORDER BY event_id;

-- Part 7: review arrays.
SELECT
    array_name,
    element_type,
    COUNT(*) AS element_count
FROM array_element_records
GROUP BY array_name, element_type
ORDER BY array_name, element_type;

-- Part 8: expand array elements conceptually.
SELECT
    event_id,
    array_name,
    array_index,
    product_code,
    quantity_text,
    tag_value
FROM array_element_records
ORDER BY event_id, array_name, array_index;

-- Part 9: preserve parent keys.
SELECT
    event_id,
    COUNT(*) AS element_row_count
FROM array_element_records
GROUP BY event_id
ORDER BY event_id;

-- Part 10: reconcile element counts.
SELECT
    'parent_events' AS count_name,
    COUNT(*) AS count_value
FROM event_records
UNION ALL
SELECT
    'array_element_rows' AS count_name,
    COUNT(*) AS count_value
FROM array_element_records;

-- Part 11: validate array-element fields.
SELECT
    event_id,
    array_name,
    array_index,
    product_code,
    quantity_text,
    CASE
        WHEN array_name = 'items' AND product_code IS NULL THEN 'MISSING_PRODUCT_CODE'
        WHEN array_name = 'items' AND quantity_text = 'two' THEN 'INVALID_QUANTITY'
        ELSE 'REVIEWED'
    END AS element_validation_status
FROM array_element_records
WHERE array_name = 'items'
ORDER BY event_id, array_index;

-- Part 12: compare nested schema versions.
SELECT
    schema_version,
    event_type,
    json_path,
    expected_value_type,
    required_flag,
    change_type
FROM nested_schema_versions
ORDER BY event_type, json_path, schema_version;

-- Part 13: build exception queue.
SELECT
    v.event_id,
    v.event_type,
    v.path_or_array,
    v.issue_category,
    v.severity,
    v.review_message
FROM json_validation_cases AS v
WHERE v.severity IN ('REVIEW', 'HIGH_REVIEW')
ORDER BY v.severity DESC, v.event_id;

-- Part 14: build validation summary.
SELECT
    issue_category,
    severity,
    COUNT(*) AS issue_count
FROM json_validation_cases
GROUP BY issue_category, severity
ORDER BY severity, issue_category;

-- Part 15: document limitations and platform differences.
SELECT
    'JSON extraction, safe casting, and array expansion syntax vary by SQL platform.' AS platform_note;

