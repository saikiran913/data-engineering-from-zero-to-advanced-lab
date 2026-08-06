-- Day 031: Intermediate Result Concept
-- Purpose: Show how a large transformation can be split into readable intermediate stages.
-- Safety: Read-only SELECT examples only. No temporary or staging object is deployed automatically.

-- Source preview.
SELECT
    event_id,
    order_id,
    customer_id,
    event_type,
    event_timestamp,
    order_amount,
    source_file,
    received_at
FROM raw_order_events
ORDER BY order_id, event_timestamp, received_at;

-- One-step direct query.
SELECT
    order_id,
    customer_id,
    event_type AS latest_event_type,
    order_amount,
    event_timestamp,
    source_file,
    received_at
FROM raw_order_events
WHERE customer_id IS NOT NULL
  AND order_amount > 0;

-- Same logic split into CTE stages.
-- source_orders grain: one row per received order event.
-- ranked_orders grain: one row per received order event with a sequence number.
-- staged_order_candidates grain: one row per selected order candidate.
-- accepted_orders grain: one row per accepted staged candidate.
-- review_orders grain: one row per review staged candidate.
WITH source_orders AS (
    SELECT
        event_id,
        order_id,
        customer_id,
        event_type,
        event_timestamp,
        order_amount,
        source_file,
        received_at
    FROM raw_order_events
),
ranked_orders AS (
    SELECT
        event_id,
        order_id,
        customer_id,
        event_type,
        event_timestamp,
        order_amount,
        source_file,
        received_at,
        ROW_NUMBER() OVER (
            PARTITION BY order_id
            ORDER BY event_timestamp DESC, received_at DESC, event_id
        ) AS row_num
    FROM source_orders
),
staged_order_candidates AS (
    SELECT
        order_id,
        customer_id,
        event_type AS latest_event_type,
        order_amount,
        event_timestamp,
        source_file,
        received_at,
        CASE
            WHEN customer_id IS NULL THEN 'REVIEW'
            WHEN order_amount IS NULL THEN 'REVIEW'
            WHEN order_amount <= 0 THEN 'REVIEW'
            ELSE 'ACCEPTED'
        END AS validation_status,
        CASE
            WHEN customer_id IS NULL THEN 'NULL_CUSTOMER_ID'
            WHEN order_amount IS NULL THEN 'NULL_ORDER_AMOUNT'
            WHEN order_amount <= 0 THEN 'INVALID_AMOUNT'
            ELSE 'READY_FOR_CLEAN'
        END AS validation_reason
    FROM ranked_orders
    WHERE row_num = 1
),
accepted_orders AS (
    SELECT
        order_id,
        customer_id,
        latest_event_type,
        order_amount,
        event_timestamp,
        source_file,
        received_at
    FROM staged_order_candidates
    WHERE validation_status = 'ACCEPTED'
),
review_orders AS (
    SELECT
        order_id,
        customer_id,
        latest_event_type,
        order_amount,
        event_timestamp,
        source_file,
        received_at,
        validation_reason
    FROM staged_order_candidates
    WHERE validation_status = 'REVIEW'
)
SELECT
    'ACCEPTED' AS output_type,
    COUNT(*) AS row_count
FROM accepted_orders
UNION ALL
SELECT
    'REVIEW',
    COUNT(*)
FROM review_orders;

-- Practice tasks:
-- 1. Explain each CTE's grain.
-- 2. Count accepted and review rows.
-- 3. Inspect review reasons before any clean-layer handoff.
