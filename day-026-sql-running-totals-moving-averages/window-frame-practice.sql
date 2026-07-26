-- Day 026: Window Frame Practice
-- Topic: Understand explicit ROWS frames.
-- Safety note: every query in this file is read-only.

-- Compare frames side by side.
SELECT
    sale_date,
    region,
    total_sales,
    SUM(total_sales) OVER (
        PARTITION BY region
        ORDER BY sale_date, loaded_at
        ROWS BETWEEN CURRENT ROW AND CURRENT ROW
    ) AS current_row_only,
    SUM(total_sales) OVER (
        PARTITION BY region
        ORDER BY sale_date, loaded_at
        ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
    ) AS one_preceding_and_current,
    SUM(total_sales) OVER (
        PARTITION BY region
        ORDER BY sale_date, loaded_at
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS two_preceding_and_current,
    SUM(total_sales) OVER (
        PARTITION BY region
        ORDER BY sale_date, loaded_at
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS unbounded_to_current,
    SUM(total_sales) OVER (
        PARTITION BY region
        ORDER BY sale_date, loaded_at
        ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING
    ) AS current_to_one_following
FROM daily_sales_metrics
WHERE total_sales IS NOT NULL
ORDER BY region, sale_date, loaded_at;

-- Explain row counts for moving frames.
SELECT sale_date, region, total_sales,
    COUNT(*) OVER (
        PARTITION BY region
        ORDER BY sale_date, loaded_at
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS rows_available_in_three_row_frame
FROM daily_sales_metrics
ORDER BY region, sale_date, loaded_at;

-- ROWS versus RANGE concept:
-- ROWS counts physical rows in the ordered result.
-- RANGE can treat equal ordering values differently depending on platform and data.
-- Day 026 uses ROWS to keep beginner examples explicit.

-- Duplicate ordering values need deterministic secondary order such as loaded_at.
SELECT sale_date, region, COUNT(*) AS duplicate_business_date_rows
FROM daily_sales_metrics
GROUP BY sale_date, region
HAVING COUNT(*) > 1
ORDER BY region, sale_date;
