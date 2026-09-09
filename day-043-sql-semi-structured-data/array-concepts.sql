-- Day 043: Array Concepts
-- Purpose: Inspect arrays and array elements using relationalized element records.
-- Safety: All executable SQL is read-only.
-- Parent grain: one row per event.
-- Output grain: one row per parent event and array element.

-- Section 1: array names.
SELECT
    array_name,
    COUNT(*) AS element_row_count
FROM array_element_records
GROUP BY array_name
ORDER BY array_name;

-- Section 2: elements per parent event.
SELECT
    event_id,
    array_name,
    COUNT(*) AS element_count
FROM array_element_records
GROUP BY event_id, array_name
ORDER BY event_id, array_name;

-- Section 3: minimum and maximum array index.
SELECT
    array_name,
    MIN(array_index) AS minimum_array_index,
    MAX(array_index) AS maximum_array_index
FROM array_element_records
GROUP BY array_name
ORDER BY array_name;

-- Section 4: empty-array concept.
SELECT
    event_id,
    array_name,
    element_type,
    'Empty array is different from missing array and null array.' AS review_message
FROM array_element_records
WHERE element_type = 'EMPTY_ARRAY'
ORDER BY event_id;

-- Section 5: string-array elements.
SELECT
    event_id,
    array_name,
    array_index,
    tag_value
FROM array_element_records
WHERE element_type = 'STRING'
ORDER BY event_id, array_index;

-- Section 6: object-array elements.
SELECT
    event_id,
    array_name,
    array_index,
    product_code,
    quantity_text
FROM array_element_records
WHERE element_type = 'OBJECT'
ORDER BY event_id, array_index;

-- Section 7: duplicate tag elements.
SELECT
    event_id,
    tag_value,
    COUNT(*) AS tag_count
FROM array_element_records
WHERE array_name = 'tags'
  AND tag_value IS NOT NULL
GROUP BY event_id, tag_value
HAVING COUNT(*) > 1
ORDER BY event_id, tag_value;

-- Section 8: invalid element type or value review.
SELECT
    event_id,
    array_name,
    array_index,
    element_type,
    product_code,
    quantity_text
FROM array_element_records
WHERE element_type NOT IN ('STRING', 'OBJECT', 'EMPTY_ARRAY')
   OR quantity_text = 'two'
   OR product_code IS NULL
ORDER BY event_id, array_index;

