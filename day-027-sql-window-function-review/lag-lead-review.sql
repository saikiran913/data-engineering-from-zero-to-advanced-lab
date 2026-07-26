-- Day 027: LAG and LEAD Review
-- Purpose: Review previous-row and next-row comparisons, boundaries, gaps, and validation.
-- Safety: All examples are read-only SELECT queries.

-- Previous customer status.
-- Boundary policy: the first row per customer has no previous status.
SELECT
    customer_id,
    activity_date,
    loaded_at,
    customer_status,
    LAG(customer_status) OVER (
        PARTITION BY customer_id
        ORDER BY activity_date, loaded_at
    ) AS previous_customer_status
FROM customer_activity_metrics
ORDER BY customer_id, activity_date, loaded_at;

-- Previous product stock.
SELECT
    product_id,
    metric_date,
    stock_on_hand,
    LAG(stock_on_hand) OVER (
        PARTITION BY product_id
        ORDER BY metric_date, loaded_at
    ) AS previous_stock_on_hand
FROM product_performance_history
ORDER BY product_id, metric_date, loaded_at;

-- Previous campaign conversions and change amount.
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
    conversions - previous_conversions AS conversion_change,
    CASE
        WHEN previous_conversions IS NULL THEN 'FIRST_ROW'
        WHEN conversions > previous_conversions THEN 'INCREASE'
        WHEN conversions < previous_conversions THEN 'DECREASE'
        ELSE 'NO_CHANGE'
    END AS conversion_change_flag
FROM campaign_changes
ORDER BY campaign_id, metric_date;

-- Next regional sales date.
SELECT
    region,
    sale_date,
    total_sales,
    LEAD(sale_date) OVER (
        PARTITION BY region
        ORDER BY sale_date, loaded_at
    ) AS next_sale_date
FROM regional_sales_history
ORDER BY region, sale_date, loaded_at;

-- First and last pipeline load flags.
WITH pipeline_sequence AS (
    SELECT
        pipeline_name,
        load_date,
        quality_issue_count,
        ROW_NUMBER() OVER (
            PARTITION BY pipeline_name
            ORDER BY load_date
        ) AS first_row_number,
        ROW_NUMBER() OVER (
            PARTITION BY pipeline_name
            ORDER BY load_date DESC
        ) AS last_row_number
    FROM pipeline_quality_history
)
SELECT
    pipeline_name,
    load_date,
    quality_issue_count,
    CASE WHEN first_row_number = 1 THEN 'FIRST_LOAD' ELSE 'NOT_FIRST_LOAD' END AS first_load_flag,
    CASE WHEN last_row_number = 1 THEN 'LAST_LOAD' ELSE 'NOT_LAST_LOAD' END AS last_load_flag
FROM pipeline_sequence
ORDER BY pipeline_name, load_date;

-- Status change review rows.
WITH status_history AS (
    SELECT
        customer_id,
        activity_date,
        customer_status,
        LAG(customer_status) OVER (
            PARTITION BY customer_id
            ORDER BY activity_date, loaded_at
        ) AS previous_customer_status
    FROM customer_activity_metrics
)
SELECT
    customer_id,
    activity_date,
    customer_status,
    previous_customer_status,
    'STATUS_CHANGED' AS review_reason
FROM status_history
WHERE previous_customer_status IS NOT NULL
  AND customer_status <> previous_customer_status
ORDER BY customer_id, activity_date;

-- Date-gap style review without platform-specific date arithmetic.
-- This identifies the previous known date so learners can inspect gaps manually.
SELECT
    region,
    sale_date,
    LAG(sale_date) OVER (
        PARTITION BY region
        ORDER BY sale_date, loaded_at
    ) AS previous_sale_date,
    CASE
        WHEN LAG(sale_date) OVER (
            PARTITION BY region
            ORDER BY sale_date, loaded_at
        ) IS NULL THEN 'FIRST_ROW'
        ELSE 'CHECK_DATE_SEQUENCE'
    END AS sequence_review_status
FROM regional_sales_history
ORDER BY region, sale_date, loaded_at;

-- Late-arriving style review: business date and load timestamp can tell different stories.
SELECT
    customer_id,
    activity_date,
    loaded_at,
    LAG(loaded_at) OVER (
        PARTITION BY customer_id
        ORDER BY activity_date, loaded_at
    ) AS previous_loaded_at
FROM customer_activity_metrics
ORDER BY customer_id, activity_date, loaded_at;

-- Validation summary for boundary and ordering review.
WITH previous_campaigns AS (
    SELECT
        campaign_id,
        metric_date,
        LAG(conversions) OVER (
            PARTITION BY campaign_id
            ORDER BY metric_date, loaded_at
        ) AS previous_conversions
    FROM campaign_metrics_history
),
first_row_expected AS (
    SELECT
        campaign_id,
        COUNT(*) AS source_rows
    FROM campaign_metrics_history
    GROUP BY campaign_id
),
duplicate_ordering AS (
    SELECT
        campaign_id,
        metric_date,
        COUNT(*) AS ordering_count
    FROM campaign_metrics_history
    GROUP BY campaign_id, metric_date
    HAVING COUNT(*) > 1
),
expected_sales_dates AS (
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
),
missing_date_review AS (
    SELECT
        expected_sales_dates.region,
        expected_sales_dates.expected_sale_date
    FROM expected_sales_dates
    LEFT JOIN regional_sales_history
        ON expected_sales_dates.region = regional_sales_history.region
       AND expected_sales_dates.expected_sale_date = regional_sales_history.sale_date
    WHERE regional_sales_history.sale_date IS NULL
)
SELECT
    'lag_lead_boundary_review' AS check_name,
    COUNT(*) AS actual_boundary_count,
    (SELECT COUNT(*) FROM first_row_expected) AS expected_boundary_count,
    (SELECT COUNT(*) FROM duplicate_ordering) AS duplicate_ordering_count,
    (SELECT COUNT(*) FROM missing_date_review) AS missing_date_count,
    CASE
        WHEN COUNT(*) = (SELECT COUNT(*) FROM first_row_expected) THEN 'PASS'
        ELSE 'REVIEW'
    END AS review_status
FROM previous_campaigns
WHERE previous_conversions IS NULL;
