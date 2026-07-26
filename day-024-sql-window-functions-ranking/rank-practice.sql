-- Day 024: RANK Practice
-- Topic: Tie-aware ranking where gaps after ties are acceptable.
-- Safety note: every query in this file is read-only.

-- Employee rank within department.
SELECT employee_id, department, performance_score,
    RANK() OVER (
        PARTITION BY department
        ORDER BY performance_score DESC
    ) AS rank_value
FROM employee_performance
WHERE performance_score IS NOT NULL
ORDER BY department, rank_value, employee_id;

-- Customer sales rank within country.
SELECT customer_id, country, total_sales,
    RANK() OVER (
        PARTITION BY country
        ORDER BY total_sales DESC
    ) AS rank_value
FROM customer_sales
WHERE total_sales IS NOT NULL
ORDER BY country, rank_value, customer_id;

-- Product rank within category.
SELECT product_id, category, total_sales,
    RANK() OVER (
        PARTITION BY category
        ORDER BY total_sales DESC
    ) AS rank_value
FROM product_sales
WHERE total_sales IS NOT NULL
ORDER BY category, rank_value, product_id;

-- Campaign conversion rank within channel and country.
SELECT campaign_id, channel, country, conversions,
    RANK() OVER (
        PARTITION BY channel, country
        ORDER BY conversions DESC
    ) AS rank_value
FROM campaign_performance
ORDER BY channel, country, rank_value, campaign_id;

-- Regional sales-day rank within region.
SELECT sale_date, region, total_sales,
    RANK() OVER (
        PARTITION BY region
        ORDER BY total_sales DESC
    ) AS rank_value
FROM regional_daily_sales
WHERE total_sales IS NOT NULL
ORDER BY region, rank_value, sale_date;

-- Top three ranks by country.
-- rank_value <= 3 may return more than three rows if ties exist.
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
WHERE rank_value <= 3
ORDER BY country, rank_value, customer_id;

-- Bottom rank by region.
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

-- Practice tasks:
-- 1. Rank campaigns by clicks instead of conversions.
-- 2. Rank product units_sold within category.
-- 3. Explain why rank 1 can return multiple rows.
