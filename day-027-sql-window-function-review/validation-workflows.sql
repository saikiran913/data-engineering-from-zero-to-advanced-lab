-- Day 027: Validation Workflows
-- Purpose: Source counts, grain checks, duplicate ordering checks, boundary checks, reconciliation, and review queues.
-- Safety: All examples are read-only SELECT queries.

-- 1. Source grain check: customer rows per customer-date.
SELECT customer_id, activity_date, COUNT(*) AS rows_for_customer_date
FROM customer_activity_metrics
GROUP BY customer_id, activity_date
HAVING COUNT(*) > 1
ORDER BY customer_id, activity_date;

-- 2. Partition-count check: countries in customer data.
SELECT country, COUNT(*) AS rows_in_country
FROM customer_activity_metrics
GROUP BY country
ORDER BY country;

-- 3. Null ordering values: campaign metric dates.
SELECT campaign_id, metric_date, loaded_at
FROM campaign_metrics_history
WHERE metric_date IS NULL;

-- 4. Duplicate ordering values: product date per product.
SELECT product_id, metric_date, COUNT(*) AS ordering_count
FROM product_performance_history
GROUP BY product_id, metric_date
HAVING COUNT(*) > 1
ORDER BY product_id, metric_date;

-- 5. Tie count: product sales ties by category and sales value.
SELECT category, total_sales, COUNT(*) AS tied_row_count
FROM product_performance_history
WHERE total_sales IS NOT NULL
GROUP BY category, total_sales
HAVING COUNT(*) > 1
ORDER BY category, total_sales DESC;

-- 6. One-row-per-group policy validation for country winners.
WITH winners AS (
    SELECT
        country,
        customer_id,
        ROW_NUMBER() OVER (
            PARTITION BY country
            ORDER BY total_spend DESC, customer_id
        ) AS row_number_choice
    FROM customer_activity_metrics
    WHERE total_spend IS NOT NULL
)
SELECT country, COUNT(*) AS selected_winner_count
FROM winners
WHERE row_number_choice = 1
GROUP BY country
ORDER BY country;

-- 7. All-ties policy validation for product winners.
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
SELECT category, COUNT(*) AS tied_top_rows
FROM ranked_products
WHERE sales_rank = 1
GROUP BY category
ORDER BY category;

-- 8. First-row count for LAG boundary validation.
WITH first_campaign_rows AS (
    SELECT
        campaign_id,
        metric_date,
        LAG(conversions) OVER (
            PARTITION BY campaign_id
            ORDER BY metric_date, loaded_at
        ) AS previous_conversions
    FROM campaign_metrics_history
)
SELECT COUNT(*) AS first_row_boundary_count
FROM first_campaign_rows
WHERE previous_conversions IS NULL;

-- 9. Last-row count for LEAD boundary validation.
WITH last_customer_rows AS (
    SELECT
        customer_id,
        activity_date,
        LEAD(customer_status) OVER (
            PARTITION BY customer_id
            ORDER BY activity_date, loaded_at
        ) AS next_customer_status
    FROM customer_activity_metrics
)
SELECT COUNT(*) AS last_row_boundary_count
FROM last_customer_rows
WHERE next_customer_status IS NULL;

-- 10. Missing-date count using a small expected calendar.
-- This keeps the example beginner-friendly and avoids platform-specific date generation.
WITH expected_sales_dates AS (
    SELECT 'North' AS region, '2026-01-01' AS expected_sale_date
    UNION ALL SELECT 'North', '2026-01-02'
    UNION ALL SELECT 'North', '2026-01-03'
    UNION ALL SELECT 'North', '2026-01-04'
    UNION ALL SELECT 'North', '2026-01-05'
    UNION ALL SELECT 'South', '2026-01-01'
    UNION ALL SELECT 'South', '2026-01-02'
    UNION ALL SELECT 'South', '2026-01-03'
    UNION ALL SELECT 'South', '2026-01-04'
    UNION ALL SELECT 'South', '2026-01-05'
    UNION ALL SELECT 'East', '2026-01-01'
    UNION ALL SELECT 'East', '2026-01-02'
    UNION ALL SELECT 'East', '2026-01-03'
    UNION ALL SELECT 'East', '2026-01-04'
    UNION ALL SELECT 'East', '2026-01-05'
    UNION ALL SELECT 'West', '2026-01-01'
    UNION ALL SELECT 'West', '2026-01-02'
    UNION ALL SELECT 'West', '2026-01-03'
    UNION ALL SELECT 'West', '2026-01-04'
    UNION ALL SELECT 'West', '2026-01-05'
)
SELECT
    expected_sales_dates.region,
    COUNT(*) AS missing_date_count
