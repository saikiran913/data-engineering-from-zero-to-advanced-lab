-- Day 034: Count Controls
-- Purpose: Practise row-count controls across source, stage, clean, and reporting.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Control queries do not modify data.

-- Query 1: COUNT(*) counts all source rows.
-- Source population: source_sales_extract.
-- Target population: not applicable.
-- Source grain: one extracted source record.
-- Target grain: not applicable.
-- Control type: row count.
-- Expected relationship: source count should be greater than zero.
SELECT
    COUNT(*) AS source_row_count
FROM source_sales_extract;

-- Query 2: COUNT(order_amount) excludes null order amounts.
-- Expected difference: this can be smaller than COUNT(*) when amount is null.
SELECT
    COUNT(*) AS source_row_count,
    COUNT(order_amount) AS non_null_amount_count,
    COUNT(*) - COUNT(order_amount) AS null_amount_count
FROM source_sales_extract;

-- Query 3: stage row count.
SELECT
    COUNT(*) AS stage_row_count
FROM staged_sales_output;

-- Query 4: accepted and review counts.
SELECT
    SUM(CASE WHEN validation_status = 'ACCEPTED' THEN 1 ELSE 0 END) AS accepted_count,
    SUM(CASE WHEN validation_status = 'REVIEW' THEN 1 ELSE 0 END) AS review_count
FROM staged_sales_output;

-- Query 5: clean row count.
SELECT
    COUNT(*) AS clean_row_count
FROM clean_sales_output;

-- Query 6: reporting row count.
SELECT
    COUNT(*) AS reporting_row_count
FROM reporting_sales_summary;

-- Query 7: stage count reconciliation.
WITH stage_counts AS (
    SELECT
        COUNT(*) AS total_stage_count,
        SUM(CASE WHEN validation_status = 'ACCEPTED' THEN 1 ELSE 0 END) AS accepted_count,
        SUM(CASE WHEN validation_status = 'REVIEW' THEN 1 ELSE 0 END) AS review_count
    FROM staged_sales_output
)
SELECT
    total_stage_count,
    accepted_count,
    review_count,
    total_stage_count - accepted_count - review_count AS unexplained_difference
FROM stage_counts;

-- Query 8: count-control summary.
SELECT
    'SOURCE_ROWS' AS control_name,
    COUNT(*) AS control_value
FROM source_sales_extract
UNION ALL
SELECT
    'STAGE_ROWS',
    COUNT(*)
FROM staged_sales_output
UNION ALL
SELECT
    'CLEAN_ROWS',
    COUNT(*)
FROM clean_sales_output
UNION ALL
SELECT
    'REPORTING_ROWS',
    COUNT(*)
FROM reporting_sales_summary;
