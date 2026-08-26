-- Day 041: EXPLAIN Concept
-- Purpose: Introduce query-plan inspection using safe metadata queries.
-- Safety: All executable SQL is read-only and SELECT-based.
-- EXPLAIN examples are platform-specific comments only.
-- Query goal: understand simplified plan steps without running production tuning commands.
-- Plan context: query_plan_catalog contains educational plan metadata.

-- Query 1: a simple read-only query that could have a plan.
SELECT
    order_id,
    customer_id,
    order_amount
FROM orders_plan_sample
WHERE order_id = 'OP5001';

-- PLATFORM-SPECIFIC EXAMPLE - REVIEW BEFORE USE
--
-- EXPLAIN
-- SELECT
--     order_id,
--     customer_id,
--     order_amount
-- FROM orders
-- WHERE order_id = 'OP5001';

-- CAUTION: Some ANALYZE-style variants execute the query.
-- PLATFORM-SPECIFIC EXAMPLE - REVIEW BEFORE USE
--
-- EXPLAIN ANALYZE
-- SELECT ...;

-- Query 2: inspect the simplified plan catalog.
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

-- Query 3: summarise operators by plan.
SELECT
    plan_id,
    query_name,
    operator_name,
    COUNT(*) AS operator_count
FROM query_plan_catalog
GROUP BY plan_id, query_name, operator_name
ORDER BY plan_id, operator_name;

-- Query 4: identify estimated rows and cost.
SELECT
    plan_id,
    query_name,
    step_number,
    operator_name,
    estimated_rows,
    estimated_cost
FROM query_plan_catalog
ORDER BY plan_id, step_number;

