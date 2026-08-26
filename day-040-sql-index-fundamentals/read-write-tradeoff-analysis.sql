-- Day 040: Read/Write Trade-off Analysis
-- Purpose: Review why indexes can help reads but add write and storage overhead.
-- Safety: All executable SQL is read-only and SELECT-based.
-- No index is created, dropped, rebuilt, or deployed by this file.
-- Workload context: read-heavy, write-heavy, mixed, small, large, and warehouse cases.
-- Candidate columns: reviewed through workload_tradeoff_cases.

-- Query 1: inspect workload trade-off cases.
SELECT
    case_id,
    workload_description,
    read_frequency,
    write_frequency,
    table_size_band,
    index_count_band,
    main_tradeoff,
    recommended_thinking
FROM workload_tradeoff_cases
ORDER BY case_id;

-- Query 2: write-heavy cases.
SELECT
    case_id,
    workload_description,
    write_frequency,
    table_size_band,
    index_count_band,
    main_tradeoff,
    recommended_thinking
FROM workload_tradeoff_cases
WHERE write_frequency = 'HIGH'
ORDER BY case_id;

-- Query 3: read-heavy cases.
SELECT
    case_id,
    workload_description,
    read_frequency,
    table_size_band,
    recommended_thinking
FROM workload_tradeoff_cases
WHERE read_frequency = 'HIGH'
ORDER BY case_id;

-- Query 4: workload catalog by read/write pattern.
SELECT
    read_or_write_pattern,
    COUNT(*) AS workload_count
FROM query_workload_catalog
GROUP BY read_or_write_pattern
ORDER BY read_or_write_pattern;

