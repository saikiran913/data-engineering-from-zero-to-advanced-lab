-- Day 031: CTE Staging Practice
-- Purpose: Use CTEs to model staging safely inside one SQL statement.
-- Safety: Read-only SELECT examples only. No temporary or staging object is deployed automatically.

-- Example 1: Standardise raw event fields.
-- Input grain: one row per received order event.
-- Output grain: one row per received order event.
WITH standardised_events AS (
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
)
SELECT
    event_id,
    order_id,
    customer_id,
    event_type,
    source_file,
    received_at
FROM standardised_events;

-- Example 2: Rank latest event per order.
WITH ranked_events AS (
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
    FROM raw_order_events
)
SELECT
    event_id,
    order_id,
    event_type,
    event_timestamp,
    row_num
FROM ranked_events
ORDER BY order_id, row_num;

-- Example 3 and 4: Select staged order candidate and add validation flags.
WITH ranked_events AS (
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
    FROM raw_order_events
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
    FROM ranked_events
    WHERE row_num = 1
)
SELECT
    order_id,
    customer_id,
    latest_event_type,
    order_amount,
    validation_status,
    validation_reason,
    source_file,
    received_at
FROM staged_order_candidates;

-- Example 5: Separate accepted and review rows.
SELECT
    validation_status,
    validation_reason,
    COUNT(*) AS row_count
FROM staged_orders
GROUP BY validation_status, validation_reason
ORDER BY validation_status, validation_reason;

-- Example 6: Build clean current-order output.
SELECT
    order_id,
    customer_id,
    CASE
        WHEN latest_event_type = 'ORDER_COMPLETED' THEN 'COMPLETED'
        WHEN latest_event_type = 'ORDER_REFUNDED' THEN 'REFUNDED'
        WHEN latest_event_type = 'ORDER_REFUND_REQUESTED' THEN 'REFUND_REQUESTED'
        ELSE 'STATUS_REVIEW'
    END AS order_status,
    order_amount,
    event_timestamp,
    source_file,
    received_at
FROM staged_orders
WHERE validation_status = 'ACCEPTED';

-- Example 7: Build a reporting summary.
SELECT
    order_date,
    COUNT(*) AS order_count,
    SUM(order_amount) AS total_order_amount
FROM clean_orders
WHERE order_status = 'COMPLETED'
GROUP BY order_date
ORDER BY order_date;
