-- Day 034: Grouped Control Totals
-- Purpose: Compare controls by date, country, status, and source file.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Control queries do not modify data.

-- Query 1: source count and amount by status.
SELECT
    order_status,
    COUNT(*) AS source_row_count,
    SUM(order_amount) AS source_amount_total
FROM source_sales_extract
GROUP BY
    order_status
ORDER BY
    order_status;

-- Query 2: clean count and amount by status.
SELECT
    order_status,
    COUNT(*) AS clean_row_count,
    SUM(order_amount) AS clean_amount_total
FROM clean_sales_output
GROUP BY
    order_status
ORDER BY
    order_status;

-- Query 3: source count by source file.
SELECT
    source_file,
    COUNT(*) AS source_row_count,
    SUM(order_amount) AS source_amount_total
FROM source_sales_extract
GROUP BY
    source_file
ORDER BY
    source_file;

-- Query 4: clean amount by date and country group.
SELECT
    order_date,
    country_group,
    COUNT(*) AS clean_order_count,
    SUM(order_amount) AS clean_amount_total
FROM clean_sales_output
GROUP BY
    order_date,
    country_group
ORDER BY
    order_date,
    country_group;

-- Query 5: clean completed amount versus reporting by date and country group.
WITH clean_grouped AS (
    SELECT
        order_date AS report_date,
        country_group,
        SUM(CASE WHEN order_status = 'COMPLETED' THEN order_amount ELSE 0 END)
            AS completed_amount
    FROM clean_sales_output
    GROUP BY
        order_date,
        country_group
),
report_grouped AS (
    SELECT
        report_date,
        country_group,
        SUM(total_completed_amount) AS completed_amount
    FROM reporting_sales_summary
    GROUP BY
        report_date,
        country_group
)
SELECT
    c.report_date,
    c.country_group,
    c.completed_amount AS clean_completed_amount,
    r.completed_amount AS reporting_completed_amount,
    r.completed_amount - c.completed_amount AS reconciliation_difference
FROM clean_grouped AS c
LEFT JOIN report_grouped AS r
    ON c.report_date = r.report_date
   AND c.country_group = r.country_group
ORDER BY
    c.report_date,
    c.country_group;
