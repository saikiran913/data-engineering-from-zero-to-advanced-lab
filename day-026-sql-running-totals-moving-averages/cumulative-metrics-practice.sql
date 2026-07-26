-- Day 026: Cumulative Metrics Practice
-- Topic: Running sums, counts, averages, minimums, and maximums.
-- Safety note: every query in this file is read-only.

-- Cumulative sum: sales by region.
SELECT sale_date, region, total_sales,
    SUM(total_sales) OVER (
        PARTITION BY region
        ORDER BY sale_date, loaded_at
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_sales
FROM daily_sales_metrics
WHERE total_sales IS NOT NULL
ORDER BY region, sale_date, loaded_at;

-- Cumulative sum: loaded records by pipeline.
SELECT pipeline_name, load_date, records_loaded,
    SUM(records_loaded) OVER (
        PARTITION BY pipeline_name
        ORDER BY load_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_records_loaded
FROM pipeline_load_metrics
ORDER BY pipeline_name, load_date;

-- Cumulative count: days per region.
SELECT sale_date, region,
    COUNT(*) OVER (
        PARTITION BY region
        ORDER BY sale_date, loaded_at
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_day_row_count
FROM daily_sales_metrics
ORDER BY region, sale_date, loaded_at;

-- Cumulative average: average sales so far.
SELECT sale_date, region, total_sales,
    AVG(total_sales) OVER (
        PARTITION BY region
        ORDER BY sale_date, loaded_at
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_average_sales
FROM daily_sales_metrics
ORDER BY region, sale_date, loaded_at;

-- Cumulative maximum and minimum.
SELECT sale_date, region, total_sales,
    MAX(total_sales) OVER (
        PARTITION BY region
        ORDER BY sale_date, loaded_at
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS highest_sales_so_far,
    MIN(total_sales) OVER (
        PARTITION BY region
        ORDER BY sale_date, loaded_at
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS lowest_sales_so_far
FROM daily_sales_metrics
ORDER BY region, sale_date, loaded_at;

-- Cumulative rejected records.
SELECT pipeline_name, load_date, records_rejected,
    SUM(records_rejected) OVER (
        PARTITION BY pipeline_name
        ORDER BY load_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_rejected_records
FROM pipeline_load_metrics
ORDER BY pipeline_name, load_date;

-- Review flags.
WITH cumulative_sales AS (
    SELECT
        sale_date,
        region,
        total_sales,
        COUNT(*) OVER (
            PARTITION BY region
            ORDER BY sale_date, loaded_at
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS cumulative_row_count,
        SUM(total_sales) OVER (
            PARTITION BY region
            ORDER BY sale_date, loaded_at
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS cumulative_sales
    FROM daily_sales_metrics
)
SELECT *,
    CASE
        WHEN total_sales IS NULL THEN 'NULL_MEASURE_REVIEW'
        WHEN cumulative_row_count = 1 THEN 'FIRST_ROW'
        ELSE 'CUMULATIVE_OK'
    END AS review_flag
FROM cumulative_sales
ORDER BY region, sale_date;
