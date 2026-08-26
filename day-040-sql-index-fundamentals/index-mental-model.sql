-- Day 040: Index Mental Model
-- Purpose: Explore index candidate thinking using read-only workload data.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Index DDL examples are conceptual comments only and must not be run.
-- Workload context: order and customer lookup, filter, join, sort, and write patterns.
-- Candidate columns: order_id, customer_id, order_date, order_status, country_group.

-- Query 1: inspect sample order workload rows.
SELECT
    order_id,
    customer_id,
    order_date,
    order_status,
    country_group,
    order_amount
FROM orders_workload
ORDER BY order_date, order_id
LIMIT 10;

-- Query 2: count order workload rows.
SELECT
    COUNT(*) AS total_order_rows
FROM orders_workload;

-- Query 3: compare candidate column cardinalities.
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS distinct_order_ids,
    COUNT(DISTINCT customer_id) AS distinct_customer_ids,
    COUNT(DISTINCT order_date) AS distinct_order_dates,
    COUNT(DISTINCT order_status) AS distinct_order_statuses,
    COUNT(DISTINCT country_group) AS distinct_country_groups
FROM orders_workload;

-- Query 4: selectivity ratio for customer_id.
WITH column_stats AS (
    SELECT
        COUNT(*) AS total_rows,
        COUNT(DISTINCT customer_id) AS distinct_customer_ids
    FROM orders_workload
)
SELECT
    total_rows,
    distinct_customer_ids,
    CASE
        WHEN total_rows = 0 THEN NULL
        ELSE 100.0 * distinct_customer_ids / total_rows
    END AS customer_id_selectivity_percentage
FROM column_stats;

-- Query 5: review workload catalog.
SELECT
    query_id,
    query_name,
    table_name,
    query_type,
    filter_columns,
    join_columns,
    sort_columns,
    frequency_band,
    importance_band,
    read_or_write_pattern
FROM query_workload_catalog
ORDER BY query_id;

-- Query 6: candidate-thinking summary.
SELECT
    case_id,
    table_name,
    candidate_columns,
    query_pattern,
    selectivity_band,
    frequency_band,
    read_write_pattern,
    candidate_rating,
    main_reason
FROM index_candidate_cases
ORDER BY case_id;

-- CONCEPTUAL ONLY - DO NOT RUN
--
-- CREATE INDEX idx_orders_customer_id
--     ON orders (customer_id);

