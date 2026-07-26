-- Day 024: Tie-Aware Ranking
-- Topic: Detect, preserve, and review tied ranking values.
-- Safety note: every query in this file is read-only.

-- Detect tied top ranks.
WITH ranked_products AS (
    SELECT product_id, category, total_sales,
        RANK() OVER (
            PARTITION BY category
            ORDER BY total_sales DESC
        ) AS rank_value
    FROM product_sales
    WHERE total_sales IS NOT NULL
),
tied_top_groups AS (
    SELECT category, rank_value, COUNT(*) AS tied_row_count
    FROM ranked_products
    WHERE rank_value = 1
    GROUP BY category, rank_value
    HAVING COUNT(*) > 1
)
SELECT *
FROM tied_top_groups
ORDER BY category;

-- Return all tied winners.
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

-- Select one row using a documented tie-breaker.
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

-- Flag unresolved ties.
WITH ranked_employees AS (
    SELECT employee_id, department, performance_score,
        RANK() OVER (
            PARTITION BY department
            ORDER BY performance_score DESC
        ) AS rank_value
    FROM employee_performance
    WHERE performance_score IS NOT NULL
),
tie_review AS (
    SELECT department, performance_score, COUNT(*) AS tied_row_count
    FROM ranked_employees
    WHERE rank_value = 1
    GROUP BY department, performance_score
    HAVING COUNT(*) > 1
)
SELECT
    department AS group_identifier,
    performance_score AS ranking_value,
    tied_row_count,
    'TIED_TOP_RANK' AS review_reason,
    'Confirm whether all tied rows should remain or one winner is required' AS suggested_action
FROM tie_review
ORDER BY department;

-- Real ties versus duplicate data.
SELECT category, total_sales, COUNT(*) AS row_count
FROM product_sales
WHERE total_sales IS NOT NULL
GROUP BY category, total_sales
HAVING COUNT(*) > 1
ORDER BY category, total_sales DESC;

-- Null ranking-value review.
SELECT 'customer_sales' AS dataset, country AS partition_key, COUNT(*) AS issue_count
FROM customer_sales
WHERE total_sales IS NULL
GROUP BY country
UNION ALL
SELECT 'employee_performance' AS dataset, department AS partition_key, COUNT(*) AS issue_count
FROM employee_performance
WHERE performance_score IS NULL
GROUP BY department;

-- Tie-policy documentation lives in ranking_rule_examples.csv.
SELECT scenario_id, business_question, recommended_function, tie_policy, review_required
FROM ranking_rule_examples
ORDER BY scenario_id;
