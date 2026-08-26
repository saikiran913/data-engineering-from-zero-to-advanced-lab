-- Day 041: Table Scan Review
-- Purpose: Review scan steps without automatically calling them bad.
-- Safety: All executable SQL is read-only and SELECT-based.
-- No production tuning commands, hints, DDL, or DML are included.
-- Query goal: understand scan context from simplified plan metadata.
-- Plan context: TABLE_SCAN rows in query_plan_catalog.

-- Required warning:
-- A scan is not automatically a problem. Judge it using table size, rows needed,
-- query purpose, and platform behaviour.

-- Query 1: plans containing TABLE_SCAN.
SELECT
    plan_id,
    query_name,
    table_name,
    estimated_rows,
    estimated_cost,
    notes AS scan_context,
    CASE
        WHEN estimated_rows <= 25 THEN 'EXPECTED'
        WHEN estimated_rows <= 50 THEN 'NEEDS_CONTEXT'
        ELSE 'REVIEW'
    END AS review_status,
    'Review scan using table size, rows needed, query purpose, and platform behaviour.' AS review_message
FROM query_plan_catalog
WHERE operator_name = 'TABLE_SCAN'
ORDER BY plan_id, step_number;

-- Query 2: small estimated scans.
SELECT
    plan_id,
    query_name,
    table_name,
    estimated_rows,
    estimated_cost,
    'Small scans can be reasonable.' AS review_message
FROM query_plan_catalog
WHERE operator_name = 'TABLE_SCAN'
  AND estimated_rows <= 25
ORDER BY plan_id;

-- Query 3: scan versus lookup comparison cases.
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

-- Query 4: scans with filters in the same plan.
SELECT
    s.plan_id,
    s.query_name,
    s.table_name,
    s.estimated_rows AS scan_estimated_rows,
    f.estimated_rows AS filter_estimated_rows,
    f.filter_description,
    'A filter above a scan may reduce rows for later steps.' AS review_message
FROM query_plan_catalog AS s
JOIN query_plan_catalog AS f
    ON s.plan_id = f.plan_id
WHERE s.operator_name = 'TABLE_SCAN'
  AND f.operator_name = 'FILTER'
ORDER BY s.plan_id;

