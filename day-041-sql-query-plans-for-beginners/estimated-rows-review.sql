-- Day 041: Estimated Rows Review
-- Topic: Reading estimated row counts in simplified query plans
-- Safety: All executable SQL is read-only and SELECT-based.

-- Query 1: review every plan step with its estimated rows.
SELECT
    plan_id,
    query_name,
    step_number,
    operator_name,
    estimated_rows,
    notes
FROM query_plan_catalog
ORDER BY plan_id, step_number;

-- Query 2: find plan steps with higher estimated row counts.
SELECT
    plan_id,
    query_name,
    operator_name,
    table_name,
    estimated_rows
FROM query_plan_catalog
WHERE estimated_rows >= 1000
ORDER BY estimated_rows DESC;

-- Query 3: find plan steps with lower estimated row counts.
SELECT
    plan_id,
    query_name,
    operator_name,
    table_name,
    estimated_rows
FROM query_plan_catalog
WHERE estimated_rows < 100
ORDER BY estimated_rows;

-- Query 4: compare estimated rows by operator.
SELECT
    operator_name,
    COUNT(*) AS plan_step_count,
    MIN(estimated_rows) AS lowest_estimated_rows,
    MAX(estimated_rows) AS highest_estimated_rows,
    AVG(estimated_rows) AS average_estimated_rows
FROM query_plan_catalog
GROUP BY operator_name
ORDER BY highest_estimated_rows DESC;

-- Query 5: inspect cases where row-estimate mismatch is the main risk.
SELECT
    case_id,
    business_question,
    query_pattern,
    main_operator,
    estimated_rows_band,
    main_risk,
    recommended_review
FROM query_plan_casebook
WHERE main_risk LIKE '%estimate%'
   OR main_risk LIKE '%Estimate%'
ORDER BY case_id;

-- Query 6: compare estimated rows in beginner comparison cases.
SELECT
    case_id,
    query_goal,
    main_difference,
    estimated_rows_difference,
    beginner_interpretation
FROM plan_comparison_cases
ORDER BY case_id;

-- Query 7: count real sample orders by status for context.
-- In real systems, estimates come from database statistics, not from this manual query.
SELECT
    order_status,
    COUNT(*) AS order_count
FROM orders_plan_sample
GROUP BY order_status
ORDER BY order_count DESC;

-- Query 8: count real sample orders by country group for context.
SELECT
    country_group,
    COUNT(*) AS order_count
FROM orders_plan_sample
GROUP BY country_group
ORDER BY order_count DESC;

-- Query 9: count real sample customers by status for context.
SELECT
    customer_status,
    COUNT(*) AS customer_count
FROM customers_plan_sample
GROUP BY customer_status
ORDER BY customer_count DESC;

-- Query 10: inspect high-row plan steps before making conclusions.
SELECT
    plan_id,
    query_name,
    step_number,
    operator_name,
    estimated_rows,
    estimated_cost,
    filter_description,
    join_description,
    notes
FROM query_plan_catalog
WHERE estimated_rows >= 500
ORDER BY estimated_rows DESC, estimated_cost DESC;

