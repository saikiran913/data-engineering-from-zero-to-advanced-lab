-- Day 033: Control-Total Validation
-- Purpose: Use numeric totals as reconciliation evidence.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Validation queries do not modify source or target data.

-- Query 1: source control totals by status.
-- Source grain: one source record.
-- Business key: order_id.
SELECT
    order_status,
    COUNT(*) AS source_row_count,
    SUM(order_amount) AS source_amount_total
FROM source_order_extract
GROUP BY
    order_status
ORDER BY
    order_status;

-- Query 2: clean control totals by status.
-- Target grain: one clean order.
SELECT
    order_status,
    COUNT(*) AS clean_row_count,
    SUM(order_amount) AS clean_amount_total
FROM clean_order_output
GROUP BY
    order_status
ORDER BY
    order_status;

-- Query 3: completed amount total from clean versus reporting.
-- Expected difference: reporting should reconcile to clean completed amounts unless documented.
WITH clean_completed AS (
    SELECT
        SUM(order_amount) AS completed_amount
    FROM clean_order_output
    WHERE order_status = 'COMPLETED'
),
reporting_completed AS (
    SELECT
        SUM(total_completed_amount) AS completed_amount
    FROM reporting_order_metrics
)
SELECT
    c.completed_amount AS clean_completed_amount,
    r.completed_amount AS reporting_completed_amount,
    r.completed_amount - c.completed_amount AS reconciliation_difference
FROM clean_completed AS c
CROSS JOIN reporting_completed AS r;

-- Query 4: completed count from clean versus reporting.
WITH clean_completed AS (
    SELECT
        COUNT(*) AS completed_count
    FROM clean_order_output
    WHERE order_status = 'COMPLETED'
),
reporting_completed AS (
    SELECT
        SUM(completed_order_count) AS completed_count
    FROM reporting_order_metrics
)
SELECT
    c.completed_count AS clean_completed_count,
    r.completed_count AS reporting_completed_count,
    r.completed_count - c.completed_count AS count_difference
FROM clean_completed AS c
CROSS JOIN reporting_completed AS r;

-- Query 5: refund total from clean versus reporting.
WITH clean_refund AS (
    SELECT
        SUM(order_amount) AS refund_amount
    FROM clean_order_output
    WHERE order_status = 'REFUNDED'
),
reporting_refund AS (
    SELECT
        SUM(total_refund_amount) AS refund_amount
    FROM reporting_order_metrics
)
SELECT
    c.refund_amount AS clean_refund_amount,
    r.refund_amount AS reporting_refund_amount,
    r.refund_amount - c.refund_amount AS amount_difference
FROM clean_refund AS c
CROSS JOIN reporting_refund AS r;

-- Query 6: accepted stage amount total compared with clean total.
-- Expected difference: accepted rows should explain clean totals after documented exclusions.
WITH accepted_stage AS (
    SELECT
        SUM(order_amount) AS accepted_amount_total
    FROM staged_order_output
    WHERE validation_status = 'ACCEPTED'
),
clean_total AS (
    SELECT
        SUM(order_amount) AS clean_amount_total
    FROM clean_order_output
)
SELECT
    a.accepted_amount_total,
    c.clean_amount_total,
    c.clean_amount_total - a.accepted_amount_total AS amount_difference
FROM accepted_stage AS a
CROSS JOIN clean_total AS c;
