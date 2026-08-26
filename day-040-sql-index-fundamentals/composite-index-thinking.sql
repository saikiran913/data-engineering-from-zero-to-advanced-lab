-- Day 040: Composite Index Thinking
-- Purpose: Review multi-column query patterns conceptually.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Composite index syntax appears only in conceptual comments.
-- Workload context: customer-date and status-date filters.
-- Candidate columns: customer_id + order_date, order_status + order_date.

-- Query 1: multi-column filter workload entries.
SELECT
    query_id,
    query_name,
    table_name,
    filter_columns,
    sort_columns,
    frequency_band,
    importance_band
FROM query_workload_catalog
WHERE query_type = 'multi_filter'
ORDER BY query_id;

-- Query 2: customer and date filter example.
SELECT
    order_id,
    customer_id,
    order_date,
    order_status,
    order_amount
FROM orders_workload
WHERE customer_id = 'C001'
  AND order_date BETWEEN '2026-04-01' AND '2026-04-12'
ORDER BY order_date;

-- Query 3: status and date filter example.
SELECT
    order_id,
    order_status,
    order_date,
    country_group,
    order_amount
FROM orders_workload
WHERE order_status = 'COMPLETED'
  AND order_date BETWEEN '2026-04-01' AND '2026-04-12'
ORDER BY order_date;

-- Query 4: composite candidate cases.
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
WHERE candidate_columns LIKE '%,%'
ORDER BY case_id;

-- CONCEPTUAL ONLY - DO NOT RUN
--
-- CREATE INDEX idx_orders_customer_date
--     ON orders (customer_id, order_date);
--
-- Column order matters conceptually. One composite index does not help every column order equally.

