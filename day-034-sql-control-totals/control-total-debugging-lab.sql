-- Day 034: Control-Total Debugging Lab
-- Purpose: Show why one matching control is not enough.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Control queries do not modify data.

-- Debug 1: row count and distinct-key count answer different questions.
SELECT
    COUNT(*) AS clean_row_count,
    COUNT(DISTINCT order_id) AS clean_distinct_order_count,
    COUNT(*) - COUNT(DISTINCT order_id) AS duplicate_key_rows
FROM clean_sales_output;

-- Debug 2: a grand total can hide grouped differences.
WITH clean_grouped AS (
    SELECT
        order_date AS report_date,
        country_group,
        SUM(CASE WHEN order_status = 'COMPLETED' THEN order_amount ELSE 0 END)
            AS completed_amount
    FROM clean_sales_output
    GROUP BY order_date, country_group
),
report_grouped AS (
    SELECT
        report_date,
        country_group,
        SUM(total_completed_amount) AS completed_amount
    FROM reporting_sales_summary
    GROUP BY report_date, country_group
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
   OR r.completed_amount <> c.completed_amount
ORDER BY
    c.report_date,
    c.country_group;

-- Debug 3: boundary checks reveal target-only future data.
SELECT
    MIN(order_date) AS minimum_clean_date,
    MAX(order_date) AS maximum_clean_date,
    MIN(order_amount) AS minimum_clean_amount,
    MAX(order_amount) AS maximum_clean_amount
FROM clean_sales_output;

-- Debug 4: source-file control reveals missing stage lineage.
SELECT
    source_file,
    COUNT(*) AS stage_row_count
FROM staged_sales_output
GROUP BY
    source_file
ORDER BY
    source_file;

-- Debug 5: inspect target-only clean records.
SELECT
    c.order_id,
    c.order_amount,
    c.source_file
FROM clean_sales_output AS c
LEFT JOIN source_sales_extract AS s
    ON c.order_id = s.order_id
WHERE s.order_id IS NULL
ORDER BY
    c.order_id;
