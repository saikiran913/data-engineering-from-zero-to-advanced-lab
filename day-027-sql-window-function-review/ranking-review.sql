-- Day 027: Ranking Review
-- Purpose: Review ROW_NUMBER, RANK, DENSE_RANK, top-per-group logic, ties, and validation.
-- Safety: All examples are read-only SELECT queries.

-- Exactly one top customer per country.
-- Source grain: customer activity row. Output grain: one selected row per country.
-- Tie policy: ROW_NUMBER uses customer_id and activity_date as documented tie-breakers.
WITH ranked_customers AS (
    SELECT
        country,
        customer_id,
        activity_date,
        total_spend,
        ROW_NUMBER() OVER (
            PARTITION BY country
            ORDER BY total_spend DESC, customer_id, activity_date
        ) AS spend_row_number
    FROM customer_activity_metrics
    WHERE total_spend IS NOT NULL
)
SELECT
    country,
    customer_id,
    activity_date,
    total_spend,
    spend_row_number
FROM ranked_customers
WHERE spend_row_number = 1
ORDER BY country;

-- All tied top products per category.
-- Tie policy: RANK keeps all tied top rows.
WITH ranked_products AS (
    SELECT
        category,
        product_id,
        metric_date,
        total_sales,
        RANK() OVER (
            PARTITION BY category
            ORDER BY total_sales DESC
        ) AS sales_rank
    FROM product_performance_history
    WHERE total_sales IS NOT NULL
)
SELECT
    category,
    product_id,
    metric_date,
    total_sales,
    sales_rank
FROM ranked_products
WHERE sales_rank = 1
ORDER BY category, product_id, metric_date;

-- Dense performance levels for pipelines by issue count per date.
WITH pipeline_levels AS (
    SELECT
        load_date,
        pipeline_name,
        quality_issue_count,
        DENSE_RANK() OVER (
            PARTITION BY load_date
            ORDER BY quality_issue_count DESC
        ) AS issue_level
    FROM pipeline_quality_history
)
SELECT
    load_date,
    pipeline_name,
    quality_issue_count,
    issue_level
FROM pipeline_levels
ORDER BY load_date, issue_level, pipeline_name;

-- Bottom region by sales period.
WITH ranked_regions AS (
    SELECT
        sale_date,
        region,
        total_sales,
        ROW_NUMBER() OVER (
            PARTITION BY sale_date
            ORDER BY total_sales ASC, region
        ) AS low_sales_row_number
    FROM regional_sales_history
    WHERE total_sales IS NOT NULL
)
SELECT
    sale_date,
    region,
    total_sales,
    low_sales_row_number
FROM ranked_regions
WHERE low_sales_row_number = 1
ORDER BY sale_date;

-- Rank aggregated campaign totals.
-- Source grain: campaign per day. Output grain after aggregation: campaign total.
WITH campaign_totals AS (
    SELECT
        channel,
        country,
        campaign_id,
        SUM(conversions) AS total_conversions
    FROM campaign_metrics_history
    GROUP BY channel, country, campaign_id
),
ranked_campaigns AS (
    SELECT
        channel,
        country,
        campaign_id,
        total_conversions,
        RANK() OVER (
            PARTITION BY channel, country
            ORDER BY total_conversions DESC
        ) AS conversion_rank
    FROM campaign_totals
)
SELECT
    channel,
    country,
    campaign_id,
    total_conversions,
    conversion_rank
FROM ranked_campaigns
ORDER BY channel, country, conversion_rank, campaign_id;

-- Top three product ranks by category, keeping ties.
WITH ranked_products AS (
    SELECT
        category,
        product_id,
        metric_date,
        total_sales,
        RANK() OVER (
            PARTITION BY category
            ORDER BY total_sales DESC
        ) AS sales_rank
    FROM product_performance_history
    WHERE total_sales IS NOT NULL
)
SELECT
    category,
    product_id,
    metric_date,
    total_sales,
    sales_rank
FROM ranked_products
WHERE sales_rank <= 3
ORDER BY category, sales_rank, product_id;

-- Ranking validation output.
WITH country_count AS (
    SELECT
        COUNT(*) AS partition_count
    FROM (
        SELECT
            country
        FROM customer_activity_metrics
        GROUP BY country
    ) country_groups
),
selected_customers AS (
    SELECT
        country,
        customer_id,
        ROW_NUMBER() OVER (
            PARTITION BY country
            ORDER BY total_spend DESC, customer_id
        ) AS spend_row_number
    FROM customer_activity_metrics
    WHERE total_spend IS NOT NULL
),
tied_products AS (
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
),
null_measures AS (
    SELECT
        COUNT(*) AS null_measure_count
    FROM product_performance_history
    WHERE total_sales IS NULL
)
SELECT
    'ranking_review' AS check_name,
    (SELECT partition_count FROM country_count) AS partition_count,
    COUNT(*) AS selected_row_count,
    (SELECT COUNT(*) FROM tied_products WHERE sales_rank = 1) AS tied_top_count,
    (SELECT null_measure_count FROM null_measures) AS null_measure_count,
    'Review row counts, tied top rows, and null measures before publishing ranks.' AS review_message
FROM selected_customers
WHERE spend_row_number = 1;
