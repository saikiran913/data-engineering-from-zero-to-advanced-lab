-- Day 027: Cumulative and Moving Window Review
-- Purpose: Review running totals, cumulative metrics, moving windows, and reconciliation.
-- Safety: All examples are read-only SELECT queries.

-- Running customer spend.
SELECT
    customer_id,
    activity_date,
    total_spend,
    SUM(total_spend) OVER (
        PARTITION BY customer_id
        ORDER BY activity_date, loaded_at
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_customer_spend
FROM customer_activity_metrics
ORDER BY customer_id, activity_date, loaded_at;

-- Running regional sales.
SELECT
    region,
    sale_date,
    total_sales,
    SUM(total_sales) OVER (
        PARTITION BY region
        ORDER BY sale_date, loaded_at
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_region_sales
FROM regional_sales_history
ORDER BY region, sale_date, loaded_at;

-- Cumulative rejected records by pipeline.
SELECT
    pipeline_name,
    load_date,
    records_rejected,
    SUM(records_rejected) OVER (
        PARTITION BY pipeline_name
        ORDER BY load_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_records_rejected
FROM pipeline_quality_history
ORDER BY pipeline_name, load_date;

-- Three-row moving campaign spend average.
SELECT
    campaign_id,
    metric_date,
    spend,
    AVG(spend) OVER (
        PARTITION BY campaign_id
        ORDER BY metric_date, loaded_at
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS three_row_moving_spend_avg
FROM campaign_metrics_history
ORDER BY campaign_id, metric_date;

-- Three-row moving product sales sum.
SELECT
    product_id,
    metric_date,
    total_sales,
    SUM(total_sales) OVER (
        PARTITION BY product_id
        ORDER BY metric_date, loaded_at
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS three_row_moving_sales_sum
FROM product_performance_history
ORDER BY product_id, metric_date, loaded_at;

-- Global running total versus partitioned running total.
SELECT
    region,
    sale_date,
    total_sales,
    SUM(total_sales) OVER (
        ORDER BY sale_date, region, loaded_at
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS global_running_sales,
    SUM(total_sales) OVER (
        PARTITION BY region
        ORDER BY sale_date, loaded_at
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS region_running_sales
FROM regional_sales_history
ORDER BY sale_date, region, loaded_at;

-- Cumulative count and average for customer rows.
SELECT
    customer_id,
    activity_date,
    total_spend,
    COUNT(*) OVER (
        PARTITION BY customer_id
        ORDER BY activity_date, loaded_at
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS activity_rows_so_far,
    AVG(total_spend) OVER (
        PARTITION BY customer_id
        ORDER BY activity_date, loaded_at
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS average_spend_so_far
FROM customer_activity_metrics
ORDER BY customer_id, activity_date, loaded_at;

-- Cumulative min and max campaign conversions.
SELECT
    campaign_id,
    metric_date,
    conversions,
    MIN(conversions) OVER (
        PARTITION BY campaign_id
        ORDER BY metric_date, loaded_at
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS min_conversions_so_far,
    MAX(conversions) OVER (
        PARTITION BY campaign_id
        ORDER BY metric_date, loaded_at
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS max_conversions_so_far
FROM campaign_metrics_history
ORDER BY campaign_id, metric_date;

-- Final-total reconciliation for regional sales.
WITH running_sales AS (
    SELECT
        region,
        sale_date,
        loaded_at,
        total_sales,
        SUM(total_sales) OVER (
            PARTITION BY region
            ORDER BY sale_date, loaded_at
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS running_region_sales,
        ROW_NUMBER() OVER (
            PARTITION BY region
            ORDER BY sale_date DESC, loaded_at DESC
        ) AS latest_row_number
    FROM regional_sales_history
),
source_totals AS (
    SELECT
        region,
        SUM(total_sales) AS source_total_sales
    FROM regional_sales_history
    GROUP BY region
)
SELECT
    running_sales.region,
    running_sales.running_region_sales AS final_running_sales,
    source_totals.source_total_sales,
    CASE
        WHEN running_sales.running_region_sales = source_totals.source_total_sales THEN 'PASS'
        ELSE 'REVIEW'
    END AS reconciliation_status
FROM running_sales
INNER JOIN source_totals
    ON running_sales.region = source_totals.region
WHERE running_sales.latest_row_number = 1
ORDER BY running_sales.region;

-- Boundary-frame review for moving windows.
SELECT
    campaign_id,
    metric_date,
    spend,
    COUNT(*) OVER (
        PARTITION BY campaign_id
        ORDER BY metric_date, loaded_at
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS frame_row_count,
    CASE
        WHEN COUNT(*) OVER (
            PARTITION BY campaign_id
            ORDER BY metric_date, loaded_at
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ) < 3 THEN 'EARLY_FRAME'
        ELSE 'FULL_THREE_ROW_FRAME'
    END AS frame_review
FROM campaign_metrics_history
ORDER BY campaign_id, metric_date;
