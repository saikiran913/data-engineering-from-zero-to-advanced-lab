-- Day 041: Cost Awareness
-- Topic: Reading optimizer cost values conceptually
-- Safety: All executable SQL is read-only and SELECT-based.
-- Reminder: Cost is not elapsed time and is not comparable across database platforms.

-- Query 1: review plan steps with estimated cost.
SELECT
    plan_id,
    query_name,
    step_number,
    operator_name,
    estimated_rows,
    estimated_cost,
    notes
FROM query_plan_catalog
ORDER BY plan_id, step_number;

-- Query 2: find higher-cost educational plan steps.
SELECT
    plan_id,
    query_name,
    operator_name,
    table_name,
    estimated_rows,
    estimated_cost
FROM query_plan_catalog
WHERE estimated_cost >= 50
ORDER BY estimated_cost DESC;

-- Query 3: compare cost bands in the casebook.
SELECT
    cost_band,
    COUNT(*) AS case_count
FROM query_plan_casebook
GROUP BY cost_band
ORDER BY cost_band;

-- Query 4: inspect high-cost-band cases.
SELECT
    case_id,
    business_question,
    query_pattern,
    main_operator,
    estimated_rows_band,
    cost_band,
    main_risk,
    recommended_review
FROM query_plan_casebook
WHERE cost_band = 'HIGH'
ORDER BY case_id;

-- Query 5: compare plan cases with different costs.
SELECT
    case_id,
    query_goal,
    plan_a_summary,
    plan_b_summary,
    cost_difference,
    beginner_interpretation
FROM plan_comparison_cases
ORDER BY case_id;

-- Query 6: summarize average cost by operator in the simplified catalog.
SELECT
    operator_name,
    COUNT(*) AS step_count,
    AVG(estimated_cost) AS average_estimated_cost,
    MIN(estimated_cost) AS lowest_estimated_cost,
    MAX(estimated_cost) AS highest_estimated_cost
FROM query_plan_catalog
GROUP BY operator_name
ORDER BY average_estimated_cost DESC;

-- Query 7: compare rows and cost together.
SELECT
    plan_id,
    query_name,
    operator_name,
    estimated_rows,
    estimated_cost,
    notes
FROM query_plan_catalog
WHERE estimated_rows >= 500
   OR estimated_cost >= 50
ORDER BY estimated_cost DESC, estimated_rows DESC;

-- Query 8: find lower-cost lookup-style examples.
SELECT
    plan_id,
    query_name,
    operator_name,
    estimated_rows,
    estimated_cost,
    notes
FROM query_plan_catalog
WHERE operator_name = 'INDEX_LOOKUP'
ORDER BY estimated_cost;

-- Query 9: find scan examples and read their notes before judging them.
SELECT
    plan_id,
    query_name,
    operator_name,
    table_name,
    estimated_rows,
    estimated_cost,
    notes
FROM query_plan_catalog
WHERE operator_name = 'TABLE_SCAN'
ORDER BY estimated_rows DESC;

-- Query 10: review operator cautions.
SELECT
    operator_name,
    operator_category,
    basic_meaning,
    beginner_caution
FROM plan_operator_catalog
ORDER BY operator_name;

