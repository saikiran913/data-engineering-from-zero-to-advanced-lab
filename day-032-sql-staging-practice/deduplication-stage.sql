-- Day 032: Deduplication Stage Practice
-- Purpose: Select candidate records using a documented business rule.
-- Safety: All executable SQL is read-only and SELECT-based.
-- No staging or temporary object is deployed.

-- Query 1: rank raw events by latest business event and received timestamp.
-- Input grain: one raw event.
-- Output grain: one ranked event.
-- Business key: order_id.
WITH ranked_events AS (
    SELECT
        source_event_id,
        order_id,
        customer_id,
        raw_status,
        event_timestamp,
        order_amount,
        country_code,
        source_file,
        received_at,
        ROW_NUMBER() OVER (
            PARTITION BY order_id
            ORDER BY event_timestamp DESC,
                     received_at DESC,
                     source_event_id
        ) AS row_num
    FROM raw_customer_orders
)
SELECT
    source_event_id,
    order_id,
    raw_status,
    event_timestamp,
    received_at,
    row_num
FROM ranked_events
ORDER BY
    order_id,
    row_num;

-- Query 2: select one candidate row per order.
-- Input grain: one ranked event.
-- Output grain: one candidate row per order_id.
-- Business key: order_id.
WITH ranked_events AS (
    SELECT
        source_event_id,
        order_id,
        customer_id,
        raw_status,
        event_timestamp,
        order_amount,
        country_code,
        source_file,
        received_at,
        ROW_NUMBER() OVER (
            PARTITION BY order_id
            ORDER BY event_timestamp DESC,
                     received_at DESC,
                     source_event_id
        ) AS row_num
    FROM raw_customer_orders
)
SELECT
    source_event_id,
    order_id,
    customer_id,
    raw_status,
    event_timestamp,
    order_amount,
    country_code,
    source_file,
    received_at
FROM ranked_events
WHERE row_num = 1
ORDER BY
    order_id;

-- Query 3: detect orders with more than one raw event.
-- Input grain: one raw event.
-- Output grain: one row per repeated order_id.
-- Business key: order_id.
SELECT
    order_id,
    COUNT(*) AS raw_event_count,
    MIN(event_timestamp) AS earliest_event_timestamp,
    MAX(event_timestamp) AS latest_event_timestamp
FROM raw_customer_orders
GROUP BY
    order_id
HAVING COUNT(*) > 1
ORDER BY
    order_id;

-- Query 4: detect same-timestamp ties by order.
-- Input grain: one raw event.
-- Output grain: one row per order and timestamp with repeated events.
-- Business key: order_id plus event_timestamp.
SELECT
    order_id,
    event_timestamp,
    COUNT(*) AS event_count
FROM raw_customer_orders
GROUP BY
    order_id,
    event_timestamp
HAVING COUNT(*) > 1
ORDER BY
    order_id,
    event_timestamp;

-- Query 5: inspect late-arriving records.
-- Input grain: one raw event.
-- Output grain: one late-arriving event candidate.
-- Business key: source_event_id.
SELECT
    source_event_id,
    order_id,
    event_timestamp,
    source_file,
    received_at
FROM raw_customer_orders
WHERE event_timestamp < '2026-01-01 00:00:00'
  AND received_at >= '2026-01-01 00:00:00'
ORDER BY
    received_at;

-- Query 6: compare received order with previous received event for the same order.
-- Input grain: one raw event.
-- Output grain: one raw event with previous event timestamp.
-- Business key: order_id.
WITH event_sequence AS (
    SELECT
        source_event_id,
        order_id,
        event_timestamp,
        received_at,
        LAG(event_timestamp) OVER (
            PARTITION BY order_id
            ORDER BY received_at,
                     source_event_id
        ) AS previous_event_timestamp
    FROM raw_customer_orders
)
SELECT
    source_event_id,
    order_id,
    previous_event_timestamp,
    event_timestamp,
    received_at
FROM event_sequence
ORDER BY
    order_id,
    received_at;
