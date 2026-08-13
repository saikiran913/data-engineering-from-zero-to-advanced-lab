-- Day 033: Completeness Validation
-- Purpose: Validate key, null, date, category, and source-file completeness.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Validation queries do not modify source or target data.

-- Query 1: null completeness in source critical columns.
SELECT
    COUNT(*) AS source_row_count,
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS null_order_id_count,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS null_customer_id_count,
    SUM(CASE WHEN order_amount IS NULL THEN 1 ELSE 0 END) AS null_order_amount_count,
    SUM(CASE WHEN source_file IS NULL THEN 1 ELSE 0 END) AS null_source_file_count
FROM source_order_extract;

-- Query 2: null completeness in staged output.
SELECT
    COUNT(*) AS staged_row_count,
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS null_order_id_count,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS null_customer_id_count,
    SUM(CASE WHEN order_amount IS NULL THEN 1 ELSE 0 END) AS null_order_amount_count,
    SUM(CASE WHEN source_file IS NULL THEN 1 ELSE 0 END) AS null_source_file_count
FROM staged_order_output;

-- Query 3: null reporting metrics.
SELECT
    report_date,
    country_group,
    completed_order_count,
    total_completed_amount,
    refund_order_count,
    total_refund_amount,
    pending_order_count
FROM reporting_order_metrics
WHERE completed_order_count IS NULL
   OR total_completed_amount IS NULL
   OR refund_order_count IS NULL
   OR total_refund_amount IS NULL
   OR pending_order_count IS NULL
ORDER BY
    report_date,
    country_group;

-- Query 4: source date coverage.
SELECT
    MIN(order_date) AS earliest_source_order_date,
    MAX(order_date) AS latest_source_order_date,
    COUNT(DISTINCT order_date) AS distinct_source_order_dates
FROM source_order_extract;

-- Query 5: reporting date coverage.
SELECT
    MIN(report_date) AS earliest_report_date,
    MAX(report_date) AS latest_report_date,
    COUNT(DISTINCT report_date) AS distinct_report_dates
FROM reporting_order_metrics;

-- Query 6: expected source-file checklist.
WITH expected_files AS (
    SELECT 'orders_2026_02_01.csv' AS expected_file
    UNION ALL SELECT 'orders_2026_02_02.csv'
    UNION ALL SELECT 'orders_2026_02_03.csv'
    UNION ALL SELECT 'orders_2026_02_04.csv'
    UNION ALL SELECT 'orders_2026_02_05.csv'
    UNION ALL SELECT 'orders_2026_02_06.csv'
    UNION ALL SELECT 'orders_2026_02_07.csv'
    UNION ALL SELECT 'orders_2026_02_08.csv'
    UNION ALL SELECT 'orders_2026_02_09.csv'
    UNION ALL SELECT 'orders_2026_02_10.csv'
    UNION ALL SELECT 'orders_2026_02_11.csv'
),
received_files AS (
    SELECT
        source_file
    FROM source_order_extract
    GROUP BY
        source_file
)
SELECT
    e.expected_file,
    CASE
        WHEN r.source_file IS NULL THEN 'MISSING_FILE'
        ELSE 'RECEIVED'
    END AS file_status
FROM expected_files AS e
LEFT JOIN received_files AS r
    ON e.expected_file = r.source_file
ORDER BY
    e.expected_file;

-- Query 7: source category coverage by status.
SELECT
    order_status,
    COUNT(*) AS source_row_count
FROM source_order_extract
GROUP BY
    order_status
ORDER BY
    order_status;

-- Query 8: source category coverage by country group.
SELECT
    country_group,
    COUNT(*) AS source_row_count
FROM source_order_extract
GROUP BY
    country_group
ORDER BY
    country_group;
