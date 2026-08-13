-- Day 034: Source-to-Stage Reconciliation
-- Purpose: Compare source sales controls with staged sales controls.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Control queries do not modify data.

-- Query 1: source count versus stage count.
-- Source population: source_sales_extract.
-- Target population: staged_sales_output.
-- Source grain: one source record.
-- Target grain: one staged candidate.
-- Control type: row count.
-- Expected relationship: counts may differ because of deduplication, review, or stage-only records.
WITH source_count AS (
    SELECT COUNT(*) AS row_count
    FROM source_sales_extract
),
stage_count AS (
    SELECT COUNT(*) AS row_count
    FROM staged_sales_output
)
SELECT
    s.row_count AS source_row_count,
    t.row_count AS stage_row_count,
    t.row_count - s.row_count AS reconciliation_difference
FROM source_count AS s
CROSS JOIN stage_count AS t;

-- Query 2: source distinct orders versus stage distinct orders.
WITH source_keys AS (
    SELECT COUNT(DISTINCT order_id) AS distinct_order_count
    FROM source_sales_extract
),
stage_keys AS (
    SELECT COUNT(DISTINCT order_id) AS distinct_order_count
    FROM staged_sales_output
)
SELECT
    s.distinct_order_count AS source_distinct_orders,
    t.distinct_order_count AS stage_distinct_orders,
    t.distinct_order_count - s.distinct_order_count AS reconciliation_difference
FROM source_keys AS s
CROSS JOIN stage_keys AS t;

-- Query 3: source-to-stage amount comparison.
WITH source_amount AS (
    SELECT SUM(order_amount) AS amount_total
    FROM source_sales_extract
),
stage_amount AS (
    SELECT SUM(order_amount) AS amount_total
    FROM staged_sales_output
)
SELECT
    s.amount_total AS source_amount_total,
    t.amount_total AS stage_amount_total,
    t.amount_total - s.amount_total AS reconciliation_difference
FROM source_amount AS s
CROSS JOIN stage_amount AS t;

-- Query 4: source-only orders compared with stage.
SELECT
    s.order_id,
    s.order_status,
    s.order_amount,
    s.source_file
FROM source_sales_extract AS s
LEFT JOIN staged_sales_output AS st
    ON s.order_id = st.order_id
WHERE st.order_id IS NULL
ORDER BY
    s.order_id;

-- Query 5: stage-only orders compared with source.
SELECT
    st.order_id,
    st.standard_status,
    st.order_amount,
    st.source_file,
    st.validation_reason
FROM staged_sales_output AS st
LEFT JOIN source_sales_extract AS s
    ON st.order_id = s.order_id
WHERE s.order_id IS NULL
ORDER BY
    st.order_id;
