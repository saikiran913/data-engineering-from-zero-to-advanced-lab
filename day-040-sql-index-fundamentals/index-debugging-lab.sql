-- Day 040: Index Debugging Lab
-- Purpose: Show weak index-selection reasoning and safer evidence-based alternatives.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Index DDL examples are conceptual comments only.
-- Workload context: avoid guessing from one query or one column name.
-- Candidate columns: order_status, source_file, customer_id, order_date.

-- Mistake 1: assuming every WHERE column deserves an index.
SELECT
    query_id,
    query_name,
    filter_columns,
    'INDEX_EVERY_FILTER_COLUMN' AS unsafe_assumption
FROM query_workload_catalog
WHERE filter_columns <> '';

-- Safer 1: include frequency, importance, selectivity, and write pattern.
SELECT
    i.case_id,
    i.candidate_columns,
    i.selectivity_band,
    i.frequency_band,
    i.read_write_pattern,
    i.candidate_rating,
    i.main_reason
FROM index_candidate_cases AS i
ORDER BY i.case_id;

-- Mistake 2: treating low selectivity as an absolute never-index rule.
SELECT
    table_name,
    column_name,
    selectivity_band,
    'NEVER_INDEX' AS unsafe_conclusion
FROM column_profile_catalog
WHERE selectivity_band = 'LOW';

-- Safer 2: say low-selectivity columns need stronger evidence.
SELECT
    table_name,
    column_name,
    selectivity_band,
    common_filter_use,
    'REVIEW_WITH_WORKLOAD_AND_PLATFORM_EVIDENCE' AS safer_conclusion
FROM column_profile_catalog
WHERE selectivity_band = 'LOW';

-- Mistake 3: ignoring write-heavy trade-offs.
SELECT
    case_id,
    table_name,
    candidate_columns,
    'ADD_INDEX' AS unsafe_decision
FROM index_candidate_cases
WHERE frequency_band = 'HIGH';

-- Safer 3: review write-heavy cases separately.
SELECT
    case_id,
    table_name,
    candidate_columns,
    read_write_pattern,
    candidate_rating,
    main_reason
FROM index_candidate_cases
WHERE read_write_pattern = 'WRITE_HEAVY'
   OR candidate_rating = 'REVIEW_PLATFORM';

-- CONCEPTUAL ONLY - DO NOT RUN
--
-- CREATE INDEX idx_every_column
--     ON orders (order_status);
--
-- More indexes do not automatically mean better performance.

