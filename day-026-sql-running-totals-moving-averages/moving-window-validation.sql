-- Day 026: Moving Window Validation
-- Topic: Validate moving sums and averages.
-- Safety note: every query in this file is read-only.

-- 1 and 2: Count rows available in each frame and identify early boundaries.
WITH moving_sales AS (
    SELECT
        sale_date,
        region,
        total_sales,
        COUNT(*) OVER (
            PARTITION BY region
            ORDER BY sale_date, loaded_at
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ) AS frame_row_count,
        AVG(total_sales) OVER (
            PARTITION BY region
            ORDER BY sale_date, loaded_at
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ) AS moving_average
    FROM daily_sales_metrics
)
SELECT *,
    CASE
        WHEN frame_row_count < 3 THEN 'EARLY_BOUNDARY_ROW'
        ELSE 'FULL_THREE_ROW_FRAME'
    END AS boundary_flag
FROM moving_sales
ORDER BY region, sale_date;

-- 3 to 5: Null measures, duplicate dates, and missing-date review.
SELECT 'NULL_MEASURE' AS issue_type, region AS partition_key, sale_date AS current_ordering_value
FROM daily_sales_metrics
WHERE total_sales IS NULL
UNION ALL
SELECT 'DUPLICATE_DATE' AS issue_type, region AS partition_key, sale_date AS current_ordering_value
FROM daily_sales_metrics
GROUP BY region, sale_date
HAVING COUNT(*) > 1;

-- 6 and 7: Manual three-row comparison for a small sample.
SELECT sale_date, region, total_sales
FROM daily_sales_metrics
WHERE region = 'North'
ORDER BY sale_date, loaded_at;

-- 8 to 11: Moving-window review queue.
WITH moving_sales AS (
    SELECT
        sale_date,
        region,
        total_sales,
        COUNT(*) OVER (
            PARTITION BY region
            ORDER BY sale_date, loaded_at
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ) AS frame_row_count,
        AVG(total_sales) OVER (
            PARTITION BY region
            ORDER BY sale_date, loaded_at
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ) AS moving_metric
    FROM daily_sales_metrics
)
SELECT
    'daily_sales_metrics' AS dataset,
    region AS partition_key,
    sale_date AS current_ordering_value,
    frame_row_count,
    moving_metric,
    CASE
        WHEN total_sales IS NULL THEN 'NULL_MEASURE'
        WHEN frame_row_count < 3 THEN 'EARLY_FRAME'
        ELSE 'FRAME_READY'
    END AS issue_type,
    'Three rows may not equal three calendar days; review missing and duplicate dates' AS review_message
FROM moving_sales
ORDER BY region, sale_date;
