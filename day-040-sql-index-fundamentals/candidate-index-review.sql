-- Day 040: Candidate Index Review
-- Purpose: Classify possible index candidates using educational workload signals.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Candidate ratings are educational only and are not production tuning rules.
-- Workload context: query frequency, selectivity, importance, and read/write pattern.
-- Candidate columns: listed in index_candidate_cases.

-- Query 1: inspect candidate cases.
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

-- Query 2: educational candidate classification.
SELECT
    case_id,
    table_name,
    candidate_columns,
    selectivity_band,
    frequency_band,
    read_write_pattern,
    CASE
        WHEN selectivity_band = 'HIGH'
          AND frequency_band = 'HIGH'
          AND read_write_pattern <> 'WRITE_HEAVY'
        THEN 'STRONG_CANDIDATE'
        WHEN frequency_band IN ('HIGH', 'MEDIUM')
          AND read_write_pattern <> 'WRITE_HEAVY'
        THEN 'POSSIBLE_CANDIDATE'
        WHEN read_write_pattern = 'WRITE_HEAVY'
        THEN 'REVIEW_PLATFORM'
        ELSE 'WEAK_CANDIDATE'
    END AS educational_candidate_rating,
    'Educational only; real tuning requires platform evidence.' AS review_message
FROM index_candidate_cases
ORDER BY case_id;

-- Query 3: strong candidates from the supplied case catalog.
SELECT
    case_id,
    table_name,
    candidate_columns,
    query_pattern,
    main_reason
FROM index_candidate_cases
WHERE candidate_rating = 'STRONG_CANDIDATE'
ORDER BY case_id;

