-- Day 041: Sort and Aggregate Plan Review
-- Purpose: Review sort and aggregate operators in simplified plans.
-- Safety: All executable SQL is read-only and SELECT-based.
-- No production tuning commands or optimizer directives are included.
-- Query goal: understand ordering and summary work conceptually.
-- Plan context: SORT and AGGREGATE rows in query_plan_catalog.

-- Query 1: sort steps.
SELECT
    plan_id,
    query_name,
    step_number,
    estimated_rows,
    estimated_cost,
    sort_description,
    notes
FROM query_plan_catalog
WHERE operator_name = 'SORT'
ORDER BY plan_id, step_number;

-- Query 2: aggregate steps.
SELECT
    plan_id,
    query_name,
    step_number,
    estimated_rows,
    estimated_cost,
    filter_description,
    notes
FROM query_plan_catalog
WHERE operator_name = 'AGGREGATE'
ORDER BY plan_id, step_number;

-- Query 3: sort after filter review.
SELECT
    s.plan_id,
    s.query_name,
    f.estimated_rows AS filter_estimated_rows,
    s.estimated_rows AS sort_estimated_rows,
    s.estimated_cost AS sort_cost,
    s.sort_description,
    'Sort population should be reviewed with row estimates.' AS review_message
FROM query_plan_catalog AS s
JOIN query_plan_catalog AS f
    ON s.plan_id = f.plan_id
WHERE s.operator_name = 'SORT'
  AND f.operator_name = 'FILTER'
ORDER BY s.plan_id;

-- Query 4: operator summary for sort and aggregate.
SELECT
    operator_name,
    COUNT(*) AS operator_count,
    SUM(estimated_cost) AS total_estimated_cost,
    MAX(estimated_rows) AS max_estimated_rows
FROM query_plan_catalog
WHERE operator_name IN ('SORT', 'AGGREGATE')
GROUP BY operator_name
ORDER BY operator_name;

