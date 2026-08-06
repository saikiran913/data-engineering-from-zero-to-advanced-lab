-- Day 031: Source to Stage Validation
-- Purpose: Validate raw order events before and after staged candidate selection.
-- Safety: Read-only SELECT examples only. No temporary or staging object is deployed automatically.

-- Source row count.
SELECT COUNT(*) AS source_row_count
FROM raw_order_events;

-- Stage row count.
SELECT COUNT(*) AS stage_row_count
FROM staged_orders;

-- Distinct order count.
SELECT COUNT(DISTINCT order_id) AS distinct_order_count
FROM raw_order_events;

-- Duplicate event count.
SELECT event_id, COUNT(*) AS delivery_count
FROM raw_order_events
GROUP BY event_id
HAVING COUNT(*) > 1;

-- Null business-key count.
SELECT COUNT(*) AS null_business_key_count
FROM raw_order_events
WHERE order_id IS NULL
   OR customer_id IS NULL;

-- Null amount count.
SELECT COUNT(*) AS null_amount_count
FROM raw_order_events
WHERE order_amount IS NULL;

-- Negative amount count.
SELECT COUNT(*) AS negative_amount_count
FROM raw_order_events
WHERE order_amount < 0;

-- Missing timestamp count.
SELECT COUNT(*) AS missing_timestamp_count
FROM raw_order_events
WHERE event_timestamp IS NULL;

-- Late-arriving record review.
SELECT
    event_id,
    order_id,
    event_timestamp,
    received_at,
    'RECEIVED_BEFORE_EVENT_TIME' AS review_reason
FROM raw_order_events
WHERE received_at < event_timestamp;

-- Source-file distribution.
SELECT
    source_file,
    COUNT(*) AS row_count
FROM raw_order_events
GROUP BY source_file
ORDER BY source_file;

-- Accepted-plus-review reconciliation for staged grain.
SELECT
    COUNT(*) AS total_stage_records,
    SUM(CASE WHEN validation_status = 'ACCEPTED' THEN 1 ELSE 0 END) AS accepted_records,
    SUM(CASE WHEN validation_status = 'REVIEW' THEN 1 ELSE 0 END) AS review_records,
    COUNT(*)
      - SUM(CASE WHEN validation_status = 'ACCEPTED' THEN 1 ELSE 0 END)
      - SUM(CASE WHEN validation_status = 'REVIEW' THEN 1 ELSE 0 END) AS unexplained_difference
FROM staged_orders;

-- Validation summary.
WITH source_counts AS (
    SELECT
        COUNT(DISTINCT order_id) AS source_value
    FROM raw_order_events
),
stage_counts AS (
    SELECT
        COUNT(*) AS stage_value
    FROM staged_orders
)
SELECT
    'DISTINCT_SOURCE_ORDERS_TO_STAGE_RECORDS' AS check_name,
    source_counts.source_value,
    stage_counts.stage_value,
    stage_counts.stage_value - source_counts.source_value AS difference,
    CASE
        WHEN stage_counts.stage_value = source_counts.source_value THEN 'PASS'
        ELSE 'REVIEW'
    END AS status,
    'Compare only when both sides represent one row per order candidate.' AS review_message
FROM source_counts
INNER JOIN stage_counts
    ON 1 = 1;