FROM expected_sales_dates
LEFT JOIN regional_sales_history
    ON expected_sales_dates.region = regional_sales_history.region
   AND expected_sales_dates.expected_sale_date = regional_sales_history.sale_date
WHERE regional_sales_history.sale_date IS NULL
GROUP BY expected_sales_dates.region
ORDER BY expected_sales_dates.region;

-- 11. Sequence-gap style review for campaign rows.
SELECT
    campaign_id,
    metric_date,
    LAG(metric_date) OVER (
        PARTITION BY campaign_id
        ORDER BY metric_date, loaded_at
    ) AS previous_metric_date
FROM campaign_metrics_history
ORDER BY campaign_id, metric_date;

-- 12. Final cumulative reconciliation for pipeline rejected records.
WITH running_rejections AS (
    SELECT
        pipeline_name,
        load_date,
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
    END AS status
FROM running_rejections
INNER JOIN source_totals
    ON running_rejections.pipeline_name = source_totals.pipeline_name
WHERE running_rejections.latest_row_number = 1;

-- 13. Moving-frame row count validation.
SELECT
    campaign_id,
    metric_date,
    COUNT(*) OVER (
        PARTITION BY campaign_id
        ORDER BY metric_date, loaded_at
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS frame_row_count
FROM campaign_metrics_history
ORDER BY campaign_id, metric_date;

-- 14. Manual sample check for one campaign.
SELECT
    campaign_id,
    metric_date,
    conversions,
    spend
FROM campaign_metrics_history
WHERE campaign_id = 'CAM001'
ORDER BY metric_date, loaded_at;

-- 15. Combined review queue.
WITH campaign_review AS (
    SELECT
        'campaign_metrics_history' AS dataset_name,
        campaign_id AS entity_key,
        'NULL_SPEND' AS issue_type,
        spend AS issue_value,
        metric_date AS ordering_value,
        'REVIEW' AS severity,
        'Spend is null and should be reviewed before spend-based windows are trusted.' AS review_message
    FROM campaign_metrics_history
    WHERE spend IS NULL
),
regional_review AS (
    SELECT
        'regional_sales_history' AS dataset_name,
        region AS entity_key,
        'NULL_TOTAL_SALES' AS issue_type,
        total_sales AS issue_value,
        sale_date AS ordering_value,
        'HIGH_REVIEW' AS severity,
        'Sales is null and can affect running or moving sales metrics.' AS review_message
    FROM regional_sales_history
    WHERE total_sales IS NULL
),
pipeline_review AS (
    SELECT
        'pipeline_quality_history' AS dataset_name,
        pipeline_name AS entity_key,
        'NULL_DURATION' AS issue_type,
        load_duration_minutes AS issue_value,
        load_date AS ordering_value,
        'INFO' AS severity,
        'Duration is null; duration moving averages may have fewer measured values.' AS review_message
    FROM pipeline_quality_history
    WHERE load_duration_minutes IS NULL
)
SELECT dataset_name, entity_key, issue_type, issue_value, ordering_value, severity, review_message
FROM campaign_review

UNION ALL

SELECT dataset_name, entity_key, issue_type, issue_value, ordering_value, severity, review_message
FROM regional_review

UNION ALL

SELECT dataset_name, entity_key, issue_type, issue_value, ordering_value, severity, review_message
FROM pipeline_review
ORDER BY severity, dataset_name, entity_key;
