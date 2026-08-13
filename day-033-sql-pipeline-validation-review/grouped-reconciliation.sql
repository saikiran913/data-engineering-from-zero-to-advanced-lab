-- Day 033: Grouped Reconciliation
-- Purpose: Compare grouped totals so hidden mismatches become visible.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Validation queries do not modify source or target data.

-- Query 1: clean metrics by date and country group.
-- Source population: clean_order_output.
-- Target population: reporting_order_metrics.
-- Source grain: one clean order.
-- Target grain: one report date and country group.
-- Business key: report_date plus country_group.
WITH clean_metrics AS (
    SELECT
        order_date AS report_date,
        country_group,
        SUM(CASE WHEN order_status = 'COMPLETED' THEN 1 ELSE 0 END)
            AS completed_order_count,
        SUM(CASE WHEN order_status = 'COMPLETED' THEN order_amount ELSE 0 END)
            AS total_completed_amount,
        SUM(CASE WHEN order_status = 'REFUNDED' THEN 1 ELSE 0 END)
            AS refund_order_count,
        SUM(CASE WHEN order_status = 'REFUNDED' THEN order_amount ELSE 0 END)
            AS total_refund_amount,
        SUM(CASE WHEN order_status = 'PENDING' THEN 1 ELSE 0 END)
            AS pending_order_count
    FROM clean_order_output
    GROUP BY
        order_date,
        country_group
),
reporting_metrics AS (
    SELECT
        report_date,
        country_group,
        SUM(completed_order_count) AS completed_order_count,
        SUM(total_completed_amount) AS total_completed_amount,
        SUM(refund_order_count) AS refund_order_count,
        SUM(total_refund_amount) AS total_refund_amount,
        SUM(pending_order_count) AS pending_order_count
    FROM reporting_order_metrics
    GROUP BY
        report_date,
        country_group
)
SELECT
    c.report_date,
    c.country_group,
    c.completed_order_count AS clean_completed_count,
    r.completed_order_count AS reporting_completed_count,
    c.total_completed_amount AS clean_completed_amount,
    r.total_completed_amount AS reporting_completed_amount,
    r.total_completed_amount - c.total_completed_amount AS amount_difference
FROM clean_metrics AS c
LEFT JOIN reporting_metrics AS r
    ON c.report_date = r.report_date
   AND c.country_group = r.country_group
ORDER BY
    c.report_date,
    c.country_group;

-- Query 2: source amount by source file.
SELECT
    source_file,
    COUNT(*) AS source_row_count,
    SUM(order_amount) AS source_amount_total
FROM source_order_extract
GROUP BY
    source_file
ORDER BY
    source_file;

-- Query 3: clean amount by source file.
SELECT
    source_file,
    COUNT(*) AS clean_row_count,
    SUM(order_amount) AS clean_amount_total
FROM clean_order_output
GROUP BY
    source_file
ORDER BY
    source_file;

-- Query 4: clean metrics by country group.
SELECT
    country_group,
    COUNT(*) AS clean_row_count,
    SUM(order_amount) AS clean_amount_total
FROM clean_order_output
GROUP BY
    country_group
ORDER BY
    country_group;

-- Query 5: reporting metrics by country group.
SELECT
    country_group,
    SUM(completed_order_count) AS completed_order_count,
    SUM(total_completed_amount) AS total_completed_amount,
    SUM(refund_order_count) AS refund_order_count,
    SUM(total_refund_amount) AS total_refund_amount,
    SUM(pending_order_count) AS pending_order_count
FROM reporting_order_metrics
GROUP BY
    country_group
ORDER BY
    country_group;
