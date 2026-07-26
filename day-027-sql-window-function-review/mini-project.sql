-- Day 027 Mini Project: Build a Window-Function Monitoring Report
-- Purpose: Create read-only campaign, pipeline, and regional review outputs.
-- Safety: All examples are read-only SELECT queries.

-- Report 1: Campaign ranking report.
-- Source grain: campaign per metric date. Output grain: campaign metric row.
-- Tie policy: RANK preserves tied campaign conversions within channel and country.
WITH campaign_ranked AS (
    SELECT
        campaign_id,
        channel,
        country,
        metric_date,
        conversions,
        spend,
        RANK() OVER (
            PARTITION BY channel, country
            ORDER BY conversions DESC
        ) AS conversion_rank
    FROM campaign_metrics_history
)
SELECT
    campaign_id,
    channel,
    country,
    metric_date,
    conversions,
    spend,
    conversion_rank,
    CASE
        WHEN spend IS NULL THEN 'REVIEW_NULL_SPEND'
        WHEN conversion_rank = 1 THEN 'TOP_CONVERSION_ROW'
        ELSE 'OK'
    END AS review_flag
FROM campaign_ranked
ORDER BY channel, country, conversion_rank, campaign_id;

-- Report 2: Campaign change report.
WITH campaign_change AS (
    SELECT
        campaign_id,
        metric_date,
        conversions,
        LAG(conversions) OVER (
            PARTITION BY campaign_id
            ORDER BY metric_date, loaded_at
        ) AS previous_conversions
    FROM campaign_metrics_history
)
SELECT
    campaign_id,
    metric_date,
    conversions,
    previous_conversions,
    conversions - previous_conversions AS conversion_change,
    CASE
        WHEN previous_conversions IS NULL THEN 'FIRST_ROW'
        WHEN conversions - previous_conversions > 5 THEN 'REVIEW_LARGE_INCREASE'
        WHEN previous_conversions - conversions > 5 THEN 'REVIEW_LARGE_DECREASE'
        ELSE 'OK'
    END AS review_flag
FROM campaign_change
ORDER BY campaign_id, metric_date;

-- Report 3: Campaign cumulative report.
SELECT
    campaign_id,
    metric_date,
    conversions,
    spend,
    SUM(conversions) OVER (
        PARTITION BY campaign_id
        ORDER BY metric_date, loaded_at
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_conversions,
    SUM(spend) OVER (
        PARTITION BY campaign_id
        ORDER BY metric_date, loaded_at
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_spend,
    AVG(spend) OVER (
        PARTITION BY campaign_id
        ORDER BY metric_date, loaded_at
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS three_row_moving_spend_avg
FROM campaign_metrics_history
ORDER BY campaign_id, metric_date;

-- Report 4: Pipeline quality report.
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
        ) AS daily_issue_rank,
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
    daily_issue_rank,
    previous_issue_count,
    cumulative_records_rejected,
    three_row_moving_duration_avg,
    CASE
        WHEN load_duration_minutes IS NULL THEN 'REVIEW_NULL_DURATION'
        WHEN previous_issue_count IS NULL THEN 'FIRST_ROW'
        WHEN quality_issue_count > previous_issue_count THEN 'REVIEW_ISSUES_INCREASED'
        ELSE 'OK'
    END AS review_flag
FROM pipeline_windows
ORDER BY pipeline_name, load_date;

-- Report 5: Regional sales report.
WITH regional_windows AS (
    SELECT
        region,
        sale_date,
        total_sales,
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
        WHEN previous_sale_date IS NULL THEN 'FIRST_ROW'
        ELSE 'CHECK_DATE_SEQUENCE'
    END AS review_flag
FROM regional_windows
ORDER BY region, sale_date;

-- Report 6: Combined exception queue.
WITH campaign_exceptions AS (
    SELECT
        'campaign' AS source_area,
        campaign_id AS entity_key,
        metric_date AS metric_date,
        'NULL_SPEND' AS issue_type,
        spend AS current_value,
        conversions AS comparison_value,
        'Spend is null; spend windows need review.' AS review_message
    FROM campaign_metrics_history
    WHERE spend IS NULL
),
pipeline_exceptions AS (
    SELECT
        'pipeline' AS source_area,
        pipeline_name AS entity_key,
        load_date AS metric_date,
        'NULL_DURATION' AS issue_type,
        load_duration_minutes AS current_value,
        quality_issue_count AS comparison_value,
        'Duration is null; duration averages need review.' AS review_message
    FROM pipeline_quality_history
    WHERE load_duration_minutes IS NULL
),
regional_exceptions AS (
    SELECT
        'regional_sales' AS source_area,
        region AS entity_key,
        sale_date AS metric_date,
        'NULL_SALES' AS issue_type,
        total_sales AS current_value,
        refund_amount AS comparison_value,
        'Sales is null; running sales needs review.' AS review_message
    FROM regional_sales_history
    WHERE total_sales IS NULL
)
SELECT source_area, entity_key, metric_date, issue_type, current_value, comparison_value, review_message
FROM campaign_exceptions

UNION ALL

SELECT source_area, entity_key, metric_date, issue_type, current_value, comparison_value, review_message
FROM pipeline_exceptions

UNION ALL

SELECT source_area, entity_key, metric_date, issue_type, current_value, comparison_value, review_message
FROM regional_exceptions;

-- Report 7: Validation summary.
SELECT
    'campaign_null_spend' AS check_name,
    COUNT(*) AS issue_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'REVIEW' END AS status,
    'Null spend can affect spend-based window metrics.' AS explanation
FROM campaign_metrics_history
WHERE spend IS NULL

UNION ALL

SELECT
    'pipeline_null_duration' AS check_name,
    COUNT(*) AS issue_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'REVIEW' END AS status,
    'Null duration can affect moving duration averages.' AS explanation
FROM pipeline_quality_history
WHERE load_duration_minutes IS NULL

UNION ALL

SELECT
    'regional_null_sales' AS check_name,
    COUNT(*) AS issue_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'REVIEW' END AS status,
    'Null sales can affect running and moving sales metrics.' AS explanation
FROM regional_sales_history
WHERE total_sales IS NULL;
