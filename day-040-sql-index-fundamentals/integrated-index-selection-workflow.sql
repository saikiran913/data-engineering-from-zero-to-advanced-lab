-- Day 040: Integrated Index Selection Workflow
-- Purpose: Combine workload, selectivity, trade-off, and candidate review signals.
-- Safety: All executable SQL is read-only and SELECT-based.
-- This workflow does not create, drop, rebuild, or deploy indexes.
-- Workload context: educational index selection from supplied catalogs.
-- Candidate columns: order_id, customer_id, order_date, order_status, country_group.

-- Part 1: identify important workload.
SELECT
    query_id,
    query_name,
    table_name,
    filter_columns,
    join_columns,
    sort_columns,
    frequency_band,
    importance_band
FROM query_workload_catalog
WHERE frequency_band IN ('HIGH', 'MEDIUM')
  AND importance_band IN ('HIGH', 'MEDIUM')
ORDER BY query_id;

-- Part 2: profile candidate columns.
SELECT
    table_name,
    column_name,
    total_rows,
    distinct_values,
    CASE
        WHEN total_rows = 0 THEN NULL
        ELSE 100.0 * distinct_values / total_rows
    END AS selectivity_percentage,
    selectivity_band,
    common_filter_use,
    common_join_use,
    common_sort_use
FROM column_profile_catalog
ORDER BY table_name, column_name;

-- Part 3: identify single-column candidates.
SELECT
    case_id,
    table_name,
    candidate_columns,
    query_pattern,
    candidate_rating,
    main_reason
FROM index_candidate_cases
WHERE candidate_columns NOT LIKE '%,%'
  AND candidate_rating IN ('STRONG_CANDIDATE', 'POSSIBLE_CANDIDATE')
ORDER BY case_id;

-- Part 4: identify composite candidates.
SELECT
    case_id,
    table_name,
    candidate_columns,
    query_pattern,
    candidate_rating,
    main_reason
FROM index_candidate_cases
WHERE candidate_columns LIKE '%,%'
ORDER BY case_id;

-- Part 5: reject weak candidates.
SELECT
    case_id,
    table_name,
    candidate_columns,
    candidate_rating,
    main_reason
FROM index_candidate_cases
WHERE candidate_rating = 'WEAK_CANDIDATE'
ORDER BY case_id;

-- Part 6: review platform-specific cases.
SELECT
    case_id,
    table_name,
    candidate_columns,
    query_pattern,
    candidate_rating,
    main_reason
FROM index_candidate_cases
WHERE candidate_rating = 'REVIEW_PLATFORM'
ORDER BY case_id;

-- Part 7: build candidate summary.
SELECT
    candidate_rating,
    COUNT(*) AS candidate_count
FROM index_candidate_cases
GROUP BY candidate_rating
ORDER BY candidate_rating;

-- CONCEPTUAL ONLY - DO NOT RUN
--
-- CREATE INDEX idx_orders_customer_date
--     ON orders (customer_id, order_date);
--
-- Real systems require platform-specific query plans, table size, and workload testing.

