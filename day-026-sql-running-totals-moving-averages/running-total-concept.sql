-- Day 026: Running Total Concept
-- Topic: Calculate cumulative values while keeping row detail visible.
-- Safety note: every query in this file is read-only.

-- Section 1: Preview sample data.
SELECT sale_date, region, total_orders, total_sales, loaded_at
FROM daily_sales_metrics
ORDER BY region, sale_date, loaded_at;

-- Section 2: Normal GROUP BY total collapses rows.
SELECT region, SUM(total_sales) AS grouped_sales_total
FROM daily_sales_metrics
WHERE total_sales IS NOT NULL
GROUP BY region
ORDER BY region;

-- Section 3: Running sales total by region.
-- Grain: one row per region, sale date, and load timestamp.
-- Partition: region. Ordering: sale_date, loaded_at.
-- Frame: all earlier rows through current row.
SELECT
    sale_date,
    region,
    total_sales,
    SUM(total_sales) OVER (
        PARTITION BY region
        ORDER BY sale_date, loaded_at
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_sales
FROM daily_sales_metrics
WHERE total_sales IS NOT NULL
ORDER BY region, sale_date, loaded_at;

-- Section 4: Running order count by region.
SELECT
    sale_date,
    region,
    total_orders,
    COUNT(*) OVER (
        PARTITION BY region
        ORDER BY sale_date, loaded_at
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_row_count
FROM daily_sales_metrics
ORDER BY region, sale_date, loaded_at;

-- Section 5: Running loaded records by pipeline.
SELECT
    pipeline_name,
    load_date,
    records_loaded,
    SUM(records_loaded) OVER (
        PARTITION BY pipeline_name
        ORDER BY load_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_records_loaded
FROM pipeline_load_metrics
ORDER BY pipeline_name, load_date;

-- Section 6: Running customer order amount.
-- Business rule: include completed orders with non-null amounts.
SELECT
    customer_id,
    order_date,
    order_id,
    order_amount,
    SUM(order_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date, loaded_at, order_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_completed_order_amount
FROM customer_order_metrics
WHERE order_status = 'COMPLETED'
  AND order_amount IS NOT NULL
ORDER BY customer_id, order_date, loaded_at, order_id;

-- Section 7: Final cumulative value should match grouped total.
WITH running_metrics AS (
    SELECT
        region,
        sale_date,
        loaded_at,
        total_sales,
        SUM(total_sales) OVER (
            PARTITION BY region
            ORDER BY sale_date, loaded_at
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS running_sales,
        ROW_NUMBER() OVER (
            PARTITION BY region
            ORDER BY sale_date DESC, loaded_at DESC
        ) AS reverse_row_num
    FROM daily_sales_metrics
    WHERE total_sales IS NOT NULL
),
grouped_totals AS (
    SELECT region, SUM(total_sales) AS grouped_sales_total
    FROM daily_sales_metrics
    WHERE total_sales IS NOT NULL
    GROUP BY region
)
SELECT
    r.region,
    r.running_sales AS final_running_sales,
    g.grouped_sales_total,
    r.running_sales - g.grouped_sales_total AS reconciliation_difference
FROM running_metrics AS r
JOIN grouped_totals AS g
    ON r.region = g.region
WHERE r.reverse_row_num = 1
ORDER BY r.region;

-- Practice tasks:
-- 1. Change running sales to running refund amount.
-- 2. Compare global running sales with region running sales.
-- 3. Explain why duplicate dates need loaded_at in the ordering rule.
