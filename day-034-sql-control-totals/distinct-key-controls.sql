-- Day 034: Distinct-Key Controls
-- Purpose: Compare row counts with unique business-key counts.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Control queries do not modify data.

-- Query 1: source row count versus distinct order count.
-- Source population: source_sales_extract.
-- Source grain: one source record.
-- Control type: distinct-key count.
-- Expected relationship: row count can be greater than distinct order count when duplicates exist.
SELECT
    COUNT(*) AS source_row_count,
    COUNT(DISTINCT order_id) AS distinct_order_count,
    COUNT(*) - COUNT(DISTINCT order_id) AS repeated_order_rows
FROM source_sales_extract
WHERE order_id IS NOT NULL;

-- Query 2: duplicate source order IDs.
SELECT
    order_id,
    COUNT(*) AS source_row_count
FROM source_sales_extract
GROUP BY
    order_id
HAVING COUNT(*) > 1
ORDER BY
    order_id;

-- Query 3: stage duplicate candidate keys.
SELECT
    order_id,
    COUNT(*) AS stage_row_count
FROM staged_sales_output
GROUP BY
    order_id
HAVING COUNT(*) > 1
ORDER BY
    order_id;

-- Query 4: clean row count versus distinct clean orders.
SELECT
    COUNT(*) AS clean_row_count,
    COUNT(DISTINCT order_id) AS distinct_clean_order_count,
    COUNT(*) - COUNT(DISTINCT order_id) AS duplicate_clean_key_rows
FROM clean_sales_output;

-- Query 5: duplicate clean keys.
SELECT
    order_id,
    COUNT(*) AS clean_row_count
FROM clean_sales_output
GROUP BY
    order_id
HAVING COUNT(*) > 1
ORDER BY
    order_id;

-- Query 6: composite reporting key control using grouped rows.
-- Expected relationship: one row per report_date and country_group.
SELECT
    report_date,
    country_group,
    COUNT(*) AS reporting_row_count
FROM reporting_sales_summary
GROUP BY
    report_date,
    country_group
HAVING COUNT(*) > 1
ORDER BY
    report_date,
    country_group;
