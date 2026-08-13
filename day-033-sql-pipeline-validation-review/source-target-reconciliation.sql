-- Day 033: Source-Target Reconciliation
-- Purpose: Compare source, stage, clean, and reporting keys and values.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Validation queries do not modify source or target data.

-- Query 1: source-only keys compared with clean output.
-- Source population: source_order_extract.
-- Target population: clean_order_output.
-- Source grain: one source record.
-- Target grain: one clean order.
-- Business key: order_id.
-- Expected difference: review rows and duplicate source records may be excluded.
SELECT
    s.order_id,
    s.customer_id,
    s.order_status,
    s.order_amount,
    s.source_file
FROM source_order_extract AS s
LEFT JOIN clean_order_output AS c
    ON s.order_id = c.order_id
WHERE c.order_id IS NULL
ORDER BY
    s.order_id;

-- Query 2: target-only keys in clean output.
-- Expected relationship: target-only clean rows should be investigated.
SELECT
    c.order_id,
    c.customer_id,
    c.order_status,
    c.order_amount,
    c.source_file
FROM clean_order_output AS c
LEFT JOIN source_order_extract AS s
    ON c.order_id = s.order_id
WHERE s.order_id IS NULL
ORDER BY
    c.order_id;

-- Query 3: accepted staged rows missing from clean output.
-- Expected relationship: accepted staged keys should usually appear in clean.
SELECT
    st.order_id,
    st.customer_id,
    st.standard_status,
    st.order_amount,
    st.source_file,
    st.validation_status
FROM staged_order_output AS st
LEFT JOIN clean_order_output AS c
    ON st.order_id = c.order_id
WHERE st.validation_status = 'ACCEPTED'
  AND c.order_id IS NULL
ORDER BY
    st.order_id;

-- Query 4: clean rows with amount mismatch versus accepted staged rows.
SELECT
    st.order_id,
    st.order_amount AS staged_amount,
    c.order_amount AS clean_amount,
    c.order_amount - st.order_amount AS amount_difference,
    st.source_file AS staged_source_file,
    c.source_file AS clean_source_file
FROM staged_order_output AS st
INNER JOIN clean_order_output AS c
    ON st.order_id = c.order_id
WHERE st.validation_status = 'ACCEPTED'
  AND st.order_amount <> c.order_amount
ORDER BY
    st.order_id;

-- Query 5: clean rows with status mismatch versus accepted staged rows.
SELECT
    st.order_id,
    st.standard_status AS staged_status,
    c.order_status AS clean_status,
    st.source_file AS staged_source_file,
    c.source_file AS clean_source_file
FROM staged_order_output AS st
INNER JOIN clean_order_output AS c
    ON st.order_id = c.order_id
WHERE st.validation_status = 'ACCEPTED'
  AND st.standard_status <> c.order_status
ORDER BY
    st.order_id;

-- Query 6: matched source and clean keys for representative evidence.
SELECT
    s.order_id,
    s.order_status AS source_status,
    c.order_status AS clean_status,
    s.order_amount AS source_amount,
    c.order_amount AS clean_amount,
    s.source_file
FROM source_order_extract AS s
INNER JOIN clean_order_output AS c
    ON s.order_id = c.order_id
ORDER BY
    s.order_id;
