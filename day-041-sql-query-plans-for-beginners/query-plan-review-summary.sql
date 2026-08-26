-- Day 041: Query Plan Review Summary
-- Topic: Building a beginner-friendly review summary from simplified plan data
-- Safety: All executable SQL is read-only and SELECT-based.

-- Query 1: summarize plan steps by plan.
SELECT
    plan_id,
    query_name,
    COUNT(*) AS step_count,
    SUM(estimated_rows) AS total_estimated_rows,
    SUM(estimated_cost) AS total_estimated_cost
FROM query_plan_catalog
GROUP BY plan_id, query_name
ORDER BY total_estimated_cost DESC;

-- Query 2: count operator types across all simplified plans.
SELECT
    operator_name,
    COUNT(*) AS step_count
FROM query_plan_catalog
GROUP BY operator_name
ORDER BY step_count DESC, operator_name;

-- Query 3: summarize plan steps by operator category.
SELECT
    p.operator_category,
    COUNT(*) AS step_count
FROM query_plan_catalog q
INNER JOIN plan_operator_catalog p
    ON q.operator_name = p.operator_name
GROUP BY p.operator_category
ORDER BY step_count DESC;

-- Query 4: list plan steps with filters.
SELECT
    plan_id,
    query_name,
    step_number,
    operator_name,
    filter_description,
    estimated_rows,
    estimated_cost
FROM query_plan_catalog
WHERE filter_description IS NOT NULL
ORDER BY plan_id, step_number;

-- Query 5: list plan steps with joins.
SELECT
    plan_id,
    query_name,
    step_number,
    operator_name,
    join_description,
    estimated_rows,
    estimated_cost
FROM query_plan_catalog
WHERE join_description IS NOT NULL
ORDER BY plan_id, step_number;

-- Query 6: list plan steps with sorts.
SELECT
    plan_id,
    query_name,
    step_number,
    operator_name,
    sort_description,
    estimated_rows,
    estimated_cost
FROM query_plan_catalog
WHERE sort_description IS NOT NULL
ORDER BY plan_id, step_number;

-- Query 7: identify plans that include joins.
SELECT
    plan_id,
    query_name,
    COUNT(*) AS join_step_count
FROM query_plan_catalog
WHERE operator_name = 'JOIN'
GROUP BY plan_id, query_name
ORDER BY plan_id;

-- Query 8: identify plans that include sorts.
SELECT
    plan_id,
    query_name,
    COUNT(*) AS sort_step_count
FROM query_plan_catalog
WHERE operator_name = 'SORT'
GROUP BY plan_id, query_name
ORDER BY plan_id;

-- Query 9: identify plans that include aggregates.
SELECT
    plan_id,
    query_name,
    COUNT(*) AS aggregate_step_count
FROM query_plan_catalog
WHERE operator_name = 'AGGREGATE'
GROUP BY plan_id, query_name
ORDER BY plan_id;

-- Query 10: create a readable case review list.
SELECT
    case_id,
    business_question,
    main_operator,
    estimated_rows_band,
    cost_band,
    main_risk,
    recommended_review
FROM query_plan_casebook
ORDER BY cost_band DESC, estimated_rows_band DESC, case_id;

