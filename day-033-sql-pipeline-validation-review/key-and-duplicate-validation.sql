-- Day 033: Key and Duplicate Validation
-- Purpose: Validate required keys, distinct-key counts, and duplicate grain issues.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Validation queries do not modify source or target data.

-- Query 1: source row count versus distinct order count.
-- Source grain: one source record.
-- Target grain: not applicable.
-- Business key: order_id.
-- Expected difference: duplicate source orders may make row count greater than distinct order count.
SELECT
    COUNT(*) AS source_row_count,
    COUNT(DISTINCT order_id) AS distinct_order_count,
    COUNT(*) - COUNT(DISTINCT order_id) AS repeated_order_rows
FROM source_order_extract;

-- Query 2: duplicate source order IDs.
SELECT
    order_id,
    COUNT(*) AS source_row_count
FROM source_order_extract
GROUP BY
    order_id
HAVING COUNT(*) > 1
ORDER BY
    order_id;

-- Query 3: staged duplicate order IDs.
-- Expected relationship: stage should normally have one candidate per order unless a deliberate exception exists.
SELECT
    order_id,
    COUNT(*) AS staged_row_count
FROM staged_order_output
GROUP BY
    order_id
HAVING COUNT(*) > 1
ORDER BY
    order_id;

-- Query 4: clean duplicate order IDs.
-- Expected relationship: clean grain is one row per order.
SELECT
    order_id,
    COUNT(*) AS clean_row_count
FROM clean_order_output
GROUP BY
    order_id
HAVING COUNT(*) > 1
ORDER BY
    order_id;

-- Query 5: reporting composite-key duplicate check.
-- Note: grouped checks are portable across SQL platforms.
SELECT
    report_date,
    country_group,
    COUNT(*) AS reporting_row_count
FROM reporting_order_metrics
GROUP BY
    report_date,
    country_group
HAVING COUNT(*) > 1
ORDER BY
    report_date,
    country_group;

-- Query 6: null source business keys.
SELECT
    source_record_id,
    order_id,
    customer_id,
    source_file
FROM source_order_extract
WHERE order_id IS NULL
   OR customer_id IS NULL
ORDER BY
    source_record_id;

-- Query 7: null clean business keys.
SELECT
    order_id,
    customer_id,
    source_file,
    cleaned_at
FROM clean_order_output
WHERE order_id IS NULL
   OR customer_id IS NULL
ORDER BY
    order_id;

-- Query 8: clean row count versus distinct key count.
SELECT
    COUNT(*) AS clean_row_count,
    COUNT(DISTINCT order_id) AS distinct_clean_order_count,
    COUNT(*) - COUNT(DISTINCT order_id) AS duplicate_clean_key_rows
FROM clean_order_output;
