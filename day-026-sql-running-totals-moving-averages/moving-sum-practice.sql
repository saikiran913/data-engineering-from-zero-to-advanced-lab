-- Day 026: Moving Sum Practice
-- Topic: Limited row-based sums with explicit ROWS frames.
-- Safety note: every query in this file is read-only.

-- Three-row moving sales sum.
SELECT sale_date, region, total_sales,
    SUM(total_sales) OVER (
        PARTITION BY region
        ORDER BY sale_date, loaded_at
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS three_row_moving_sales_sum,
    COUNT(total_sales) OVER (
        PARTITION BY region
        ORDER BY sale_date, loaded_at
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS frame_non_null_row_count
FROM daily_sales_metrics
ORDER BY region, sale_date, loaded_at;

-- Two-row moving order amount.
SELECT customer_id, order_date, order_id, order_amount,
    SUM(order_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date, loaded_at, order_id
        ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
    ) AS two_row_moving_order_sum
FROM customer_order_metrics
WHERE order_status = 'COMPLETED'
ORDER BY customer_id, order_date, loaded_at, order_id;

-- Three-row moving records loaded.
SELECT pipeline_name, load_date, records_loaded,
    SUM(records_loaded) OVER (
        PARTITION BY pipeline_name
        ORDER BY load_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS three_row_moving_loaded_sum
FROM pipeline_load_metrics
ORDER BY pipeline_name, load_date;

-- Three-row moving campaign conversions.
SELECT campaign_id, channel, metric_date, conversions,
    SUM(conversions) OVER (
        PARTITION BY campaign_id
        ORDER BY metric_date, loaded_at
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS three_row_moving_conversions
FROM campaign_daily_metrics
ORDER BY campaign_id, metric_date;

-- Compare one-row, two-row, and three-row windows.
SELECT sale_date, region, total_sales,
    SUM(total_sales) OVER (
        PARTITION BY region
        ORDER BY sale_date, loaded_at
        ROWS BETWEEN CURRENT ROW AND CURRENT ROW
    ) AS current_row_sales,
    SUM(total_sales) OVER (
        PARTITION BY region
        ORDER BY sale_date, loaded_at
        ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
    ) AS two_row_sales,
    SUM(total_sales) OVER (
        PARTITION BY region
        ORDER BY sale_date, loaded_at
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS three_row_sales
FROM daily_sales_metrics
ORDER BY region, sale_date, loaded_at;
