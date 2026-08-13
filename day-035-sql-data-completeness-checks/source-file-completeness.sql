-- Day 035: Source-File Completeness
-- Purpose: Compare expected files with received files.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Completeness queries do not modify or fabricate data.

-- Query 1: actual source-file counts.
SELECT
    source_file,
    COUNT(*) AS source_row_count
FROM source_customer_orders
GROUP BY
    source_file
ORDER BY
    source_file;

-- Query 2: missing expected source files.
SELECT
    e.source_file AS expected_source_file
FROM expected_records_catalog AS e
LEFT JOIN source_customer_orders AS s
    ON e.source_file = s.source_file
WHERE e.expectation_type = 'SOURCE_FILE'
  AND e.stage_name = 'SOURCE'
  AND s.source_file IS NULL
ORDER BY
    e.source_file;

-- Query 3: unexpected source files.
SELECT
    s.source_file,
    COUNT(*) AS source_row_count
FROM source_customer_orders AS s
LEFT JOIN expected_records_catalog AS e
    ON s.source_file = e.source_file
   AND e.expectation_type = 'SOURCE_FILE'
   AND e.stage_name = 'SOURCE'
WHERE e.source_file IS NULL
GROUP BY
    s.source_file
ORDER BY
    s.source_file;

-- Query 4: stage rows with missing source file.
SELECT
    stage_record_id,
    order_id,
    validation_status,
    validation_reason
FROM staged_customer_orders
WHERE source_file IS NULL
   OR source_file = ''
ORDER BY
    stage_record_id;
