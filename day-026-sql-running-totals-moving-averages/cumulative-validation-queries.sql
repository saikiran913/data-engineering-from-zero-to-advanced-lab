-- Day 026: Cumulative Validation Queries
-- Topic: Validate running totals, nulls, duplicate dates, and reconciliation.
-- Safety note: every query in this file is read-only.

-- 1 and 2: Count partitions and rows per partition.
SELECT region, COUNT(*) AS row_count
FROM daily_sales_metrics
GROUP BY region
ORDER BY region;

-- 3: Find null measures.
SELECT 'daily_sales_metrics' AS dataset, region AS partition_key, sale_date AS ordering_value
FROM daily_sales_metrics
WHERE total_sales IS NULL
UNION ALL
SELECT 'pipeline_load_metrics' AS dataset, pipeline_name AS partition_key, load_date AS ordering_value
FROM pipeline_load_metrics
WHERE load_duration_minutes IS NULL;

-- 4: Find duplicate ordering values.
SELECT region, sale_date, COUNT(*) AS duplicate_rows
FROM daily_sales_metrics
GROUP BY region, sale_date
HAVING COUNT(*) > 1
ORDER BY region, sale_date;

-- 5: Missing date review uses platform-specific date logic in real systems.
SELECT region, MIN(sale_date) AS first_sale_date, MAX(sale_date) AS last_sale_date, COUNT(*) AS available_rows
FROM daily_sales_metrics
GROUP BY region
ORDER BY region;

-- 6: Compare final running total with grouped total.
WITH running_metrics AS (
    SELECT
        region,
        sale_date,
        loaded_at,
        SUM(total_sales) OVER (
            PARTITION BY region
            ORDER BY sale_date, loaded_at
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS running_sales,
        ROW_NUMBER() OVER (
            PARTITION BY region
            ORDER BY sale_date DESC, loaded_at DESC
        ) AS reverse_row_num
    FROM daily_sales_metrics
    WHERE total_sales IS NOT NULL
),
grouped_totals AS (
    SELECT region, SUM(total_sales) AS grouped_sales_total
    FROM daily_sales_metrics
    WHERE total_sales IS NOT NULL
    GROUP BY region
)
SELECT
    r.region,
    r.running_sales AS final_running_sales,
    g.grouped_sales_total,
    r.running_sales - g.grouped_sales_total AS reconciliation_difference
FROM running_metrics AS r
JOIN grouped_totals AS g
    ON r.region = g.region
WHERE r.reverse_row_num = 1;

-- 7 to 11: First and last cumulative values.
WITH running_metrics AS (
    SELECT
        region,
        sale_date,
        loaded_at,
        total_sales,
        SUM(total_sales) OVER (
            PARTITION BY region
            ORDER BY sale_date, loaded_at
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS running_sales
    FROM daily_sales_metrics
    WHERE total_sales IS NOT NULL
)
SELECT *
FROM running_metrics
ORDER BY region, sale_date, loaded_at;

-- 12: Cumulative metric review queue.
SELECT
    'daily_sales_metrics' AS dataset,
    region AS partition_key,
    sale_date AS ordering_value,
    CASE
        WHEN total_sales IS NULL THEN 'NULL_MEASURE'
        WHEN total_sales = 0 THEN 'ZERO_VALUE_REVIEW'
        ELSE 'CHECKED'
    END AS issue_type,
    total_sales AS source_value,
    SUM(total_sales) OVER (
        PARTITION BY region
        ORDER BY sale_date, loaded_at
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_value,
    'Review nulls, zeros, duplicates, and final reconciliation' AS review_message
FROM daily_sales_metrics
ORDER BY region, sale_date, loaded_at;
