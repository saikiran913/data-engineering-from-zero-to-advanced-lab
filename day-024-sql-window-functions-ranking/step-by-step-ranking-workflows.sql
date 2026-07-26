-- Day 024: Step-by-Step Ranking Workflows
-- Topic: Design ranking queries from business question to validation.
-- Safety note: every query in this file is read-only.

-- Example 1: Top customer per country.
-- Grain: one row per customer and period.
-- Partition: country. Measure: total_sales. Direction: DESC. Function: ROW_NUMBER.
WITH ranked_customers AS (
    SELECT customer_id, country, total_sales, total_orders,
        ROW_NUMBER() OVER (
            PARTITION BY country
            ORDER BY total_sales DESC, total_orders DESC, customer_id
        ) AS row_num
    FROM customer_sales
    WHERE total_sales IS NOT NULL
)
SELECT *
FROM ranked_customers
WHERE row_num = 1
ORDER BY country;

-- Example 2: All tied top products per category.
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

-- Example 3: Exactly one campaign per channel-country.
WITH ranked_campaigns AS (
    SELECT campaign_id, channel, country, conversions, clicks, spend,
        ROW_NUMBER() OVER (
            PARTITION BY channel, country
            ORDER BY conversions DESC, clicks DESC, spend ASC, campaign_id
        ) AS row_num
    FROM campaign_performance
)
SELECT *
FROM ranked_campaigns
WHERE row_num = 1
ORDER BY channel, country;

-- Example 4: Top three dense performance levels per department.
WITH ranked_employees AS (
    SELECT employee_id, department, performance_score,
        DENSE_RANK() OVER (
            PARTITION BY department
            ORDER BY performance_score DESC
        ) AS performance_level
    FROM employee_performance
    WHERE performance_score IS NOT NULL
)
SELECT *
FROM ranked_employees
WHERE performance_level <= 3
ORDER BY department, performance_level, employee_id;

-- Example 5: Bottom sales day per region.
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

-- Example 6: Ranking after aggregation.
WITH customer_period_totals AS (
    SELECT country, customer_id, SUM(total_sales) AS customer_total_sales
    FROM customer_sales
    WHERE total_sales IS NOT NULL
    GROUP BY country, customer_id
),
ranked_customer_totals AS (
    SELECT country, customer_id, customer_total_sales,
        RANK() OVER (
            PARTITION BY country
            ORDER BY customer_total_sales DESC
        ) AS rank_value
    FROM customer_period_totals
)
SELECT *
FROM ranked_customer_totals
WHERE rank_value <= 3
ORDER BY country, rank_value, customer_id;

-- Ranking-design checklist:
-- 1. State the business question.
-- 2. Confirm the input grain.
-- 3. Choose partition columns.
-- 4. Choose ranking measure.
-- 5. Choose ASC or DESC.
-- 6. Choose ROW_NUMBER, RANK, or DENSE_RANK.
-- 7. Run ranking.
-- 8. Filter through a CTE if needed.
-- 9. Validate ties, nulls, partitions, row counts, and output grain.
