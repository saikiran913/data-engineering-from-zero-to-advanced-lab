-- Day 025: Next-Value Comparisons
-- Topic: Use LEAD to compare current rows with following rows.
-- Safety note: every query in this file is read-only.

-- Next payment status.
SELECT
    transaction_id,
    status_sequence,
    payment_status,
    LEAD(payment_status) OVER (
        PARTITION BY transaction_id
        ORDER BY status_sequence, status_timestamp
    ) AS next_payment_status
FROM payment_status_history
ORDER BY transaction_id, status_sequence, status_timestamp;

-- Next product price.
SELECT
    product_id,
    price_date,
    unit_price,
    LEAD(unit_price) OVER (
        PARTITION BY product_id
        ORDER BY price_date, updated_at
    ) AS next_price
FROM product_price_history
ORDER BY product_id, price_date, updated_at;

-- Next event name and timestamp.
SELECT
    event_id,
    user_id,
    event_sequence,
    event_name,
    event_timestamp,
    LEAD(event_name) OVER (
        PARTITION BY user_id
        ORDER BY event_sequence, event_timestamp, event_id
    ) AS next_event_name,
    LEAD(event_timestamp) OVER (
        PARTITION BY user_id
        ORDER BY event_sequence, event_timestamp, event_id
    ) AS next_event_timestamp
FROM website_event_sequence
ORDER BY user_id, event_sequence, event_id;

-- Next daily sales value.
SELECT
    sale_date,
    region,
    total_sales,
    LEAD(total_sales) OVER (
        PARTITION BY region
        ORDER BY sale_date
    ) AS next_sales
FROM daily_sales_history
ORDER BY region, sale_date;

-- Next sequence number and last-row identification.
WITH event_neighbours AS (
    SELECT
        event_id,
        user_id,
        event_sequence,
        LEAD(event_sequence) OVER (
            PARTITION BY user_id
            ORDER BY event_sequence, event_timestamp, event_id
        ) AS next_sequence
    FROM website_event_sequence
)
SELECT
    event_id,
    user_id,
    event_sequence,
    next_sequence,
    CASE
        WHEN next_sequence IS NULL THEN 'LAST_RECORD'
        ELSE 'NEXT_VALUE_AVAILABLE'
    END AS next_value_flag
FROM event_neighbours
ORDER BY user_id, event_sequence, event_id;

-- Time-until-next-event concept.
-- Timestamp difference syntax varies by platform. Adjust this expression for your SQL engine.
SELECT
    event_id,
    user_id,
    event_timestamp,
    LEAD(event_timestamp) OVER (
        PARTITION BY user_id
        ORDER BY event_sequence, event_timestamp, event_id
    ) AS next_event_timestamp
FROM website_event_sequence
ORDER BY user_id, event_sequence, event_id;

-- LEAD is useful when the next expected state matters.
