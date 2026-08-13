-- Day 034: Stage-to-Clean Reconciliation
-- Purpose: Compare accepted staged records with clean sales output.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Control queries do not modify data.

-- Query 1: accepted stage count versus clean count.
-- Source population: accepted rows in staged_sales_output.
-- Target population: clean_sales_output.
-- Source grain: one accepted staged candidate.
-- Target grain: one clean sales order.
-- Control type: row count.
-- Expected relationship: exact match unless duplicates or exclusions are documented.
WITH accepted_stage AS (
    SELECT COUNT(*) AS row_count
    FROM staged_sales_output
    WHERE validation_status = 'ACCEPTED'
),
clean_count AS (
    SELECT COUNT(*) AS row_count
    FROM clean_sales_output
)
SELECT
    a.row_count AS accepted_stage_count,
    c.row_count AS clean_row_count,
    c.row_count - a.row_count AS reconciliation_difference
FROM accepted_stage AS a
CROSS JOIN clean_count AS c;

-- Query 2: accepted amount versus clean amount.
WITH accepted_stage AS (
    SELECT SUM(order_amount) AS amount_total
    FROM staged_sales_output
    WHERE validation_status = 'ACCEPTED'
),
clean_total AS (
    SELECT SUM(order_amount) AS amount_total
    FROM clean_sales_output
)
SELECT
    a.amount_total AS accepted_stage_amount,
    c.amount_total AS clean_amount,
    c.amount_total - a.amount_total AS reconciliation_difference
FROM accepted_stage AS a
CROSS JOIN clean_total AS c;

-- Query 3: accepted stage rows missing from clean.
SELECT
    st.order_id,
    st.standard_status,
    st.order_amount,
    st.source_file
FROM staged_sales_output AS st
LEFT JOIN clean_sales_output AS c
    ON st.order_id = c.order_id
WHERE st.validation_status = 'ACCEPTED'
  AND c.order_id IS NULL
ORDER BY
    st.order_id;

-- Query 4: clean-only rows compared with accepted stage.
SELECT
    c.order_id,
    c.order_status,
    c.order_amount,
    c.source_file
FROM clean_sales_output AS c
LEFT JOIN staged_sales_output AS st
    ON c.order_id = st.order_id
   AND st.validation_status = 'ACCEPTED'
WHERE st.order_id IS NULL
ORDER BY
    c.order_id;

-- Query 5: amount mismatch between accepted stage and clean.
SELECT
    st.order_id,
    st.order_amount AS staged_amount,
    c.order_amount AS clean_amount,
    c.order_amount - st.order_amount AS reconciliation_difference
FROM staged_sales_output AS st
INNER JOIN clean_sales_output AS c
    ON st.order_id = c.order_id
WHERE st.validation_status = 'ACCEPTED'
  AND st.order_amount <> c.order_amount
ORDER BY
    st.order_id;
