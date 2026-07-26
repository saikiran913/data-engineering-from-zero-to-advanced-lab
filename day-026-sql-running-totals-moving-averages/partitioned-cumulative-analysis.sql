-- Day 026: Partitioned Cumulative Analysis
-- Topic: Restart cumulative and moving calculations by business group.
-- Safety note: every query in this file is read-only.

-- Region-based cumulative sales.
SELECT sale_date, region, total_sales,
    SUM(total_sales) OVER (
        PARTITION BY region
        ORDER BY sale_date, loaded_at
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS region_running_sales
FROM daily_sales_metrics
WHERE total_sales IS NOT NULL
ORDER BY region, sale_date, loaded_at;

-- Customer-based cumulative order amount.
SELECT customer_id, order_date, order_id, order_amount,
    SUM(order_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date, loaded_at, order_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS customer_running_amount
FROM customer_order_metrics
WHERE order_status = 'COMPLETED'
  AND order_amount IS NOT NULL
ORDER BY customer_id, order_date, loaded_at;

-- Product-based cumulative units sold.
SELECT product_id, inventory_date, units_sold,
    SUM(units_sold) OVER (
        PARTITION BY product_id
        ORDER BY inventory_date, loaded_at
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_units_sold
FROM product_inventory_history
ORDER BY product_id, inventory_date, loaded_at;

-- Campaign-based cumulative conversions.
SELECT campaign_id, metric_date, conversions,
    SUM(conversions) OVER (
        PARTITION BY campaign_id
        ORDER BY metric_date, loaded_at
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_conversions
FROM campaign_daily_metrics
ORDER BY campaign_id, metric_date, loaded_at;

-- Pipeline-based cumulative records loaded.
SELECT pipeline_name, load_date, records_loaded,
    SUM(records_loaded) OVER (
        PARTITION BY pipeline_name
        ORDER BY load_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_records_loaded
FROM pipeline_load_metrics
ORDER BY pipeline_name, load_date;

-- Channel-based moving average after aggregation.
WITH channel_daily AS (
    SELECT channel, metric_date, SUM(conversions) AS channel_conversions
    FROM campaign_daily_metrics
    GROUP BY channel, metric_date
)
SELECT channel, metric_date, channel_conversions,
    AVG(channel_conversions) OVER (
        PARTITION BY channel
        ORDER BY metric_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS three_day_row_moving_conversions
FROM channel_daily
ORDER BY channel, metric_date;

-- Global versus partitioned running totals.
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
