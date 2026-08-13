-- Day 035: Required-Field Completeness
-- Purpose: Check null and blank values in required fields.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Completeness queries do not modify or fabricate data.

-- Query 1: source required-field null counts.
-- Expected population: all source customer order rows.
-- Actual population: source_customer_orders.
-- Grain: one source record.
-- Business key: source_record_id.
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS missing_order_id_count,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS missing_customer_id_count,
    SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS missing_order_date_count,
    SUM(CASE WHEN order_amount IS NULL THEN 1 ELSE 0 END) AS missing_order_amount_count,
    SUM(CASE WHEN source_file IS NULL THEN 1 ELSE 0 END) AS missing_source_file_count
FROM source_customer_orders;

-- Query 2: blank country group check.
-- Blank-string handling varies by source system.
SELECT
    source_record_id,
    order_id,
    country_group,
    source_file
FROM source_customer_orders
WHERE country_group IS NULL
   OR country_group = ''
ORDER BY
    source_record_id;

-- Query 3: clean required-field null counts.
SELECT
    COUNT(*) AS clean_rows,
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS missing_order_id_count,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS missing_customer_id_count,
    SUM(CASE WHEN order_status IS NULL THEN 1 ELSE 0 END) AS missing_order_status_count,
    SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS missing_order_date_count,
    SUM(CASE WHEN country_group IS NULL THEN 1 ELSE 0 END) AS missing_country_group_count
FROM clean_customer_orders;

-- Query 4: reporting required metric nulls.
SELECT
    report_date,
    country_group,
    completed_order_count,
    total_completed_amount,
    refund_order_count,
    total_refund_amount,
    pending_order_count
FROM reporting_customer_orders
WHERE completed_order_count IS NULL
   OR total_completed_amount IS NULL
   OR refund_order_count IS NULL
   OR total_refund_amount IS NULL
   OR pending_order_count IS NULL
ORDER BY
    report_date,
    country_group;
