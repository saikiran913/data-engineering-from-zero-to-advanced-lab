-- Day 032: Reporting-Layer Handoff Practice
-- Purpose: Validate reporting grain and reconcile reporting totals.
-- Safety: All executable SQL is read-only and SELECT-based.
-- No staging or temporary object is deployed.

-- Query 1: build reporting summary from clean orders.
-- Input grain: one clean order.
-- Output grain: one row per order_date and country_group.
-- Business key: order_date plus country_group.
SELECT
    order_date AS report_date,
    country_group,
    SUM(
        CASE
            WHEN order_status = 'COMPLETED' THEN 1
            ELSE 0
        END
    ) AS completed_order_count,
    SUM(
        CASE
            WHEN order_status = 'COMPLETED' THEN order_amount
            ELSE 0
        END
    ) AS total_completed_amount,
    SUM(
        CASE
            WHEN order_status = 'REFUNDED' THEN 1
            ELSE 0
        END
    ) AS refund_order_count,
    SUM(
        CASE
            WHEN order_status = 'REFUNDED' THEN order_amount
            ELSE 0
        END
    ) AS total_refund_amount,
    SUM(
        CASE
            WHEN order_status = 'PENDING' THEN 1
            ELSE 0
        END
    ) AS pending_order_count
FROM clean_customer_orders
GROUP BY
    order_date,
    country_group
ORDER BY
    order_date,
    country_group;

-- Query 2: detect duplicate reporting grain in provided reporting output.
-- Input grain: one reporting row.
-- Output grain: one duplicate report key if found.
-- Business key: report_date plus country_group.
SELECT
    report_date,
    country_group,
    COUNT(*) AS reporting_row_count
FROM reporting_customer_order_summary
GROUP BY
    report_date,
    country_group
HAVING COUNT(*) > 1
ORDER BY
    report_date,
    country_group;

-- Query 3: find null reporting measures.
-- Input grain: one reporting row.
-- Output grain: one reporting row with a null measure.
-- Business key: report_date plus country_group.
SELECT
    report_date,
    country_group,
    completed_order_count,
    total_completed_amount,
    refund_order_count,
    total_refund_amount,
    pending_order_count
FROM reporting_customer_order_summary
WHERE completed_order_count IS NULL
   OR total_completed_amount IS NULL
   OR refund_order_count IS NULL
   OR total_refund_amount IS NULL
   OR pending_order_count IS NULL
ORDER BY
    report_date,
    country_group;

-- Query 4: reconcile completed totals between clean and reporting outputs.
-- Input grain: clean orders and reporting rows.
-- Output grain: one reconciliation row.
-- Business key: not applicable.
WITH clean_totals AS (
    SELECT
        SUM(
            CASE
                WHEN order_status = 'COMPLETED' THEN order_amount
                ELSE 0
            END
        ) AS completed_amount_total
    FROM clean_customer_orders
),
reporting_totals AS (
    SELECT
        SUM(total_completed_amount) AS completed_amount_total
    FROM reporting_customer_order_summary
)
SELECT
    clean_totals.completed_amount_total AS clean_completed_amount,
    reporting_totals.completed_amount_total AS reporting_completed_amount,
    clean_totals.completed_amount_total
        - reporting_totals.completed_amount_total AS amount_difference
FROM clean_totals
CROSS JOIN reporting_totals;

-- Query 5: inspect reporting date coverage.
-- Input grain: one reporting row.
-- Output grain: one date coverage summary.
-- Business key: not applicable.
SELECT
    MIN(report_date) AS earliest_report_date,
    MAX(report_date) AS latest_report_date,
    COUNT(*) AS reporting_row_count
FROM reporting_customer_order_summary;
