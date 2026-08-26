-- Day 041: Integrated Query Plan Workflow
-- Topic: A safe beginner workflow for reading simplified query-plan evidence
-- Safety: All executable SQL is read-only and SELECT-based.

-- Step 1: start with the business questions in the casebook.
SELECT
    case_id,
    business_question,
    query_pattern
FROM query_plan_casebook
ORDER BY case_id;

-- Step 2: understand operator meanings before judging a plan.
SELECT
    operator_name,
    operator_category,
    basic_meaning,
    beginner_caution
FROM plan_operator_catalog
ORDER BY operator_name;

-- Step 3: inspect simplified plan steps.
SELECT
    plan_id,
    query_name,
    step_number,
    parent_step,
    operator_name,
    table_name,
    estimated_rows,
    estimated_cost,
    notes
FROM query_plan_catalog
ORDER BY plan_id, step_number;

-- Step 4: identify scans, but remember that scans are not automatically bad.
SELECT
    plan_id,
    query_name,
    table_name,
    estimated_rows,
    estimated_cost,
    notes
FROM query_plan_catalog
WHERE operator_name = 'TABLE_SCAN'
ORDER BY estimated_rows DESC;

-- Step 5: identify lookup-style access paths.
SELECT
    plan_id,
    query_name,
    table_name,
    estimated_rows,
    estimated_cost,
    notes
FROM query_plan_catalog
WHERE operator_name = 'INDEX_LOOKUP'
ORDER BY estimated_rows;

-- Step 6: review filters and their row estimates.
SELECT
    plan_id,
    query_name,
    step_number,
    filter_description,
    estimated_rows,
    estimated_cost
FROM query_plan_catalog
WHERE operator_name = 'FILTER'
ORDER BY plan_id, step_number;

-- Step 7: review joins and possible row multiplication.
SELECT
    plan_id,
    query_name,
    step_number,
    join_description,
    estimated_rows,
    estimated_cost
FROM query_plan_catalog
WHERE operator_name = 'JOIN'
ORDER BY estimated_cost DESC;

-- Step 8: review sorts and aggregates.
SELECT
    plan_id,
    query_name,
    step_number,
    operator_name,
    sort_description,
    estimated_rows,
    estimated_cost
FROM query_plan_catalog
WHERE operator_name IN ('SORT', 'AGGREGATE')
ORDER BY estimated_cost DESC;

-- Step 9: compare plans only within the same simplified catalog.
SELECT
    case_id,
    query_goal,
    main_difference,
    estimated_rows_difference,
    cost_difference,
    beginner_interpretation
FROM plan_comparison_cases
ORDER BY case_id;

-- Step 10: summarize the plan evidence.
SELECT
    plan_id,
    query_name,
    COUNT(*) AS step_count,
    SUM(estimated_rows) AS total_estimated_rows,
    SUM(estimated_cost) AS total_estimated_cost
FROM query_plan_catalog
GROUP BY plan_id, query_name
ORDER BY total_estimated_cost DESC;

-- Step 11: check sample data distribution that may influence plans conceptually.
SELECT
    country_group,
    order_status,
    COUNT(*) AS order_count,
    SUM(order_amount) AS total_amount
FROM orders_plan_sample
GROUP BY country_group, order_status
ORDER BY country_group, order_status;

-- Step 12: check joined sample data at a beginner level.
SELECT
    c.customer_segment,
    COUNT(*) AS joined_order_count,
    SUM(o.order_amount) AS joined_order_amount
FROM orders_plan_sample o
INNER JOIN customers_plan_sample c
    ON o.customer_id = c.customer_id
GROUP BY c.customer_segment
ORDER BY joined_order_amount DESC;

-- Step 13: finish with review recommendations.
SELECT
    case_id,
    business_question,
    main_risk,
    recommended_review
FROM query_plan_casebook
ORDER BY case_id;

