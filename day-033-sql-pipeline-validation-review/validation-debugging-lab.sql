-- Day 033: Validation Debugging Lab
-- Purpose: Practise finding misleading validation results.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Validation queries do not modify source or target data.

-- Debug 1: matching or similar row counts are not enough.
-- Follow up with distinct keys and duplicates.
SELECT
    COUNT(*) AS clean_row_count,
    COUNT(DISTINCT order_id) AS clean_distinct_order_count
FROM clean_order_output;

-- Debug 2: global completed total may hide grouped issues.
WITH clean_total AS (
    SELECT
        SUM(CASE WHEN order_status = 'COMPLETED' THEN order_amount ELSE 0 END)
            AS completed_amount
    FROM clean_order_output
),
reporting_total AS (
    SELECT
        SUM(total_completed_amount) AS completed_amount
    FROM reporting_order_metrics
)
SELECT
    c.completed_amount AS clean_completed_amount,
    r.completed_amount AS reporting_completed_amount,
    r.completed_amount - c.completed_amount AS difference
FROM clean_total AS c
CROSS JOIN reporting_total AS r;

-- Debug 3: find the grouped completed amount differences.
WITH clean_grouped AS (
    SELECT
        order_date AS report_date,
        country_group,
        SUM(CASE WHEN order_status = 'COMPLETED' THEN order_amount ELSE 0 END)
            AS completed_amount
    FROM clean_order_output
    GROUP BY
        order_date,
        country_group
),
report_grouped AS (
    SELECT
        report_date,
        country_group,
        SUM(total_completed_amount) AS completed_amount
    FROM reporting_order_metrics
    GROUP BY
        report_date,
        country_group
)
SELECT
    c.report_date,
    c.country_group,
    c.completed_amount AS clean_completed_amount,
    r.completed_amount AS reporting_completed_amount,
    r.completed_amount - c.completed_amount AS difference
FROM clean_grouped AS c
LEFT JOIN report_grouped AS r
    ON c.report_date = r.report_date
   AND c.country_group = r.country_group
WHERE r.completed_amount IS NULL
   OR c.completed_amount <> r.completed_amount
ORDER BY
    c.report_date,
    c.country_group;

-- Debug 4: check whether file completeness explains missing records.
SELECT
    source_file,
    COUNT(*) AS source_row_count
FROM source_order_extract
GROUP BY
    source_file
ORDER BY
    source_file;

-- Debug 5: review target-only records before trusting clean output.
SELECT
    c.order_id,
    c.order_amount,
    c.source_file
FROM clean_order_output AS c
LEFT JOIN source_order_extract AS s
    ON c.order_id = s.order_id
WHERE s.order_id IS NULL
ORDER BY
    c.order_id;
