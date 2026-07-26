-- Day 027: Debugging Window Queries
-- Purpose: Study common broken or misleading patterns and safer corrected versions.
-- Safety: All executable examples are read-only SELECT queries.
-- Note: Lines labelled "Broken idea" describe teaching material. Use the corrected query below each note.

-- 1. Broken idea: using ROW_NUMBER when all tied top products must remain.
-- Corrected: use RANK so ties are preserved.
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
SELECT category, product_id, total_sales, sales_rank
FROM ranked_products
WHERE sales_rank = 1;

-- 2. Broken idea: using RANK when exactly one row is required.
-- Corrected: use ROW_NUMBER with a documented tie-breaker.
WITH ranked_customers AS (
    SELECT
        country,
        customer_id,
        total_spend,
        ROW_NUMBER() OVER (
            PARTITION BY country
            ORDER BY total_spend DESC, customer_id
        ) AS row_choice
    FROM customer_activity_metrics
    WHERE total_spend IS NOT NULL
)
SELECT country, customer_id, total_spend, row_choice
FROM ranked_customers
WHERE row_choice = 1;

-- 3. Broken idea: missing partition for customer running spend.
SELECT
    customer_id,
    activity_date,
    total_spend,
    SUM(total_spend) OVER (
        PARTITION BY customer_id
        ORDER BY activity_date, loaded_at
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_customer_spend
FROM customer_activity_metrics;

-- 4. Broken idea: ordering previous campaign conversions by campaign_id.
SELECT
    campaign_id,
    metric_date,
    conversions,
    LAG(conversions) OVER (
        PARTITION BY campaign_id
        ORDER BY metric_date, loaded_at
    ) AS previous_conversions
FROM campaign_metrics_history;

-- 5. Broken idea: filtering a window alias in the same SELECT level.
WITH ranked_regions AS (
    SELECT
        sale_date,
        region,
        total_sales,
        ROW_NUMBER() OVER (
            PARTITION BY sale_date
            ORDER BY total_sales DESC, region
        ) AS sales_row_number
    FROM regional_sales_history
    WHERE total_sales IS NOT NULL
)
SELECT sale_date, region, total_sales, sales_row_number
FROM ranked_regions
WHERE sales_row_number = 1;

-- 6. Broken idea: arbitrary tie-breaker with no business explanation.
-- Corrected: include the tie-breaker in comments and selected output.
SELECT
    country,
    customer_id,
    activity_date,
    total_spend,
    ROW_NUMBER() OVER (
        PARTITION BY country
        ORDER BY total_spend DESC, customer_id
    ) AS documented_choice_number
FROM customer_activity_metrics
WHERE total_spend IS NOT NULL;

-- 7. Broken idea: treating first LAG rows as source errors.
WITH previous_rows AS (
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
    CASE
        WHEN previous_conversions IS NULL THEN 'EXPECTED_BOUNDARY'
        ELSE 'HAS_PREVIOUS_ROW'
    END AS boundary_review
FROM previous_rows;

-- 8. Broken idea: hiding missing history with a default value before review.
-- Corrected: keep null previous values visible.
SELECT
    pipeline_name,
    load_date,
    quality_issue_count,
    LAG(quality_issue_count) OVER (
        PARTITION BY pipeline_name
        ORDER BY load_date
    ) AS previous_issue_count
FROM pipeline_quality_history;

-- 9. Broken idea: running total without explicit ROWS frame.
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

-- 10. Broken idea: calling a three-row average a three-day average.
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

-- 11. Broken idea: ranking product rows before answering a total-sales question.
WITH product_totals AS (
    SELECT
        category,
        product_id,
        SUM(total_sales) AS product_total_sales
    FROM product_performance_history
    GROUP BY category, product_id
),
ranked_totals AS (
    SELECT
        category,
        product_id,
        product_total_sales,
        RANK() OVER (
            PARTITION BY category
            ORDER BY product_total_sales DESC
        ) AS product_total_rank
    FROM product_totals
)
SELECT category, product_id, product_total_sales, product_total_rank
FROM ranked_totals;

-- 12. Broken idea: duplicate ordering values ignored.
SELECT
    product_id,
    metric_date,
    COUNT(*) AS rows_for_product_date
FROM product_performance_history
GROUP BY product_id, metric_date
HAVING COUNT(*) > 1;

-- 13. Broken idea: final cumulative values are never reconciled.
WITH running_rejections AS (
    SELECT
        pipeline_name,
        load_date,
        records_rejected,
        SUM(records_rejected) OVER (
            PARTITION BY pipeline_name
            ORDER BY load_date
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS cumulative_records_rejected,
        ROW_NUMBER() OVER (
            PARTITION BY pipeline_name
            ORDER BY load_date DESC
        ) AS latest_row_number
    FROM pipeline_quality_history
),
source_totals AS (
    SELECT pipeline_name, SUM(records_rejected) AS source_records_rejected
    FROM pipeline_quality_history
    GROUP BY pipeline_name
)
SELECT
    running_rejections.pipeline_name,
    running_rejections.cumulative_records_rejected,
    source_totals.source_records_rejected,
    CASE
        WHEN running_rejections.cumulative_records_rejected = source_totals.source_records_rejected THEN 'PASS'
        ELSE 'REVIEW'
    END AS reconciliation_status
FROM running_rejections
INNER JOIN source_totals
    ON running_rejections.pipeline_name = source_totals.pipeline_name
WHERE running_rejections.latest_row_number = 1;

-- 14. Broken idea: mixed calculations are trusted without separate validation.
SELECT
    'campaign_metrics_history' AS dataset_name,
    COUNT(*) AS row_count
FROM campaign_metrics_history

UNION ALL

SELECT
    'pipeline_quality_history' AS dataset_name,
    COUNT(*) AS row_count
FROM pipeline_quality_history;

-- 15. Broken idea: ambiguous joined columns.
-- Corrected: qualify columns when joining validation totals.
WITH campaign_totals AS (
    SELECT campaign_id, SUM(conversions) AS total_conversions
    FROM campaign_metrics_history
    GROUP BY campaign_id
),
campaign_rows AS (
    SELECT campaign_id, COUNT(*) AS metric_row_count
    FROM campaign_metrics_history
    GROUP BY campaign_id
)
SELECT
    campaign_totals.campaign_id,
    campaign_totals.total_conversions,
    campaign_rows.metric_row_count
FROM campaign_totals
INNER JOIN campaign_rows
    ON campaign_totals.campaign_id = campaign_rows.campaign_id;
