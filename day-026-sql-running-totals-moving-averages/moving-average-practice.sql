-- Day 026: Moving Average Practice
-- Topic: Row-based moving averages and review flags.
-- Safety note: every query in this file is read-only.

-- Three-row moving sales average.
WITH sales_metrics AS (
    SELECT
        sale_date,
        region,
        total_sales,
        AVG(total_sales) OVER (
            PARTITION BY region
            ORDER BY sale_date, loaded_at
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ) AS three_row_moving_average,
        COUNT(total_sales) OVER (
            PARTITION BY region
            ORDER BY sale_date, loaded_at
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ) AS non_null_values_in_frame
    FROM daily_sales_metrics
)
SELECT *,
    CASE
        WHEN total_sales IS NULL THEN 'REVIEW_NULL'
        WHEN non_null_values_in_frame < 2 THEN 'INSUFFICIENT_DATA'
        WHEN total_sales > three_row_moving_average THEN 'ABOVE_MOVING_AVERAGE'
        WHEN total_sales < three_row_moving_average THEN 'BELOW_MOVING_AVERAGE'
        ELSE 'EQUAL_TO_MOVING_AVERAGE'
    END AS moving_average_flag
FROM sales_metrics
ORDER BY region, sale_date;

-- Campaign spend moving average.
SELECT campaign_id, channel, metric_date, spend,
    AVG(spend) OVER (
        PARTITION BY campaign_id
        ORDER BY metric_date, loaded_at
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS three_row_moving_spend_average,
    COUNT(spend) OVER (
        PARTITION BY campaign_id
        ORDER BY metric_date, loaded_at
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS spend_values_in_frame
FROM campaign_daily_metrics
ORDER BY campaign_id, metric_date;

-- Load-duration moving average.
SELECT pipeline_name, load_date, load_duration_minutes,
    AVG(load_duration_minutes) OVER (
        PARTITION BY pipeline_name
        ORDER BY load_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS three_row_moving_duration_average
FROM pipeline_load_metrics
ORDER BY pipeline_name, load_date;

-- Inventory moving average.
SELECT product_id, inventory_date, stock_on_hand,
    AVG(stock_on_hand) OVER (
        PARTITION BY product_id
        ORDER BY inventory_date, loaded_at
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS three_row_moving_stock_average
FROM product_inventory_history
ORDER BY product_id, inventory_date, loaded_at;
