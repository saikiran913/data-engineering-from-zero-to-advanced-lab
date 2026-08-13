-- Day 035: Completeness Percentages
-- Purpose: Calculate simple coverage percentages safely.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Completeness queries do not modify or fabricate data.

-- Query 1: expected clean order coverage percentage.
-- Numeric casting and percentage formatting vary across SQL platforms.
WITH expected_orders AS (
    SELECT DISTINCT
        expected_value AS order_id
    FROM expected_records_catalog
    WHERE expectation_type = 'ORDER_ID'
      AND stage_name = 'CLEAN'
),
matched_orders AS (
    SELECT
        e.order_id
    FROM expected_orders AS e
    INNER JOIN clean_customer_orders AS c
        ON e.order_id = c.order_id
)
SELECT
    (SELECT COUNT(*) FROM expected_orders) AS expected_order_count,
    (SELECT COUNT(*) FROM matched_orders) AS matched_order_count,
    CASE
        WHEN (SELECT COUNT(*) FROM expected_orders) = 0 THEN NULL
        ELSE 100.0 * (SELECT COUNT(*) FROM matched_orders)
            / (SELECT COUNT(*) FROM expected_orders)
    END AS completeness_percentage;

-- Query 2: source customer ID completeness percentage.
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN customer_id IS NOT NULL THEN 1 ELSE 0 END) AS populated_customer_id_rows,
    CASE
        WHEN COUNT(*) = 0 THEN NULL
        ELSE 100.0 * SUM(CASE WHEN customer_id IS NOT NULL THEN 1 ELSE 0 END)
            / COUNT(*)
    END AS customer_id_completeness_percentage
FROM source_customer_orders;

-- Query 3: reporting metric completeness percentage.
SELECT
    COUNT(*) AS reporting_rows,
    SUM(
        CASE
            WHEN completed_order_count IS NOT NULL
             AND total_completed_amount IS NOT NULL
             AND refund_order_count IS NOT NULL
             AND total_refund_amount IS NOT NULL
             AND pending_order_count IS NOT NULL
            THEN 1
            ELSE 0
        END
    ) AS complete_metric_rows,
    CASE
        WHEN COUNT(*) = 0 THEN NULL
        ELSE 100.0 * SUM(
            CASE
                WHEN completed_order_count IS NOT NULL
                 AND total_completed_amount IS NOT NULL
                 AND refund_order_count IS NOT NULL
                 AND total_refund_amount IS NOT NULL
                 AND pending_order_count IS NOT NULL
                THEN 1
                ELSE 0
            END
        ) / COUNT(*)
    END AS metric_completeness_percentage
FROM reporting_customer_orders;
