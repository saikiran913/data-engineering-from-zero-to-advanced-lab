-- Day 026: Step-by-Step Cumulative Workflows
-- Topic: Design cumulative and moving calculations with validation.
-- Safety note: every query in this file is read-only.

-- Worked example 1: Running sales by region.
SELECT sale_date, region, total_sales,
    SUM(total_sales) OVER (
        PARTITION BY region
        ORDER BY sale_date, loaded_at
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_sales
FROM daily_sales_metrics
WHERE total_sales IS NOT NULL
ORDER BY region, sale_date, loaded_at;

-- Worked example 2: Cumulative customer spending.
SELECT customer_id, order_date, order_id, order_amount,
    SUM(order_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date, loaded_at, order_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_customer_spend
FROM customer_order_metrics
WHERE order_status = 'COMPLETED'
  AND order_amount IS NOT NULL
ORDER BY customer_id, order_date, loaded_at;

-- Worked example 3: Cumulative pipeline records loaded.
SELECT pipeline_name, load_date, records_loaded,
    SUM(records_loaded) OVER (
        PARTITION BY pipeline_name
        ORDER BY load_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_loaded
FROM pipeline_load_metrics
ORDER BY pipeline_name, load_date;

-- Worked example 4: Three-row moving sales average.
SELECT sale_date, region, total_sales,
    AVG(total_sales) OVER (
        PARTITION BY region
        ORDER BY sale_date, loaded_at
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS three_row_moving_average
FROM daily_sales_metrics
ORDER BY region, sale_date;

-- Worked example 5: Three-row moving campaign conversions.
SELECT campaign_id, metric_date, conversions,
    AVG(conversions) OVER (
        PARTITION BY campaign_id
        ORDER BY metric_date, loaded_at
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_average_conversions
FROM campaign_daily_metrics
ORDER BY campaign_id, metric_date;

-- Worked example 6: Running inventory movement.
SELECT product_id, inventory_date, units_received, units_sold,
    SUM(units_received - units_sold) OVER (
        PARTITION BY product_id
        ORDER BY inventory_date, loaded_at
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_net_movement
FROM product_inventory_history
ORDER BY product_id, inventory_date, loaded_at;

-- Worked example 7: Moving load-duration average.
SELECT pipeline_name, load_date, load_duration_minutes,
    AVG(load_duration_minutes) OVER (
        PARTITION BY pipeline_name
        ORDER BY load_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_duration_average
FROM pipeline_load_metrics
ORDER BY pipeline_name, load_date;

-- Worked example 8: Global versus partitioned cumulative totals.
SELECT sale_date, region, total_sales,
    SUM(total_sales) OVER (
        ORDER BY sale_date, region, loaded_at
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS global_running_sales,
    SUM(total_sales) OVER (
        PARTITION BY region
        ORDER BY sale_date, loaded_at
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS region_running_sales
FROM daily_sales_metrics
WHERE total_sales IS NOT NULL
ORDER BY sale_date, region, loaded_at;

-- Design checklist:
-- grain, partition, ordering, tie-breaker, measure, cumulative or moving,
-- frame definition, null policy, duplicate-row policy, missing-date policy,
-- and validation checks.
