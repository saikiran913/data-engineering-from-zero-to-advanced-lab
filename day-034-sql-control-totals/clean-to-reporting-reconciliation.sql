-- Day 034: Clean-to-Reporting Reconciliation
-- Purpose: Compare clean sales controls with reporting summary controls.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Control queries do not modify data.

-- Query 1: clean row count versus reporting row count.
-- Expected relationship: reporting row count is usually lower because reporting is aggregated.
WITH clean_count AS (
    SELECT COUNT(*) AS row_count
    FROM clean_sales_output
),
report_count AS (
    SELECT COUNT(*) AS row_count
    FROM reporting_sales_summary
)
SELECT
    c.row_count AS clean_row_count,
    r.row_count AS reporting_row_count,
    r.row_count - c.row_count AS reconciliation_difference,
    'REPORTING_IS_AGGREGATED' AS expected_difference_note
FROM clean_count AS c
CROSS JOIN report_count AS r;

-- Query 2: clean completed amount versus reporting completed amount.
WITH clean_completed AS (
    SELECT SUM(order_amount) AS completed_amount
    FROM clean_sales_output
    WHERE order_status = 'COMPLETED'
),
report_completed AS (
    SELECT SUM(total_completed_amount) AS completed_amount
    FROM reporting_sales_summary
)
SELECT
    c.completed_amount AS clean_completed_amount,
    r.completed_amount AS reporting_completed_amount,
    r.completed_amount - c.completed_amount AS reconciliation_difference
FROM clean_completed AS c
CROSS JOIN report_completed AS r;

-- Query 3: clean pending count versus reporting pending count.
WITH clean_pending AS (
    SELECT COUNT(*) AS pending_count
    FROM clean_sales_output
    WHERE order_status = 'PENDING'
),
report_pending AS (
    SELECT SUM(pending_order_count) AS pending_count
    FROM reporting_sales_summary
)
SELECT
    c.pending_count AS clean_pending_count,
    r.pending_count AS reporting_pending_count,
    r.pending_count - c.pending_count AS reconciliation_difference
FROM clean_pending AS c
CROSS JOIN report_pending AS r;

-- Query 4: reporting duplicate grain.
SELECT
    report_date,
    country_group,
    COUNT(*) AS row_count
FROM reporting_sales_summary
GROUP BY
    report_date,
    country_group
HAVING COUNT(*) > 1
ORDER BY
    report_date,
    country_group;

-- Query 5: null reporting metrics.
SELECT
    report_date,
    country_group,
    total_completed_amount,
    reporting_loaded_at
FROM reporting_sales_summary
WHERE completed_order_count IS NULL
   OR total_completed_amount IS NULL
   OR refund_order_count IS NULL
   OR total_refund_amount IS NULL
   OR pending_order_count IS NULL
ORDER BY
    report_date,
    country_group;
