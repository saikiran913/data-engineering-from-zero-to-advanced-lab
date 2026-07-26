-- Day 027: Business Question to SQL
-- Purpose: Translate business questions into window-function design choices.
-- Safety: All examples are read-only SELECT queries.

-- 1. Which customer ranks first in each country?
-- Source grain: customer activity row. Output grain: one row per country.
WITH ranked_customers AS (
    SELECT
        country,
        customer_id,
        total_spend,
        ROW_NUMBER() OVER (
            PARTITION BY country
            ORDER BY total_spend DESC, customer_id
        ) AS country_row_number
    FROM customer_activity_metrics
    WHERE total_spend IS NOT NULL
)
SELECT country, customer_id, total_spend
FROM ranked_customers
WHERE country_row_number = 1;

-- 2. Which products share highest sales position in each category?
WITH ranked_products AS (
    SELECT
        category,
        product_id,
        total_sales,
        RANK() OVER (
            PARTITION BY category
            ORDER BY total_sales DESC
        ) AS sales_rank
    FROM product_performance_history
    WHERE total_sales IS NOT NULL
)
SELECT category, product_id, total_sales
FROM ranked_products
WHERE sales_rank = 1;

-- 3. How did campaign conversions change from the previous day?
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
FROM campaign_changes;

-- 4. What is next known customer status?
SELECT
    customer_id,
    activity_date,
    customer_status,
    LEAD(customer_status) OVER (
        PARTITION BY customer_id
        ORDER BY activity_date, loaded_at
    ) AS next_customer_status
FROM customer_activity_metrics;

-- 5. What is cumulative regional sales?
SELECT
    region,
    sale_date,
    total_sales,
    SUM(total_sales) OVER (
        PARTITION BY region
        ORDER BY sale_date, loaded_at
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_sales
FROM regional_sales_history;

-- 6. What is recent three-row campaign spend average?
SELECT
    campaign_id,
    metric_date,
    spend,
    AVG(spend) OVER (
        PARTITION BY campaign_id
        ORDER BY metric_date, loaded_at
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS three_row_moving_spend_avg
FROM campaign_metrics_history;

-- 7. Which pipeline has highest quality-issue count per day?
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
SELECT load_date, pipeline_name, quality_issue_count
FROM ranked_pipelines
WHERE issue_rank = 1;

-- 8. Which dates are missing in regional sales sequence?
-- This beginner review lists previous known dates for manual inspection.
SELECT
    region,
    sale_date,
    LAG(sale_date) OVER (
        PARTITION BY region
        ORDER BY sale_date, loaded_at
    ) AS previous_sale_date
FROM regional_sales_history
ORDER BY region, sale_date;

-- 9. Which final cumulative totals fail reconciliation?
WITH running_sales AS (
    SELECT
        region,
        sale_date,
        SUM(total_sales) OVER (
            PARTITION BY region
            ORDER BY sale_date, loaded_at
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS running_sales,
        ROW_NUMBER() OVER (
            PARTITION BY region
            ORDER BY sale_date DESC, loaded_at DESC
        ) AS latest_row_number
    FROM regional_sales_history
),
source_totals AS (
    SELECT region, SUM(total_sales) AS source_total_sales
    FROM regional_sales_history
    GROUP BY region
)
SELECT
    running_sales.region,
    running_sales.running_sales,
    source_totals.source_total_sales,
    CASE
        WHEN running_sales.running_sales = source_totals.source_total_sales THEN 'PASS'
        ELSE 'REVIEW'
    END AS reconciliation_status
FROM running_sales
INNER JOIN source_totals
    ON running_sales.region = source_totals.region
WHERE running_sales.latest_row_number = 1;

-- 10. Which question needs only GROUP BY, not a window function?
SELECT
    pipeline_name,
    SUM(records_rejected) AS total_records_rejected
FROM pipeline_quality_history
GROUP BY pipeline_name
ORDER BY pipeline_name;
