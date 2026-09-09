-- Day 043: Nested Path Extraction
-- Purpose: Practise reviewing extracted nested paths using relationalized fields.
-- Safety: All executable SQL is read-only.
-- Parent grain: one row per event.
-- Output grain: one row per event, path, or summary group.

-- Section 1: customer ID path.
SELECT
    event_id,
    event_type,
    customer_id_text,
    CASE
        WHEN customer_id_text IS NULL THEN 'NULL_OR_MISSING'
        WHEN customer_id_text = '' THEN 'BLANK_VALUE'
        ELSE 'PRESENT'
    END AS customer_id_status
FROM extracted_json_fields
ORDER BY event_id;

-- Section 2: country path.
SELECT
    event_id,
    event_type,
    country_text
FROM extracted_json_fields
WHERE country_text IS NOT NULL
ORDER BY event_id;

-- Section 3: order amount path.
SELECT
    event_id,
    event_type,
    amount_text,
    extraction_status
FROM extracted_json_fields
WHERE event_type = 'ORDER_CREATED'
ORDER BY event_id;

-- Section 4: status path.
SELECT
    event_id,
    event_type,
    status_text
FROM extracted_json_fields
WHERE event_type IN ('ORDER_CREATED', 'ORDER_UPDATED')
ORDER BY event_id;

-- Section 5: event date path.
SELECT
    event_id,
    event_type,
    event_date_text,
    extraction_status
FROM extracted_json_fields
ORDER BY event_id;

-- Section 6: tags path concept.
SELECT
    event_id,
    event_type,
    tags_present
FROM extracted_json_fields
ORDER BY event_id;

-- Section 7: items path concept.
SELECT
    event_id,
    event_type,
    item_count_text
FROM extracted_json_fields
WHERE event_type = 'ORDER_CREATED'
ORDER BY event_id;

-- Section 8: required versus optional paths.
SELECT
    event_type,
    json_path,
    required_flag,
    expected_value_type,
    expected_array_flag,
    severity
FROM expected_json_paths
ORDER BY event_type, json_path;

-- Section 9: path coverage summary for customer IDs.
SELECT
    event_type,
    'customer.id' AS path_name,
    COUNT(*) AS event_count,
    SUM(CASE WHEN customer_id_text IS NOT NULL AND customer_id_text <> '' THEN 1 ELSE 0 END) AS present_count,
    SUM(CASE WHEN customer_id_text IS NULL THEN 1 ELSE 0 END) AS null_count,
    SUM(CASE WHEN customer_id_text = '' THEN 1 ELSE 0 END) AS blank_count,
    'Review missing and blank values separately.' AS review_message
FROM extracted_json_fields
GROUP BY event_type
ORDER BY event_type;

-- Section 10: conceptual path examples.
-- PLATFORM-SPECIFIC CONCEPTUAL EXAMPLE
-- JSON_VALUE(payload_text, '$.order.amount')

