-- Day 024: Top-Per-Group Analysis
-- Topic: Return top or bottom records within logical groups.
-- Safety note: every query in this file is read-only.

-- Top employee per department, preserving ties.
WITH ranked_employees AS (
    SELECT employee_id, department, performance_score,
        RANK() OVER (
            PARTITION BY department
            ORDER BY performance_score DESC
        ) AS rank_value
    FROM employee_performance
    WHERE performance_score IS NOT NULL
)
SELECT *
FROM ranked_employees
WHERE rank_value = 1
ORDER BY department, employee_id;

-- One-winner employee version using ROW_NUMBER.
WITH ranked_employees AS (
    SELECT employee_id, department, performance_score, quality_score,
        ROW_NUMBER() OVER (
            PARTITION BY department
            ORDER BY performance_score DESC, quality_score DESC, employee_id
        ) AS row_num
    FROM employee_performance
    WHERE performance_score IS NOT NULL
)
SELECT *
FROM ranked_employees
WHERE row_num = 1
ORDER BY department;

-- Top customer per country.
WITH ranked_customers AS (
    SELECT customer_id, country, total_sales,
        RANK() OVER (
            PARTITION BY country
            ORDER BY total_sales DESC
        ) AS rank_value
    FROM customer_sales
    WHERE total_sales IS NOT NULL
)
SELECT *
FROM ranked_customers
WHERE rank_value = 1
ORDER BY country, customer_id;

-- Top product per category.
WITH ranked_products AS (
    SELECT product_id, category, total_sales,
        RANK() OVER (
            PARTITION BY category
            ORDER BY total_sales DESC
        ) AS rank_value
    FROM product_sales
    WHERE total_sales IS NOT NULL
)
SELECT *
FROM ranked_products
WHERE rank_value = 1
ORDER BY category, product_id;

-- Top campaign per channel and country.
WITH ranked_campaigns AS (
    SELECT campaign_id, channel, country, conversions,
        RANK() OVER (
            PARTITION BY channel, country
            ORDER BY conversions DESC
        ) AS rank_value
    FROM campaign_performance
)
SELECT *
FROM ranked_campaigns
WHERE rank_value = 1
ORDER BY channel, country, campaign_id;

-- Highest-sales day per region.
WITH ranked_days AS (
    SELECT sale_date, region, total_sales,
        RANK() OVER (
            PARTITION BY region
            ORDER BY total_sales DESC
        ) AS rank_value
    FROM regional_daily_sales
    WHERE total_sales IS NOT NULL
)
SELECT *
FROM ranked_days
WHERE rank_value = 1
ORDER BY region, sale_date;

-- Top two ranked positions per category.
WITH ranked_products AS (
    SELECT product_id, category, total_sales,
        DENSE_RANK() OVER (
            PARTITION BY category
            ORDER BY total_sales DESC
        ) AS dense_rank_value
    FROM product_sales
    WHERE total_sales IS NOT NULL
)
SELECT *
FROM ranked_products
WHERE dense_rank_value <= 2
ORDER BY category, dense_rank_value, product_id;

-- Bottom record per group.
WITH ranked_days AS (
    SELECT sale_date, region, total_sales,
        RANK() OVER (
            PARTITION BY region
            ORDER BY total_sales ASC
        ) AS bottom_rank
    FROM regional_daily_sales
    WHERE total_sales IS NOT NULL
)
SELECT *
FROM ranked_days
WHERE bottom_rank = 1
ORDER BY region, sale_date;

-- Ranking after aggregation.
WITH product_period_totals AS (
    SELECT category, product_id, SUM(total_sales) AS product_total_sales
    FROM product_sales
    WHERE total_sales IS NOT NULL
    GROUP BY category, product_id
),
ranked_product_totals AS (
    SELECT category, product_id, product_total_sales,
        RANK() OVER (
            PARTITION BY category
            ORDER BY product_total_sales DESC
        ) AS rank_value
    FROM product_period_totals
)
SELECT *
FROM ranked_product_totals
WHERE rank_value = 1
ORDER BY category, product_id;
