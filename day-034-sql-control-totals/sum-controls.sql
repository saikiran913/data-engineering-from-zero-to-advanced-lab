-- Day 034: Sum Controls
-- Purpose: Use SUM as a numeric control total.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Control queries do not modify data.

-- Query 1: source amount total.
-- Source population: all source sales rows.
-- Control type: sum.
-- Expected relationship: source total is evidence, not automatically a target expectation.
SELECT
    SUM(order_amount) AS source_amount_total
FROM source_sales_extract;

-- Query 2: accepted staged amount total.
SELECT
    SUM(order_amount) AS accepted_stage_amount_total
FROM staged_sales_output
WHERE validation_status = 'ACCEPTED';

-- Query 3: clean amount total.
SELECT
    SUM(order_amount) AS clean_amount_total
FROM clean_sales_output;

-- Query 4: completed clean amount versus reporting completed amount.
WITH clean_completed AS (
    SELECT
        SUM(order_amount) AS completed_amount
    FROM clean_sales_output
    WHERE order_status = 'COMPLETED'
),
reporting_completed AS (
    SELECT
        SUM(total_completed_amount) AS completed_amount
    FROM reporting_sales_summary
)
SELECT
    c.completed_amount AS clean_completed_amount,
    r.completed_amount AS reporting_completed_amount,
    r.completed_amount - c.completed_amount AS reconciliation_difference
FROM clean_completed AS c
CROSS JOIN reporting_completed AS r;

-- Query 5: refund clean amount versus reporting refund amount.
WITH clean_refund AS (
    SELECT
        SUM(order_amount) AS refund_amount
    FROM clean_sales_output
    WHERE order_status = 'REFUNDED'
),
reporting_refund AS (
    SELECT
        SUM(total_refund_amount) AS refund_amount
    FROM reporting_sales_summary
)
SELECT
    c.refund_amount AS clean_refund_amount,
    r.refund_amount AS reporting_refund_amount,
    r.refund_amount - c.refund_amount AS reconciliation_difference
FROM clean_refund AS c
CROSS JOIN reporting_refund AS r;

-- Query 6: accepted stage amount versus clean amount.
WITH accepted_stage AS (
    SELECT
        SUM(order_amount) AS accepted_amount
    FROM staged_sales_output
    WHERE validation_status = 'ACCEPTED'
),
clean_total AS (
    SELECT
        SUM(order_amount) AS clean_amount
    FROM clean_sales_output
)
SELECT
    a.accepted_amount AS accepted_stage_amount,
    c.clean_amount AS clean_amount,
    c.clean_amount - a.accepted_amount AS reconciliation_difference
FROM accepted_stage AS a
CROSS JOIN clean_total AS c;
