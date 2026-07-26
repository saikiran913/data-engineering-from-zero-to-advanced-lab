-- Day 025: Step-by-Step LAG and LEAD Workflows
-- Topic: Build row-comparison queries from business question to validation.
-- Safety note: every query in this file is read-only.

-- Worked example 1: Payment status changes.
WITH payment_comparison AS (
    SELECT
        transaction_id,
        status_sequence,
        payment_status,
        LAG(payment_status) OVER (
            PARTITION BY transaction_id
            ORDER BY status_sequence, status_timestamp
        ) AS previous_status
    FROM payment_status_history
)
SELECT *
FROM payment_comparison
WHERE previous_status IS NULL
   OR payment_status <> previous_status
ORDER BY transaction_id, status_sequence;

-- Worked example 2: Product price changes.
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
SELECT *
FROM price_comparison
WHERE previous_price IS NULL
   OR unit_price <> previous_price
   OR unit_price IS NULL
ORDER BY product_id, price_date;

-- Worked example 3: Daily sales change by region.
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

-- Worked example 4: Missing dates.
-- Date-difference syntax varies by platform; adjust the interval calculation.
WITH date_comparison AS (
    SELECT
        sale_date,
        region,
        LAG(sale_date) OVER (
            PARTITION BY region
            ORDER BY sale_date
        ) AS previous_sale_date
    FROM daily_sales_history
)
SELECT *
FROM date_comparison
ORDER BY region, sale_date;

-- Worked example 5: Website event sequence gaps.
WITH event_comparison AS (
    SELECT
        event_id,
        user_id,
        event_sequence,
        LAG(event_sequence) OVER (
            PARTITION BY user_id
            ORDER BY event_sequence, event_timestamp, event_id
        ) AS previous_sequence
    FROM website_event_sequence
)
SELECT *
FROM event_comparison
WHERE previous_sequence IS NULL
   OR event_sequence - previous_sequence <> 1
ORDER BY user_id, event_sequence;

-- Worked example 6: First and last order per customer.
WITH order_neighbours AS (
    SELECT
        order_id,
        customer_id,
        order_date,
        LAG(order_id) OVER (
            PARTITION BY customer_id
            ORDER BY order_date, updated_at, version_number
        ) AS previous_order_id,
        LEAD(order_id) OVER (
            PARTITION BY customer_id
            ORDER BY order_date, updated_at, version_number
        ) AS next_order_id
    FROM customer_order_history
)
SELECT *
FROM order_neighbours
WHERE previous_order_id IS NULL
   OR next_order_id IS NULL
ORDER BY customer_id, order_date;

-- Worked example 7: Late-arriving record review.
SELECT
    order_id,
    customer_id,
    order_date,
    updated_at,
    LAG(order_date) OVER (
        PARTITION BY customer_id
        ORDER BY updated_at, version_number
    ) AS previous_loaded_order_date
FROM customer_order_history
ORDER BY customer_id, updated_at, version_number;

-- Row-comparison design checklist:
-- 1. Business grain.
-- 2. Partition key.
-- 3. Ordering columns.
-- 4. Tie-breaker.
-- 5. Previous or next comparison.
-- 6. Null-boundary policy.
-- 7. Default-value policy.
-- 8. Change calculation.
-- 9. Review condition.
-- 10. Validation checks.
