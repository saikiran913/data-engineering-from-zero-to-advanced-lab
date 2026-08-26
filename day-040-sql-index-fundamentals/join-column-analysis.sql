-- Day 040: Join Column Analysis
-- Purpose: Review join-column usage as an index candidate signal.
-- Safety: All executable SQL is read-only and SELECT-based.
-- No index is created or changed by this file.
-- Workload context: customer joins between orders_workload and customers_workload.
-- Candidate columns: customer_id on both tables.

-- Query 1: workload queries that include join columns.
SELECT
    query_id,
    query_name,
    table_name,
    join_columns,
    frequency_band,
    importance_band,
    read_or_write_pattern
FROM query_workload_catalog
WHERE join_columns <> ''
ORDER BY query_id;

-- Query 2: order/customer join sample.
SELECT
    o.order_id,
    o.customer_id,
    c.customer_status,
    c.customer_segment,
    o.order_date,
    o.order_amount
FROM orders_workload AS o
JOIN customers_workload AS c
    ON o.customer_id = c.customer_id
WHERE o.customer_id IN ('C001', 'C002', 'C003')
ORDER BY o.customer_id, o.order_date;

-- Query 3: column profile for join columns.
SELECT
    table_name,
    column_name,
    total_rows,
    distinct_values,
    selectivity_band,
    common_join_use
FROM column_profile_catalog
WHERE common_join_use IN ('HIGH', 'MEDIUM')
ORDER BY table_name, column_name;

-- Query 4: join candidate cases.
SELECT
    case_id,
    table_name,
    candidate_columns,
    query_pattern,
    selectivity_band,
    frequency_band,
    candidate_rating,
    main_reason
FROM index_candidate_cases
WHERE query_pattern LIKE '%join%'
ORDER BY case_id;

