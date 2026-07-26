-- Day 024: ROW_NUMBER vs RANK vs DENSE_RANK
-- Topic: Compare ranking functions and tie behaviour.
-- Safety note: every query in this file is read-only.

-- 1. No ties example.
SELECT
    product_id,
    category,
    total_sales,
    ROW_NUMBER() OVER (ORDER BY total_sales DESC) AS row_number_value,
    RANK() OVER (ORDER BY total_sales DESC) AS rank_value,
    DENSE_RANK() OVER (ORDER BY total_sales DESC) AS dense_rank_value
FROM product_sales
WHERE category = 'Storage'
  AND sales_period = '2024-Q2'
  AND total_sales IS NOT NULL
ORDER BY total_sales DESC;

-- 2. One tie example.
-- RANK creates a gap after tied rows. DENSE_RANK does not.
SELECT
    employee_id,
    department,
    performance_score,
    ROW_NUMBER() OVER (
        PARTITION BY department
        ORDER BY performance_score DESC
    ) AS row_number_value,
    RANK() OVER (
        PARTITION BY department
        ORDER BY performance_score DESC
    ) AS rank_value,
    DENSE_RANK() OVER (
        PARTITION BY department
        ORDER BY performance_score DESC
    ) AS dense_rank_value
FROM employee_performance
WHERE department = 'Data'
  AND review_period = '2024-Q1'
ORDER BY performance_score DESC, employee_id;

-- 3. Multiple ties example.
SELECT
    customer_id,
    country,
    total_sales,
    ROW_NUMBER() OVER (
        PARTITION BY country
        ORDER BY total_sales DESC
    ) AS row_number_value,
    RANK() OVER (
        PARTITION BY country
        ORDER BY total_sales DESC
    ) AS rank_value,
    DENSE_RANK() OVER (
        PARTITION BY country
        ORDER BY total_sales DESC
    ) AS dense_rank_value
FROM customer_sales
WHERE total_sales IS NOT NULL
ORDER BY country, total_sales DESC, customer_id;

-- 4. Partitioned comparison by category.
SELECT
    product_id,
    category,
    total_sales,
    RANK() OVER (
        PARTITION BY category
        ORDER BY total_sales DESC
    ) AS category_rank,
    DENSE_RANK() OVER (
        PARTITION BY category
        ORDER BY total_sales DESC
    ) AS category_dense_rank
FROM product_sales
WHERE total_sales IS NOT NULL
ORDER BY category, category_rank, product_id;

-- 5. Meaningful tie-breaker with ROW_NUMBER.
-- Tie-breakers should be documented and approved.
SELECT
    customer_id,
    country,
    total_sales,
    total_orders,
    ROW_NUMBER() OVER (
        PARTITION BY country
        ORDER BY total_sales DESC, total_orders DESC, customer_id
    ) AS one_winner_sequence
FROM customer_sales
WHERE total_sales IS NOT NULL
ORDER BY country, one_winner_sequence;

-- 6. Same measure, different business question.
-- RANK preserves all tied top campaigns.
SELECT
    campaign_id,
    channel,
    country,
    conversions,
    RANK() OVER (
        PARTITION BY channel, country
        ORDER BY conversions DESC
    ) AS conversion_rank
FROM campaign_performance
ORDER BY channel, country, conversion_rank, campaign_id;
