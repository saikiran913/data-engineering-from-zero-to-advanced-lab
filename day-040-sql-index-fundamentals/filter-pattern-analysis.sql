-- Day 040: Filter Pattern Analysis
-- Purpose: Review workload filters before thinking about indexes.
-- Safety: All executable SQL is read-only and SELECT-based.
-- No index DDL is executable in this file.
-- Workload context: frequent and important filters are stronger signals than one-off filters.
-- Candidate columns: filter_columns in query_workload_catalog.

-- Query 1: frequent equality or lookup filters.
SELECT
    query_id,
    query_name,
    table_name,
    filter_columns,
    frequency_band,
    importance_band,
    read_or_write_pattern
FROM query_workload_catalog
WHERE frequency_band = 'HIGH'
  AND query_type IN ('lookup', 'filter', 'multi_filter')
ORDER BY query_id;

-- Query 2: range filter patterns.
SELECT
    query_id,
    query_name,
    table_name,
    filter_columns,
    sort_columns,
    frequency_band,
    importance_band
FROM query_workload_catalog
WHERE query_type = 'range_report'
ORDER BY query_id;

-- Query 3: high-importance filters.
SELECT
    query_id,
    query_name,
    table_name,
    filter_columns,
    frequency_band,
    importance_band
FROM query_workload_catalog
WHERE importance_band = 'HIGH'
  AND filter_columns <> ''
ORDER BY query_id;

-- Query 4: low-frequency filters.
SELECT
    query_id,
    query_name,
    table_name,
    filter_columns,
    frequency_band,
    importance_band,
    'Low frequency may weaken an index case.' AS review_message
FROM query_workload_catalog
WHERE frequency_band = 'LOW'
  AND filter_columns <> ''
ORDER BY query_id;

-- Query 5: low-selectivity frequent filter candidates from the catalog.
SELECT
    c.table_name,
    c.column_name,
    c.selectivity_band,
    c.common_filter_use,
    'Frequent low-selectivity filters need extra evidence.' AS review_message
FROM column_profile_catalog AS c
WHERE c.common_filter_use IN ('HIGH', 'MEDIUM')
  AND c.selectivity_band = 'LOW'
ORDER BY c.table_name, c.column_name;

