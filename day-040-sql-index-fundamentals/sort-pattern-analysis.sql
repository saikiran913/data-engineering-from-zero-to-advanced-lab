-- Day 040: Sort Pattern Analysis
-- Purpose: Review ORDER BY patterns as one possible index signal.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Sort analysis does not create or recommend production indexes by itself.
-- Workload context: recent order reports and signup-date reports.
-- Candidate columns: order_date, signup_date, order_amount.

-- Query 1: workload queries with sort columns.
SELECT
    query_id,
    query_name,
    table_name,
    filter_columns,
    sort_columns,
    frequency_band,
    importance_band
FROM query_workload_catalog
WHERE sort_columns <> ''
ORDER BY query_id;

-- Query 2: recent orders sorted by order date.
SELECT
    order_id,
    customer_id,
    order_date,
    order_status,
    order_amount
FROM orders_workload
ORDER BY order_date DESC, order_id
LIMIT 10;

-- Query 3: customer signup-date sorting pattern.
SELECT
    customer_id,
    customer_status,
    country_group,
    signup_date,
    customer_segment
FROM customers_workload
ORDER BY signup_date DESC
LIMIT 10;

-- Query 4: sort columns from profile catalog.
SELECT
    table_name,
    column_name,
    selectivity_band,
    common_sort_use,
    'Sort patterns can matter, but index support varies by platform.' AS review_message
FROM column_profile_catalog
WHERE common_sort_use IN ('HIGH', 'MEDIUM')
ORDER BY table_name, column_name;

