-- Day 025: Previous-Value Comparisons
-- Topic: Use LAG to compare current rows with earlier rows.
-- Safety note: every query in this file is read-only.

-- Previous order amount per customer.
-- Grain: order history row; versions are ordered by order date, timestamp, and version.
SELECT
    order_id,
    customer_id,
    order_date,
    order_amount,
    LAG(order_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date, updated_at, version_number
    ) AS previous_order_amount
FROM customer_order_history
ORDER BY customer_id, order_date, updated_at, version_number;

-- Previous payment status per transaction.
SELECT
    transaction_id,
    status_sequence,
    payment_status,
    LAG(payment_status) OVER (
        PARTITION BY transaction_id
        ORDER BY status_sequence, status_timestamp
    ) AS previous_payment_status
FROM payment_status_history
ORDER BY transaction_id, status_sequence, status_timestamp;

-- Previous product price.
SELECT
    product_id,
    price_date,
    unit_price,
    LAG(unit_price) OVER (
        PARTITION BY product_id
        ORDER BY price_date, updated_at
    ) AS previous_price
FROM product_price_history
ORDER BY product_id, price_date, updated_at;

-- Previous daily sales per region with numeric difference.
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
SELECT
    sale_date,
    region,
    total_sales,
    previous_sales,
    total_sales - previous_sales AS sales_change
FROM sales_comparison
ORDER BY region, sale_date;

-- Safe percentage change for product prices.
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
    CASE
        WHEN previous_price IS NULL THEN NULL
        WHEN previous_price = 0 THEN NULL
        WHEN unit_price IS NULL THEN NULL
        ELSE (unit_price - previous_price) * 100.0 / previous_price
    END AS price_change_percentage
FROM price_comparison
ORDER BY product_id, price_date;

-- Previous event and previous sequence number.
SELECT
    event_id,
    user_id,
    event_sequence,
    event_name,
    LAG(event_name) OVER (
        PARTITION BY user_id
        ORDER BY event_sequence, event_timestamp, event_id
    ) AS previous_event_name,
    LAG(event_sequence) OVER (
        PARTITION BY user_id
        ORDER BY event_sequence, event_timestamp, event_id
    ) AS previous_sequence
FROM website_event_sequence
ORDER BY user_id, event_sequence, event_id;

-- Previous two rows: offset 2.
SELECT
    product_id,
    price_date,
    unit_price,
    LAG(unit_price, 2) OVER (
        PARTITION BY product_id
        ORDER BY price_date, updated_at
    ) AS price_two_rows_back
FROM product_price_history
ORDER BY product_id, price_date, updated_at;

-- Review flags.
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
    CASE
        WHEN unit_price IS NULL THEN 'REVIEW_NULL'
        WHEN previous_price IS NULL THEN 'FIRST_RECORD'
        WHEN unit_price > previous_price THEN 'VALUE_INCREASED'
        WHEN unit_price < previous_price THEN 'VALUE_DECREASED'
        ELSE 'NO_CHANGE'
    END AS change_flag
FROM price_comparison
ORDER BY product_id, price_date;
