-- Day 033: Row-Count Validation
-- Purpose: Compare row counts across source, stage, clean, and reporting outputs.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Validation queries do not modify source or target data.

-- Query 1: source row count.
-- Source population: source_order_extract.
-- Target population: not applicable.
-- Source grain: one extracted source record.
-- Target grain: not applicable.
-- Business key: source_record_id.
-- Expected relationship: source row count should be greater than zero.
SELECT
    COUNT(*) AS source_row_count
FROM source_order_extract;

-- Query 2: stage row count.
-- Source population: staged_order_output.
-- Target population: not applicable.
-- Source grain: one staged candidate.
-- Business key: stage_record_id.
SELECT
    COUNT(*) AS stage_row_count
FROM staged_order_output;

-- Query 3: clean row count.
-- Source population: clean_order_output.
-- Source grain: one clean order.
-- Business key: order_id.
SELECT
    COUNT(*) AS clean_row_count
FROM clean_order_output;

-- Query 4: reporting row count.
-- Source population: reporting_order_metrics.
-- Source grain: one report date and country group row.
-- Business key: report_date plus country_group.
SELECT
    COUNT(*) AS reporting_row_count
FROM reporting_order_metrics;

-- Query 5: source-to-stage count comparison.
-- Expected difference: source may contain duplicate records and stage may contain review-only records.
WITH source_count AS (
    SELECT COUNT(*) AS row_count
    FROM source_order_extract
),
stage_count AS (
    SELECT COUNT(*) AS row_count
    FROM staged_order_output
)
SELECT
    s.row_count AS source_row_count,
    t.row_count AS stage_row_count,
    t.row_count - s.row_count AS row_count_difference,
    CASE
        WHEN t.row_count = s.row_count THEN 'PASS_REVIEW_DETAILS'
        ELSE 'REVIEW_EXPECTED_DIFFERENCE'
    END AS validation_status
FROM source_count AS s
CROSS JOIN stage_count AS t;

-- Query 6: accepted and review reconciliation.
-- Expected relationship: accepted rows plus review rows should equal staged rows.
SELECT
    COUNT(*) AS staged_count,
    SUM(CASE WHEN validation_status = 'ACCEPTED' THEN 1 ELSE 0 END) AS accepted_count,
    SUM(CASE WHEN validation_status = 'REVIEW' THEN 1 ELSE 0 END) AS review_count,
    COUNT(*)
        - SUM(CASE WHEN validation_status = 'ACCEPTED' THEN 1 ELSE 0 END)
        - SUM(CASE WHEN validation_status = 'REVIEW' THEN 1 ELSE 0 END)
        AS unexplained_difference
FROM staged_order_output;

-- Query 7: accepted stage count compared with clean count.
-- Expected difference: accepted staged rows should normally explain clean rows, after duplicate review.
WITH accepted_stage AS (
    SELECT COUNT(*) AS row_count
    FROM staged_order_output
    WHERE validation_status = 'ACCEPTED'
),
clean_count AS (
    SELECT COUNT(*) AS row_count
    FROM clean_order_output
)
SELECT
    a.row_count AS accepted_stage_count,
    c.row_count AS clean_row_count,
    c.row_count - a.row_count AS row_count_difference
FROM accepted_stage AS a
CROSS JOIN clean_count AS c;

-- Query 8: row counts by source file.
-- Expected relationship: files with source rows should be visible for file-level validation.
SELECT
    source_file,
    COUNT(*) AS source_row_count
FROM source_order_extract
GROUP BY
    source_file
ORDER BY
    source_file;
