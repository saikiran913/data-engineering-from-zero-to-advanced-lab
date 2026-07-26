-- Day 025: First and Last Row Analysis
-- Topic: Use LAG and LEAD boundary nulls to identify sequence boundaries.
-- Safety note: every query in this file is read-only.

-- First order per customer using LAG boundary.
WITH order_neighbours AS (
    SELECT
        order_id,
        customer_id,
        order_date,
        LAG(order_id) OVER (
            PARTITION BY customer_id
            ORDER BY order_date, updated_at, version_number
        ) AS previous_order_id
    FROM customer_order_history
)
SELECT *
FROM order_neighbours
WHERE previous_order_id IS NULL
ORDER BY customer_id;

-- Last order per customer using LEAD boundary.
WITH order_neighbours AS (
    SELECT
        order_id,
        customer_id,
        order_date,
        LEAD(order_id) OVER (
            PARTITION BY customer_id
            ORDER BY order_date, updated_at, version_number
        ) AS next_order_id
    FROM customer_order_history
)
SELECT *
FROM order_neighbours
WHERE next_order_id IS NULL
ORDER BY customer_id;

-- First and final payment status per transaction.
WITH payment_neighbours AS (
    SELECT
        transaction_id,
        status_sequence,
        payment_status,
        LAG(payment_status) OVER (
            PARTITION BY transaction_id
            ORDER BY status_sequence, status_timestamp
        ) AS previous_status,
        LEAD(payment_status) OVER (
            PARTITION BY transaction_id
            ORDER BY status_sequence, status_timestamp
        ) AS next_status
    FROM payment_status_history
)
SELECT *
FROM payment_neighbours
WHERE previous_status IS NULL
   OR next_status IS NULL
ORDER BY transaction_id, status_sequence;

-- First and latest product price.
WITH price_neighbours AS (
    SELECT
        product_id,
        price_date,
        unit_price,
        LAG(unit_price) OVER (
            PARTITION BY product_id
            ORDER BY price_date, updated_at
        ) AS previous_price,
        LEAD(unit_price) OVER (
            PARTITION BY product_id
            ORDER BY price_date, updated_at
        ) AS next_price
    FROM product_price_history
)
SELECT *
FROM price_neighbours
WHERE previous_price IS NULL
   OR next_price IS NULL
ORDER BY product_id, price_date;

-- First and last website event.
WITH event_neighbours AS (
    SELECT
        event_id,
        user_id,
        event_sequence,
        event_name,
        LAG(event_id) OVER (
            PARTITION BY user_id
            ORDER BY event_sequence, event_timestamp, event_id
        ) AS previous_event_id,
        LEAD(event_id) OVER (
            PARTITION BY user_id
            ORDER BY event_sequence, event_timestamp, event_id
        ) AS next_event_id
    FROM website_event_sequence
)
SELECT *
FROM event_neighbours
WHERE previous_event_id IS NULL
   OR next_event_id IS NULL
ORDER BY user_id, event_sequence;

-- Brief comparison: ROW_NUMBER can also identify first and last rows.
-- LAG and LEAD are useful when neighbouring values are needed in the same output.
