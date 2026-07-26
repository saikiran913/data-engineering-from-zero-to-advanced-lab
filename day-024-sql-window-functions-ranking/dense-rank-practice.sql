-- Day 024: DENSE_RANK Practice
-- Topic: Tie-aware ranking without skipped rank numbers.
-- Safety note: every query in this file is read-only.

-- Dense employee leaderboard.
SELECT employee_id, department, performance_score,
    DENSE_RANK() OVER (
        PARTITION BY department
        ORDER BY performance_score DESC
    ) AS dense_rank_value
FROM employee_performance
WHERE performance_score IS NOT NULL
ORDER BY department, dense_rank_value, employee_id;

-- Product revenue positions.
SELECT product_id, category, total_sales,
    DENSE_RANK() OVER (
        PARTITION BY category
        ORDER BY total_sales DESC
    ) AS dense_rank_value
FROM product_sales
WHERE total_sales IS NOT NULL
ORDER BY category, dense_rank_value, product_id;

-- Customer positions within country.
SELECT customer_id, country, total_sales,
    DENSE_RANK() OVER (
        PARTITION BY country
        ORDER BY total_sales DESC
    ) AS dense_rank_value
FROM customer_sales
WHERE total_sales IS NOT NULL
ORDER BY country, dense_rank_value, customer_id;

-- Campaign positions.
SELECT campaign_id, channel, country, conversions,
    DENSE_RANK() OVER (
        PARTITION BY channel, country
        ORDER BY conversions DESC
    ) AS dense_rank_value
FROM campaign_performance
ORDER BY channel, country, dense_rank_value, campaign_id;

-- Top three dense ranks.
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

-- Bottom dense ranks for regional sales days.
WITH ranked_days AS (
    SELECT sale_date, region, total_sales,
        DENSE_RANK() OVER (
            PARTITION BY region
            ORDER BY total_sales ASC
        ) AS bottom_dense_rank
    FROM regional_daily_sales
    WHERE total_sales IS NOT NULL
)
SELECT *
FROM ranked_days
WHERE bottom_dense_rank = 1
ORDER BY region, sale_date;

-- Compare DENSE_RANK <= 3 and ROW_NUMBER <= 3.
SELECT customer_id, country, total_sales,
    DENSE_RANK() OVER (
        PARTITION BY country
        ORDER BY total_sales DESC
    ) AS dense_rank_value,
    ROW_NUMBER() OVER (
        PARTITION BY country
        ORDER BY total_sales DESC, customer_id
    ) AS row_number_value
FROM customer_sales
WHERE total_sales IS NOT NULL
ORDER BY country, dense_rank_value, row_number_value;
