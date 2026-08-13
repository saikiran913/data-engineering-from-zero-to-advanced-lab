-- Day 034: Accepted and Review Controls
-- Purpose: Validate accepted/review population controls.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Control queries do not modify data.

-- Query 1: accepted-review reconciliation.
-- Source population: staged_sales_output.
-- Target population: accepted plus review groups.
-- Source grain: one staged sales candidate.
-- Target grain: one validation-status population.
-- Control type: accepted-review count.
-- Expected relationship: total stage count equals accepted count plus review count.
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

-- Query 2: accepted/review by validation reason.
SELECT
    validation_status,
    validation_reason,
    COUNT(*) AS row_count,
    SUM(order_amount) AS amount_total
FROM staged_sales_output
GROUP BY
    validation_status,
    validation_reason
ORDER BY
    validation_status,
    validation_reason;

-- Query 3: accepted rows with missing source file.
SELECT
    stage_record_id,
    order_id,
    order_amount,
    source_file,
    validation_reason
FROM staged_sales_output
WHERE validation_status = 'ACCEPTED'
  AND source_file IS NULL
ORDER BY
    stage_record_id;

-- Query 4: check whether accepted and review status values overlap incorrectly.
SELECT
    order_id,
    COUNT(DISTINCT validation_status) AS validation_status_count
FROM staged_sales_output
GROUP BY
    order_id
HAVING COUNT(DISTINCT validation_status) > 1
ORDER BY
    order_id;
