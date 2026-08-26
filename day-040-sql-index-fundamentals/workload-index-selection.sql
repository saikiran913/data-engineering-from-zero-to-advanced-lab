-- Day 040: Workload Index Selection
-- Purpose: Summarise workload signals before choosing candidate indexes.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Workload analysis does not deploy index changes.
-- Workload context: query catalog and candidate case catalog.
-- Candidate columns: filter, join, sort, and composite columns from workload metadata.

-- Query 1: workload summary by table and pattern.
SELECT
    table_name,
    read_or_write_pattern,
    frequency_band,
    importance_band,
    COUNT(*) AS query_count
FROM query_workload_catalog
GROUP BY
    table_name,
    read_or_write_pattern,
    frequency_band,
    importance_band
ORDER BY table_name, read_or_write_pattern, frequency_band;

-- Query 2: high-frequency high-importance workload.
SELECT
    query_id,
    query_name,
    table_name,
    query_type,
    filter_columns,
    join_columns,
    sort_columns
FROM query_workload_catalog
WHERE frequency_band = 'HIGH'
  AND importance_band = 'HIGH'
ORDER BY query_id;

-- Query 3: candidate count by rating.
SELECT
    candidate_rating,
    COUNT(*) AS candidate_count
FROM index_candidate_cases
GROUP BY candidate_rating
ORDER BY candidate_rating;

-- Query 4: candidate count by table.
SELECT
    table_name,
    candidate_rating,
    COUNT(*) AS candidate_count
FROM index_candidate_cases
GROUP BY table_name, candidate_rating
ORDER BY table_name, candidate_rating;

-- Query 5: final educational candidate summary.
SELECT
    table_name,
    candidate_columns,
    candidate_rating,
    main_reason
FROM index_candidate_cases
WHERE candidate_rating IN ('STRONG_CANDIDATE', 'POSSIBLE_CANDIDATE', 'REVIEW_PLATFORM')
ORDER BY candidate_rating, table_name, candidate_columns;

