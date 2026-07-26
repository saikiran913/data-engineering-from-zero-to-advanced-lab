-- Day 025: Change Detection Patterns
-- Topic: Use neighbouring rows to flag value and status changes.
-- Safety note: every query in this file is read-only.

-- Pattern 1: Payment status changed.
WITH payment_comparison AS (
    SELECT
        transaction_id,
        status_sequence,
        payment_status,
        status_timestamp,
        LAG(payment_status) OVER (
            PARTITION BY transaction_id
            ORDER BY status_sequence, status_timestamp
        ) AS previous_status
    FROM payment_status_history
)
SELECT *,
    CASE
        WHEN previous_status IS NULL THEN 'FIRST_STATUS'
        WHEN payment_status <> previous_status THEN 'STATUS_CHANGED'
        ELSE 'NO_CHANGE'
    END AS status_change_flag
FROM payment_comparison
ORDER BY transaction_id, status_sequence;

-- Pattern 2: Order amount changed.
WITH order_comparison AS (
    SELECT
        order_id,
        customer_id,
        order_amount,
        updated_at,
        LAG(order_amount) OVER (
            PARTITION BY order_id
            ORDER BY updated_at, version_number
        ) AS previous_amount
    FROM customer_order_history
)
SELECT
    order_id,
    customer_id,
    order_amount AS current_value,
    previous_amount AS previous_value,
    order_amount - previous_amount AS change_amount,
    CASE
        WHEN previous_amount IS NULL THEN 'FIRST_VERSION'
        WHEN order_amount <> previous_amount THEN 'AMOUNT_CHANGED'
        ELSE 'NO_CHANGE'
    END AS change_type,
    updated_at AS event_timestamp,
    'Change detection shows difference, not business cause' AS review_message
FROM order_comparison
ORDER BY order_id, updated_at;

-- Pattern 3, 4, and 5: Product price increased, decreased, or unchanged.
WITH price_comparison AS (
    SELECT
        product_id,
        price_date,
        unit_price,
        LAG(unit_price) OVER (
            PARTITION BY product_id
            ORDER BY price_date, updated_at
        ) AS previous_price
    FROM product_price_history
)
SELECT
    product_id,
    price_date,
    unit_price,
    previous_price,
    unit_price - previous_price AS change_amount,
    CASE
        WHEN unit_price IS NULL THEN 'REVIEW_NULL'
        WHEN previous_price IS NULL THEN 'FIRST_PRICE'
        WHEN unit_price > previous_price THEN 'PRICE_INCREASED'
        WHEN unit_price < previous_price THEN 'PRICE_DECREASED'
        ELSE 'PRICE_UNCHANGED'
    END AS change_type
FROM price_comparison
ORDER BY product_id, price_date;

-- Pattern 6: Daily sales increased or decreased.
WITH sales_comparison AS (
    SELECT
        sale_date,
        region,
        total_sales,
        LAG(total_sales) OVER (
            PARTITION BY region
            ORDER BY sale_date
        ) AS previous_sales
    FROM daily_sales_history
)
SELECT *,
    CASE
        WHEN total_sales IS NULL THEN 'REVIEW_NULL'
        WHEN previous_sales IS NULL THEN 'FIRST_RECORD'
        WHEN total_sales > previous_sales THEN 'SALES_INCREASED'
        WHEN total_sales < previous_sales THEN 'SALES_DECREASED'
        ELSE 'NO_CHANGE'
    END AS sales_change_type
FROM sales_comparison
ORDER BY region, sale_date;

-- Pattern 7 and 8: Current event differs from next event.
WITH event_comparison AS (
    SELECT
        event_id,
        user_id,
        event_sequence,
        event_name,
        LEAD(event_name) OVER (
            PARTITION BY user_id
            ORDER BY event_sequence, event_timestamp, event_id
        ) AS next_event_name
    FROM website_event_sequence
)
SELECT *,
    CASE
        WHEN event_name IS NULL THEN 'REVIEW_NULL_CURRENT_EVENT'
        WHEN next_event_name IS NULL THEN 'LAST_EVENT'
        WHEN event_name <> next_event_name THEN 'NEXT_EVENT_DIFFERS'
        ELSE 'NO_CHANGE'
    END AS next_event_review_flag
FROM event_comparison
ORDER BY user_id, event_sequence, event_id;

-- Pattern 9 and 10: First-known state and change review queue.
WITH payment_comparison AS (
    SELECT
        transaction_id,
        status_sequence,
        payment_status,
        status_timestamp,
        LAG(payment_status) OVER (
            PARTITION BY transaction_id
            ORDER BY status_sequence, status_timestamp
        ) AS previous_status
    FROM payment_status_history
)
SELECT
    transaction_id AS entity_id,
    payment_status AS current_value,
    previous_status AS previous_value,
    NULL AS change_amount,
    CASE
        WHEN previous_status IS NULL THEN 'FIRST_KNOWN_STATE'
        WHEN payment_status <> previous_status THEN 'STATUS_CHANGED'
        ELSE 'NO_CHANGE'
    END AS change_type,
    status_timestamp AS event_timestamp,
    'Review changed statuses before reporting cause' AS review_message
FROM payment_comparison
WHERE previous_status IS NULL
   OR payment_status <> previous_status
ORDER BY transaction_id, status_sequence;
