-- Day 043: Array Expansion and Grain
-- Purpose: Understand row multiplication when arrays are expanded.
-- Safety: All executable SQL is read-only.
-- Warning: Array expansion changes the grain. Always document whether the result is one row per event, one row per item, or one row per tag.

-- Section 1: parent event grain.
SELECT
    COUNT(*) AS parent_event_count,
    COUNT(DISTINCT event_id) AS distinct_parent_event_count
FROM event_records;

-- Section 2: expanded array grain.
SELECT
    COUNT(*) AS array_element_row_count,
    COUNT(DISTINCT event_id) AS parent_events_with_array_rows
FROM array_element_records;

-- Section 3: event-to-element counts.
SELECT
    event_id,
    parent_event_type,
    array_name,
    COUNT(*) AS element_count
FROM array_element_records
GROUP BY event_id, parent_event_type, array_name
ORDER BY event_id, array_name;

-- Section 4: preserve event ID and array index.
SELECT
    event_id,
    array_name,
    array_index,
    element_type,
    product_code,
    quantity_text,
    tag_value
FROM array_element_records
ORDER BY event_id, array_name, array_index;

-- Section 5: item array example.
SELECT
    event_id,
    array_index,
    product_code,
    quantity_text
FROM array_element_records
WHERE array_name = 'items'
ORDER BY event_id, array_index;

-- Section 6: tag array example.
SELECT
    event_id,
    array_index,
    tag_value
FROM array_element_records
WHERE array_name = 'tags'
ORDER BY event_id, array_index;

-- Section 7: row multiplication reconciliation.
SELECT
    'parent_events' AS count_name,
    COUNT(*) AS count_value
FROM event_records
UNION ALL
SELECT
    'array_element_rows' AS count_name,
    COUNT(*) AS count_value
FROM array_element_records;

-- Section 8: parent events with zero item elements conceptually.
SELECT
    event_id,
    event_type,
    item_count_text
FROM extracted_json_fields
WHERE item_count_text = '0'
ORDER BY event_id;

-- Section 9: duplicate element review.
SELECT
    event_id,
    array_name,
    tag_value,
    COUNT(*) AS duplicate_count
FROM array_element_records
WHERE tag_value IS NOT NULL
GROUP BY event_id, array_name, tag_value
HAVING COUNT(*) > 1
ORDER BY event_id, tag_value;

