-- Day 041: Join Plan Review
-- Purpose: Review join steps, input sizes, and output estimates.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Join operator names vary by platform; this lesson keeps the concept simple.
-- Query goal: understand row movement through join steps.
-- Plan context: JOIN rows in query_plan_catalog.

-- Required warning:
-- Join output estimates should be interpreted together with table grain and
-- relationship type. More rows after a join are not automatically wrong.

-- Query 1: join operators.
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
ORDER BY plan_id, step_number;

-- Query 2: join plans with source access steps.
SELECT
    j.plan_id,
    j.query_name,
    a.operator_name AS input_operator,
    a.table_name,
    a.estimated_rows AS input_estimated_rows,
    j.estimated_rows AS join_estimated_rows,
    j.join_description
FROM query_plan_catalog AS j
JOIN query_plan_catalog AS a
    ON j.plan_id = a.plan_id
WHERE j.operator_name = 'JOIN'
  AND a.operator_name IN ('TABLE_SCAN', 'INDEX_LOOKUP')
ORDER BY j.plan_id, a.step_number;

-- Query 3: join-related casebook rows.
SELECT
    case_id,
    business_question,
    query_pattern,
    estimated_rows_band,
    cost_band,
    main_risk,
    recommended_review
FROM query_plan_casebook
WHERE main_operator = 'JOIN'
ORDER BY case_id;

-- Query 4: plan comparison cases involving joins.
SELECT
    case_id,
    query_goal,
    plan_a_summary,
    plan_b_summary,
    main_difference,
    beginner_interpretation
FROM plan_comparison_cases
WHERE main_difference LIKE '%join%'
ORDER BY case_id;

