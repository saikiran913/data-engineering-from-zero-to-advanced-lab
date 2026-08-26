-- Day 041: Filter Plan Review
-- Purpose: Review filter steps and row-reduction clues.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Plan interpretation is conceptual and platform-aware.
-- Query goal: understand estimated rows before and after filters.
-- Plan context: FILTER rows in query_plan_catalog.

-- Query 1: filter operators.
SELECT
    plan_id,
    query_name,
    step_number,
    operator_name,
    estimated_rows,
    estimated_cost,
    filter_description,
    notes
FROM query_plan_catalog
WHERE operator_name = 'FILTER'
ORDER BY plan_id, step_number;

-- Query 2: filter steps with scan input estimates from the same plan.
SELECT
    f.plan_id,
    f.query_name,
    s.estimated_rows AS estimated_rows_before_filter,
    f.estimated_rows AS estimated_rows_after_filter,
    s.estimated_rows - f.estimated_rows AS estimated_row_reduction,
    f.filter_description
FROM query_plan_catalog AS f
JOIN query_plan_catalog AS s
    ON f.plan_id = s.plan_id
WHERE f.operator_name = 'FILTER'
  AND s.operator_name = 'TABLE_SCAN'
ORDER BY f.plan_id;

-- Query 3: highly selective filters in simplified plans.
SELECT
    plan_id,
    query_name,
    filter_description,
    estimated_rows,
    'Low estimated rows after filter may indicate selective filtering.' AS review_message
FROM query_plan_catalog
WHERE operator_name = 'FILTER'
  AND estimated_rows <= 3
ORDER BY plan_id;

-- Query 4: filter summary.
SELECT
    filter_description,
    COUNT(*) AS filter_step_count,
    MIN(estimated_rows) AS min_estimated_rows,
    MAX(estimated_rows) AS max_estimated_rows
FROM query_plan_catalog
WHERE operator_name = 'FILTER'
GROUP BY filter_description
ORDER BY filter_description;

