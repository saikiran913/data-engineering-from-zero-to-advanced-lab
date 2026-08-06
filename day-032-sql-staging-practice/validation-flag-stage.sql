-- Day 032: Validation Flag Stage Practice
-- Purpose: Add accepted and review decisions to staged candidates.
-- Safety: All executable SQL is read-only and SELECT-based.
-- No staging or temporary object is deployed.

-- Query 1: add validation status and validation reason.
-- Input grain: one staged customer order candidate.
-- Output grain: one validated customer order candidate.
-- Business key: order_id.
SELECT
    stage_record_id,
    order_id,
    customer_id,
    standard_status,
    order_amount,
    order_date,
    country_group,
    source_event_id,
    source_file,
    received_at,
    CASE
        WHEN order_id IS NULL THEN 'REVIEW'
        WHEN customer_id IS NULL THEN 'REVIEW'
        WHEN order_amount IS NULL THEN 'REVIEW'
        WHEN order_amount < 0 THEN 'REVIEW'
        WHEN order_amount = 0 THEN 'REVIEW'
        WHEN standard_status IS NULL THEN 'REVIEW'
        WHEN standard_status IN ('UNKNOWN', 'FAILED') THEN 'REVIEW'
        ELSE 'ACCEPTED'
    END AS calculated_validation_status,
    CASE
        WHEN order_id IS NULL THEN 'NULL_ORDER_ID'
        WHEN customer_id IS NULL THEN 'NULL_CUSTOMER_ID'
        WHEN order_amount IS NULL THEN 'NULL_ORDER_AMOUNT'
        WHEN order_amount < 0 THEN 'NEGATIVE_ORDER_AMOUNT'
        WHEN order_amount = 0 THEN 'ZERO_AMOUNT_REVIEW'
        WHEN standard_status IS NULL THEN 'MISSING_STATUS_MAPPING'
        WHEN standard_status = 'UNKNOWN' THEN 'UNSUPPORTED_STATUS'
        WHEN standard_status = 'FAILED' THEN 'STATUS_REQUIRES_REVIEW'
        ELSE 'READY_FOR_CLEAN'
    END AS calculated_validation_reason
FROM staged_customer_orders
ORDER BY
    stage_record_id;

-- Query 2: compare stored validation status with recalculated status.
-- Input grain: one staged customer order candidate.
-- Output grain: one row where stored and calculated values differ.
-- Business key: stage_record_id.
WITH recalculated AS (
    SELECT
        stage_record_id,
        validation_status,
        CASE
            WHEN order_id IS NULL THEN 'REVIEW'
            WHEN customer_id IS NULL THEN 'REVIEW'
            WHEN order_amount IS NULL THEN 'REVIEW'
            WHEN order_amount < 0 THEN 'REVIEW'
            WHEN order_amount = 0 THEN 'REVIEW'
            WHEN standard_status IS NULL THEN 'REVIEW'
            WHEN standard_status IN ('UNKNOWN', 'FAILED') THEN 'REVIEW'
            ELSE 'ACCEPTED'
        END AS calculated_validation_status
    FROM staged_customer_orders
)
SELECT
    stage_record_id,
    validation_status,
    calculated_validation_status
FROM recalculated
WHERE validation_status <> calculated_validation_status
ORDER BY
    stage_record_id;

-- Query 3: validation reason distribution.
-- Input grain: one staged candidate.
-- Output grain: one row per validation reason.
-- Business key: validation_reason.
SELECT
    validation_status,
    validation_reason,
    COUNT(*) AS row_count
FROM staged_customer_orders
GROUP BY
    validation_status,
    validation_reason
ORDER BY
    validation_status,
    validation_reason;

-- Query 4: inspect review rows with full audit context.
-- Input grain: one staged candidate.
-- Output grain: one review row.
-- Business key: stage_record_id.
SELECT
    stage_record_id,
    order_id,
    customer_id,
    standard_status,
    order_amount,
    validation_reason,
    source_event_id,
    source_file,
    received_at
FROM staged_customer_orders
WHERE validation_status = 'REVIEW'
ORDER BY
    validation_reason,
    order_id;

-- Query 5: check for missing validation fields.
-- Input grain: one staged candidate.
-- Output grain: one row with missing validation details.
-- Business key: stage_record_id.
SELECT
    stage_record_id,
    order_id,
    validation_status,
    validation_reason
FROM staged_customer_orders
WHERE validation_status IS NULL
   OR validation_reason IS NULL
ORDER BY
    stage_record_id;
