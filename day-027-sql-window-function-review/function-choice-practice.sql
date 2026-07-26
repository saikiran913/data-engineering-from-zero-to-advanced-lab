-- Day 027: Function Choice Practice
-- Purpose: Choose the correct review pattern before writing a larger window query.
-- Safety: All examples are read-only SELECT queries.

-- Quick source preview: customer activity grain is customer per activity date and load.
SELECT
    customer_id,
    country,
    activity_date,
    total_spend,
    customer_status,
    loaded_at
FROM customer_activity_metrics
ORDER BY country, customer_id, activity_date, loaded_at
LIMIT 20;

-- Problem 1: Which customer activity row ranks first in each country?
-- Function family: ranking. Tie policy: exactly one row, so use ROW_NUMBER.
WITH ranked_customers AS (
    SELECT
        country,
        customer_id,
        activity_date,
        total_spend,
        ROW_NUMBER() OVER (
            PARTITION BY country
            ORDER BY total_spend DESC, customer_id, activity_date
        ) AS country_row_number
    FROM customer_activity_metrics
    WHERE total_spend IS NOT NULL
)
SELECT
    country,
    customer_id,
    activity_date,
    total_spend,
    country_row_number
FROM ranked_customers
WHERE country_row_number = 1
ORDER BY country;

-- Validation for Problem 1: count countries before expecting one selected row per country.
SELECT
    country,
    COUNT(*) AS source_rows
FROM customer_activity_metrics
GROUP BY country
ORDER BY country;

-- Problem 2: Which products share the highest sales position in each category?
-- Function family: ranking. Tie policy: keep ties, so use RANK.
WITH ranked_products AS (
    SELECT
        category,
        product_id,
        metric_date,
        total_sales,
        RANK() OVER (
            PARTITION BY category
            ORDER BY total_sales DESC
        ) AS category_sales_rank
    FROM product_performance_history
    WHERE total_sales IS NOT NULL
)
SELECT
    category,
    product_id,
    metric_date,
    total_sales,
    category_sales_rank
FROM ranked_products
WHERE category_sales_rank = 1
ORDER BY category, product_id;

-- Problem 3: How did campaign conversions change from the previous metric row?
-- Function family: row comparison. Boundary policy: first row has no previous value.
WITH campaign_changes AS (
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
    conversions - previous_conversions AS conversion_change
FROM campaign_changes
ORDER BY campaign_id, metric_date;

-- Problem 4: What is the next known customer status?
-- Function family: row comparison. Boundary policy: last row has no next value.
SELECT
    customer_id,
    activity_date,
    customer_status,
    LEAD(customer_status) OVER (
        PARTITION BY customer_id
        ORDER BY activity_date, loaded_at
    ) AS next_customer_status
FROM customer_activity_metrics
ORDER BY customer_id, activity_date, loaded_at;

-- Problem 5: What is cumulative regional sales?
-- Function family: cumulative window. Frame: all previous rows through current row.
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

-- Problem 6: What is the recent three-row campaign spend average?
-- Function family: moving average. Frame: current row and two previous rows.
SELECT
    campaign_id,
    metric_date,
    spend,
    AVG(spend) OVER (
        PARTITION BY campaign_id
        ORDER BY metric_date, loaded_at
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS three_row_spend_avg
FROM campaign_metrics_history
ORDER BY campaign_id, metric_date;

-- Problem 7: Which pipeline has the highest issue count for each load date?
-- Function family: ranking. Tie policy: keep tied top pipelines.
WITH ranked_pipelines AS (
    SELECT
        load_date,
        pipeline_name,
        quality_issue_count,
        RANK() OVER (
            PARTITION BY load_date
            ORDER BY quality_issue_count DESC
        ) AS issue_rank
    FROM pipeline_quality_history
)
SELECT
    load_date,
    pipeline_name,
    quality_issue_count,
    issue_rank
FROM ranked_pipelines
WHERE issue_rank = 1
ORDER BY load_date, pipeline_name;

-- Problem 8: What is the total rejected-record value per pipeline?
-- Function family: GROUP BY. No window function is needed for one summary row per group.
SELECT
    pipeline_name,
    SUM(records_rejected) AS total_records_rejected
FROM pipeline_quality_history
GROUP BY pipeline_name
ORDER BY pipeline_name;

-- Problem 9: What is cumulative rejected records per pipeline?
-- Function family: cumulative window.
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

-- Problem 10: Which rows need review because important metrics are null?
-- Function family: simple filter. No window function is needed.
SELECT
    'campaign_metrics_history' AS dataset_name,
    campaign_id AS entity_key,
    metric_date AS metric_date,
    'NULL_SPEND' AS issue_type
FROM campaign_metrics_history
WHERE spend IS NULL

UNION ALL

SELECT
    'regional_sales_history' AS dataset_name,
    region AS entity_key,
    sale_date AS metric_date,
    'NULL_TOTAL_SALES' AS issue_type
FROM regional_sales_history
WHERE total_sales IS NULL;

-- Problem 11: Which product rows have previous stock available?
-- Function family: row comparison with boundary review.
WITH product_stock AS (
    SELECT
        product_id,
        metric_date,
        stock_on_hand,
        LAG(stock_on_hand) OVER (
            PARTITION BY product_id
            ORDER BY metric_date, loaded_at
        ) AS previous_stock_on_hand
    FROM product_performance_history
)
SELECT
    product_id,
    metric_date,
    stock_on_hand,
    previous_stock_on_hand
FROM product_stock
WHERE previous_stock_on_hand IS NOT NULL
ORDER BY product_id, metric_date;

-- Problem 12: Which campaign rows have enough history for a full three-row frame?
-- Function family: moving frame plus frame row count.
WITH framed_campaigns AS (
    SELECT
        campaign_id,
        metric_date,
        spend,
        COUNT(*) OVER (
            PARTITION BY campaign_id
            ORDER BY metric_date, loaded_at
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ) AS frame_row_count
    FROM campaign_metrics_history
)
SELECT
    campaign_id,
    metric_date,
    spend,
    frame_row_count
FROM framed_campaigns
WHERE frame_row_count = 3
ORDER BY campaign_id, metric_date;
