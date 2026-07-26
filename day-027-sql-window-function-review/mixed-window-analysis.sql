-- Day 027: Mixed Window Analysis
-- Purpose: Combine ranking, row comparison, cumulative metrics, moving metrics, and review flags.
-- Safety: All examples are read-only SELECT queries.

-- Workflow 1: Customer activity analysis.
-- Source grain: customer per activity date and load.
-- Output grain: customer activity row with separate review calculations.
WITH customer_base AS (
    SELECT
        customer_id,
        country,
        activity_date,
        total_spend,
        customer_status,
        loaded_at
    FROM customer_activity_metrics
),
customer_windows AS (
    SELECT
        customer_id,
        country,
        activity_date,
        total_spend,
        customer_status,
        ROW_NUMBER() OVER (
            PARTITION BY country
            ORDER BY total_spend DESC, customer_id, activity_date
        ) AS country_sales_row_number,
        LAG(total_spend) OVER (
            PARTITION BY customer_id
            ORDER BY activity_date, loaded_at
        ) AS previous_activity_spend,
        SUM(total_spend) OVER (
            PARTITION BY customer_id
            ORDER BY activity_date, loaded_at
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS running_customer_spend,
        AVG(total_spend) OVER (
            PARTITION BY customer_id
            ORDER BY activity_date, loaded_at
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ) AS three_row_moving_spend_avg
    FROM customer_base
)
SELECT
    customer_id,
    country,
    activity_date,
    total_spend,
    customer_status,
    country_sales_row_number,
    previous_activity_spend,
    running_customer_spend,
    three_row_moving_spend_avg,
    CASE
        WHEN total_spend IS NULL THEN 'REVIEW_NULL_SPEND'
        WHEN previous_activity_spend IS NULL THEN 'BOUNDARY_ROW'
        ELSE 'OK'
    END AS review_flag
FROM customer_windows
ORDER BY country, customer_id, activity_date;

-- Workflow 2: Product performance.
WITH product_windows AS (
    SELECT
        product_id,
        category,
        metric_date,
        units_sold,
        total_sales,
        stock_on_hand,
        RANK() OVER (
            PARTITION BY category
            ORDER BY total_sales DESC
        ) AS category_sales_rank,
        LAG(stock_on_hand) OVER (
            PARTITION BY product_id
            ORDER BY metric_date, loaded_at
        ) AS previous_stock_on_hand,
        SUM(units_sold) OVER (
            PARTITION BY product_id
            ORDER BY metric_date, loaded_at
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS running_units_sold,
        AVG(total_sales) OVER (
            PARTITION BY product_id
            ORDER BY metric_date, loaded_at
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ) AS three_row_moving_sales_avg
    FROM product_performance_history
)
SELECT
    product_id,
    category,
    metric_date,
    units_sold,
    total_sales,
    stock_on_hand,
    category_sales_rank,
    previous_stock_on_hand,
    running_units_sold,
    three_row_moving_sales_avg,
    CASE
        WHEN stock_on_hand IS NULL THEN 'REVIEW_NULL_STOCK'
        WHEN previous_stock_on_hand IS NULL THEN 'BOUNDARY_ROW'
        ELSE 'OK'
    END AS review_flag
FROM product_windows
ORDER BY category, product_id, metric_date;

-- Workflow 3: Campaign performance.
WITH campaign_windows AS (
    SELECT
        campaign_id,
        channel,
        country,
        metric_date,
        conversions,
        clicks,
        spend,
        RANK() OVER (
            PARTITION BY channel, country
            ORDER BY conversions DESC
        ) AS channel_country_conversion_rank,
        LAG(conversions) OVER (
            PARTITION BY campaign_id
            ORDER BY metric_date, loaded_at
        ) AS previous_conversions,
        SUM(spend) OVER (
            PARTITION BY campaign_id
            ORDER BY metric_date, loaded_at
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS running_campaign_spend,
        AVG(clicks) OVER (
            PARTITION BY campaign_id
            ORDER BY metric_date, loaded_at
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ) AS three_row_moving_click_avg
    FROM campaign_metrics_history
)
SELECT
    campaign_id,
    channel,
    country,
    metric_date,
    conversions,
    previous_conversions,
    running_campaign_spend,
    three_row_moving_click_avg,
    CASE
        WHEN spend IS NULL THEN 'REVIEW_NULL_SPEND'
        WHEN previous_conversions IS NULL THEN 'BOUNDARY_ROW'
        WHEN conversions - previous_conversions > 5 THEN 'REVIEW_LARGE_INCREASE'
        ELSE 'OK'
    END AS review_flag
FROM campaign_windows
ORDER BY channel, country, campaign_id, metric_date;

-- Workflow 4: Pipeline quality.
WITH pipeline_windows AS (
    SELECT
        pipeline_name,
        load_date,
        records_rejected,
        quality_issue_count,
        load_duration_minutes,
        RANK() OVER (
            PARTITION BY load_date
            ORDER BY quality_issue_count DESC
        ) AS issue_rank_for_load_date,
        LAG(quality_issue_count) OVER (
            PARTITION BY pipeline_name
            ORDER BY load_date
        ) AS previous_issue_count,
        SUM(records_rejected) OVER (
            PARTITION BY pipeline_name
            ORDER BY load_date
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS cumulative_records_rejected,
        AVG(load_duration_minutes) OVER (
            PARTITION BY pipeline_name
            ORDER BY load_date
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ) AS three_row_moving_duration_avg
    FROM pipeline_quality_history
)
SELECT
    pipeline_name,
    load_date,
    quality_issue_count,
    previous_issue_count,
    cumulative_records_rejected,
    three_row_moving_duration_avg,
    CASE
        WHEN load_duration_minutes IS NULL THEN 'REVIEW_NULL_DURATION'
        WHEN previous_issue_count IS NULL THEN 'BOUNDARY_ROW'
        WHEN quality_issue_count > previous_issue_count THEN 'REVIEW_ISSUES_INCREASED'
        ELSE 'OK'
    END AS review_flag
FROM pipeline_windows
ORDER BY pipeline_name, load_date;

-- Workflow 5: Regional sales.
WITH regional_windows AS (
    SELECT
        region,
        sale_date,
        total_sales,
        loaded_at,
        ROW_NUMBER() OVER (
            PARTITION BY region
            ORDER BY sale_date, loaded_at
        ) AS date_row_number,
        LAG(total_sales) OVER (
            PARTITION BY region
            ORDER BY sale_date, loaded_at
        ) AS previous_sales,
        LAG(sale_date) OVER (
            PARTITION BY region
            ORDER BY sale_date, loaded_at
        ) AS previous_sale_date,
        SUM(total_sales) OVER (
            PARTITION BY region
            ORDER BY sale_date, loaded_at
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS running_sales,
        AVG(total_sales) OVER (
            PARTITION BY region
            ORDER BY sale_date, loaded_at
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ) AS three_row_moving_sales_avg
    FROM regional_sales_history
)
SELECT
    region,
    sale_date,
    total_sales,
    previous_sales,
    previous_sale_date,
    running_sales,
    three_row_moving_sales_avg,
    CASE
        WHEN total_sales IS NULL THEN 'REVIEW_NULL_SALES'
        WHEN previous_sale_date IS NULL THEN 'BOUNDARY_ROW'
        ELSE 'CHECK_DATE_SEQUENCE'
    END AS review_flag
FROM regional_windows
ORDER BY region, sale_date, loaded_at;
