-- Day 040: Poor Index Candidate Review
-- Purpose: Review weak or risky index candidates.
-- Safety: All executable SQL is read-only and SELECT-based.
-- No index is created or removed by this file.
-- Workload context: low selectivity, low frequency, small tables, and write-heavy patterns.
-- Candidate columns: weak and platform-review cases.

-- Query 1: weak candidates.
SELECT
    case_id,
    table_name,
    candidate_columns,
    query_pattern,
    selectivity_band,
    frequency_band,
    main_reason
FROM index_candidate_cases
WHERE candidate_rating = 'WEAK_CANDIDATE'
ORDER BY case_id;

-- Query 2: platform-review candidates.
SELECT
    case_id,
    table_name,
    candidate_columns,
    query_pattern,
    read_write_pattern,
    candidate_rating,
    main_reason
FROM index_candidate_cases
WHERE candidate_rating = 'REVIEW_PLATFORM'
ORDER BY case_id;

-- Query 3: low-selectivity columns from profile catalog.
SELECT
    table_name,
    column_name,
    distinct_values,
    total_rows,
    selectivity_band,
    common_filter_use,
    'Low selectivity does not mean never index, but it needs stronger evidence.' AS review_message
FROM column_profile_catalog
WHERE selectivity_band = 'LOW'
ORDER BY table_name, column_name;

-- Query 4: rare query patterns.
SELECT
    query_id,
    query_name,
    table_name,
    filter_columns,
    frequency_band,
    importance_band,
    'Rare queries may not justify permanent index overhead by themselves.' AS review_message
FROM query_workload_catalog
WHERE frequency_band = 'LOW'
ORDER BY query_id;

