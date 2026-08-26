-- Day 041: Plan Comparison Practice
-- Topic: Comparing two simplified plans without overreacting
-- Safety: All executable SQL is read-only and SELECT-based.

-- Query 1: read all comparison cases.
SELECT
    case_id,
    query_goal,
    plan_a_summary,
    plan_b_summary,
    main_difference,
    estimated_rows_difference,
    cost_difference,
    beginner_interpretation
FROM plan_comparison_cases
ORDER BY case_id;

-- Query 2: focus on scan versus lookup examples.
SELECT
    case_id,
    query_goal,
    plan_a_summary,
    plan_b_summary,
    main_difference,
    beginner_interpretation
FROM plan_comparison_cases
WHERE main_difference LIKE '%scan%'
   OR main_difference LIKE '%lookup%'
ORDER BY case_id;

-- Query 3: focus on early versus late filtering.
SELECT
    case_id,
    query_goal,
    plan_a_summary,
    plan_b_summary,
    estimated_rows_difference,
    beginner_interpretation
FROM plan_comparison_cases
WHERE main_difference LIKE '%filter%'
ORDER BY case_id;

-- Query 4: focus on join-size differences.
SELECT
    case_id,
    query_goal,
    plan_a_summary,
    plan_b_summary,
    estimated_rows_difference,
    cost_difference,
    beginner_interpretation
FROM plan_comparison_cases
WHERE main_difference LIKE '%join%'
ORDER BY case_id;

-- Query 5: focus on sort or aggregate differences.
SELECT
    case_id,
    query_goal,
    plan_a_summary,
    plan_b_summary,
    main_difference,
    cost_difference,
    beginner_interpretation
FROM plan_comparison_cases
WHERE main_difference LIKE '%sort%'
   OR main_difference LIKE '%aggregation%'
ORDER BY case_id;

-- Query 6: compare plan steps for two educational plans.
SELECT
    plan_id,
    query_name,
    step_number,
    operator_name,
    estimated_rows,
    estimated_cost,
    notes
FROM query_plan_catalog
WHERE plan_id IN ('P007', 'P008')
ORDER BY plan_id, step_number;

-- Query 7: summarize operators for compared plans.
SELECT
    plan_id,
    query_name,
    operator_name,
    COUNT(*) AS operator_count
FROM query_plan_catalog
WHERE plan_id IN ('P007', 'P008')
GROUP BY plan_id, query_name, operator_name
ORDER BY plan_id, operator_name;

-- Query 8: compare estimated cost totals inside the same educational catalog.
SELECT
    plan_id,
    query_name,
    SUM(estimated_cost) AS total_estimated_cost
FROM query_plan_catalog
GROUP BY plan_id, query_name
ORDER BY total_estimated_cost DESC;

-- Query 9: compare estimated row totals inside the same educational catalog.
SELECT
    plan_id,
    query_name,
    SUM(estimated_rows) AS total_estimated_rows
FROM query_plan_catalog
GROUP BY plan_id, query_name
ORDER BY total_estimated_rows DESC;

-- Query 10: list the plan-review questions to ask.
SELECT
    case_id,
    business_question,
    query_pattern,
    main_operator,
    main_risk,
    recommended_review
FROM query_plan_casebook
ORDER BY case_id;

