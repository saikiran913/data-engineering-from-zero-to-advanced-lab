-- Day 024: Ranking Validation Queries
-- Topic: Validate partitions, ties, nulls, row counts, and output grain.
-- Safety note: every query in this file is read-only.

-- 1. Count partitions.
SELECT COUNT(DISTINCT country) AS country_partition_count
FROM customer_sales;

-- 2. Count rows per partition.
SELECT country, COUNT(*) AS row_count
FROM customer_sales
GROUP BY country
ORDER BY country;

-- 3. Find null ranking measures.
SELECT 'customer_sales' AS dataset, customer_id AS record_id, country AS partition_key
FROM customer_sales
WHERE total_sales IS NULL
UNION ALL
SELECT 'employee_performance' AS dataset, employee_id AS record_id, department AS partition_key
FROM employee_performance
WHERE performance_score IS NULL;

-- 4. Find duplicate ranking values.
SELECT country, total_sales, COUNT(*) AS tied_value_count
FROM customer_sales
WHERE total_sales IS NOT NULL
GROUP BY country, total_sales
HAVING COUNT(*) > 1
ORDER BY country, total_sales DESC;

-- 5. Count tied top records.
WITH ranked_customers AS (
    SELECT customer_id, country, total_sales,
        RANK() OVER (
            PARTITION BY country
            ORDER BY total_sales DESC
        ) AS rank_value
    FROM customer_sales
    WHERE total_sales IS NOT NULL
)
SELECT country, COUNT(*) AS top_rank_row_count
FROM ranked_customers
WHERE rank_value = 1
GROUP BY country
HAVING COUNT(*) > 1
ORDER BY country;

-- 6. Confirm every eligible group has rank 1.
WITH ranked_regions AS (
    SELECT sale_date, region, total_sales,
        RANK() OVER (
            PARTITION BY region
            ORDER BY total_sales DESC
        ) AS rank_value
    FROM regional_daily_sales
    WHERE total_sales IS NOT NULL
)
SELECT region, MIN(rank_value) AS best_rank_found
FROM ranked_regions
GROUP BY region
ORDER BY region;

-- 7. Compare source row count and ranked row count.
WITH ranked_products AS (
    SELECT product_id, category, total_sales,
        RANK() OVER (
            PARTITION BY category
            ORDER BY total_sales DESC
        ) AS rank_value
    FROM product_sales
    WHERE total_sales IS NOT NULL
)
SELECT
    (SELECT COUNT(*) FROM product_sales WHERE total_sales IS NOT NULL) AS source_row_count,
    (SELECT COUNT(*) FROM ranked_products) AS ranked_row_count;

-- 8. Compare one-winner output count with partition count.
WITH ranked_customers AS (
    SELECT customer_id, country, total_sales,
        ROW_NUMBER() OVER (
            PARTITION BY country
            ORDER BY total_sales DESC, customer_id
        ) AS row_num
    FROM customer_sales
    WHERE total_sales IS NOT NULL
)
SELECT
    (SELECT COUNT(DISTINCT country) FROM customer_sales WHERE total_sales IS NOT NULL) AS partition_count,
    (SELECT COUNT(*) FROM ranked_customers WHERE row_num = 1) AS one_winner_count;

-- 9. Validate ranking direction by checking maximum value per group.
SELECT country, MAX(total_sales) AS expected_top_sales
FROM customer_sales
WHERE total_sales IS NOT NULL
GROUP BY country
ORDER BY country;

-- 10. Validate output grain for top-per-country.
WITH ranked_customers AS (
    SELECT customer_id, country, total_sales,
        RANK() OVER (
            PARTITION BY country
            ORDER BY total_sales DESC
        ) AS rank_value
    FROM customer_sales
    WHERE total_sales IS NOT NULL
)
SELECT country, COUNT(*) AS top_rank_rows
FROM ranked_customers
WHERE rank_value = 1
GROUP BY country
ORDER BY country;

-- 11. Review unexpected groups.
SELECT country, COUNT(*) AS row_count
FROM customer_sales
GROUP BY country
ORDER BY country;

-- 12. Ranking review queue.
SELECT
    'customer_sales' AS dataset,
    country AS partition_key,
    'NULL_RANKING_VALUE' AS issue_type,
    COUNT(*) AS issue_count,
    'Review null total_sales before ranking' AS review_message
FROM customer_sales
WHERE total_sales IS NULL
GROUP BY country
UNION ALL
SELECT
    'regional_daily_sales' AS dataset,
    region AS partition_key,
    'NULL_RANKING_VALUE' AS issue_type,
    COUNT(*) AS issue_count,
    'Review null total_sales before ranking' AS review_message
FROM regional_daily_sales
WHERE total_sales IS NULL
GROUP BY region;
