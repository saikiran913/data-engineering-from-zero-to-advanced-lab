-- Day 041: Plan Change Scenarios
-- Topic: Understanding why query plans may change
-- Safety: All executable SQL is read-only and SELECT-based.

-- Query 1: review cases that describe changing data volume or indexes.
SELECT
    case_id,
    query_goal,
    plan_a_summary,
    plan_b_summary,
    main_difference,
    beginner_interpretation
FROM plan_comparison_cases
WHERE beginner_interpretation LIKE '%volume%'
   OR beginner_interpretation LIKE '%index%'
   OR main_difference LIKE '%volume%'
   OR main_difference LIKE '%index%'
ORDER BY case_id;

-- Query 2: inspect high-row steps that may become more important as data grows.
SELECT
    plan_id,
    query_name,
    operator_name,
    table_name,
    estimated_rows,
    estimated_cost,
    notes
FROM query_plan_catalog
WHERE estimated_rows >= 1000
ORDER BY estimated_rows DESC;

-- Query 3: inspect low-row lookup steps.
SELECT
    plan_id,
    query_name,
    operator_name,
    table_name,
    estimated_rows,
    estimated_cost,
    notes
FROM query_plan_catalog
WHERE operator_name = 'INDEX_LOOKUP'
ORDER BY estimated_rows;

-- Query 4: inspect filter steps that reduce rows.
SELECT
    plan_id,
    query_name,
    step_number,
    operator_name,
    estimated_rows,
    filter_description,
    notes
FROM query_plan_catalog
WHERE operator_name = 'FILTER'
ORDER BY plan_id, step_number;

-- Query 5: inspect join steps because join order and input size can affect work.
SELECT
    plan_id,
    query_name,
    step_number,
    operator_name,
    estimated_rows,
    estimated_cost,
    join_description,
    notes
FROM query_plan_catalog
WHERE operator_name = 'JOIN'
ORDER BY estimated_cost DESC;

-- Query 6: inspect sort steps that may become expensive with more rows.
SELECT
    plan_id,
    query_name,
    step_number,
    operator_name,
    estimated_rows,
    estimated_cost,
    sort_description,
    notes
FROM query_plan_catalog
WHERE operator_name = 'SORT'
ORDER BY estimated_rows DESC;

-- Query 7: inspect aggregate steps.
SELECT
    plan_id,
    query_name,
    step_number,
    operator_name,
    estimated_rows,
    estimated_cost,
    notes
FROM query_plan_catalog
WHERE operator_name = 'AGGREGATE'
ORDER BY estimated_cost DESC;

-- Query 8: use sample data to understand changing distribution.
SELECT
    order_date,
    COUNT(*) AS order_count,
    SUM(order_amount) AS total_amount
FROM orders_plan_sample
GROUP BY order_date
ORDER BY order_date;

-- Query 9: review customer distribution that can affect join output size.
SELECT
    country_group,
    customer_segment,
    COUNT(*) AS customer_count
FROM customers_plan_sample
GROUP BY country_group, customer_segment
ORDER BY country_group, customer_segment;

-- Query 10: remember that plan changes require evidence.
SELECT
    case_id,
    business_question,
    main_risk,
    recommended_review
FROM query_plan_casebook
WHERE recommended_review LIKE '%Compare%'
   OR recommended_review LIKE '%Review%'
ORDER BY case_id;

