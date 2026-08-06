-- Day 029: Grain and Key Validation
-- Purpose: Validate expected output grain and key uniqueness.
-- Safety: Read-only examples only. No production view is deployed or replaced.

-- Document expected grain.
SELECT
    view_name,
    expected_grain,
    required_columns
FROM view_consumers
ORDER BY view_name;

-- Count rows for proposed one-row-per-order output.
WITH proposed_order_view AS (
    SELECT order_id, customer_id, order_status, order_amount
    FROM orders_source
    WHERE customer_id IS NOT NULL
      AND order_amount > 0
)
SELECT COUNT(*) AS row_count
FROM proposed_order_view;

-- Count distinct keys.
WITH proposed_order_view AS (
    SELECT order_id, customer_id, order_status, order_amount
    FROM orders_source
    WHERE customer_id IS NOT NULL
      AND order_amount > 0
)
SELECT COUNT(DISTINCT order_id) AS distinct_order_count
FROM proposed_order_view;

-- Find duplicate order keys.
WITH proposed_order_view AS (
    SELECT order_id, customer_id, order_status, order_amount
    FROM orders_source
    WHERE customer_id IS NOT NULL
      AND order_amount > 0
)
SELECT order_id, COUNT(*) AS row_count
FROM proposed_order_view
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Compare source grain and proposed view grain.
SELECT
    COUNT(*) AS source_rows,
    COUNT(DISTINCT order_id) AS distinct_order_ids
FROM orders_source;

-- One-row-per-customer policy.
WITH latest_customers AS (
    SELECT
        customer_id,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY updated_at DESC
        ) AS row_num
    FROM customers_source
)
SELECT customer_id, COUNT(*) AS row_count
FROM latest_customers
WHERE row_num = 1
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Campaign-date-country-channel policy.
SELECT
    campaign_id,
    metric_date,
    channel,
    country,
    COUNT(*) AS row_count
FROM campaign_metrics_source
GROUP BY campaign_id, metric_date, channel, country
HAVING COUNT(*) > 1;

-- Order-payment-attempt policy.
WITH order_payment_attempts AS (
    SELECT
        o.order_id,
        p.payment_id
    FROM orders_source AS o
    LEFT JOIN payments_source AS p
        ON o.order_id = p.order_id
)
SELECT COUNT(*) AS order_payment_attempt_rows
FROM order_payment_attempts;

-- Grain-review summary.
WITH proposed_order_view AS (
    SELECT order_id
    FROM orders_source
    WHERE customer_id IS NOT NULL
      AND order_amount > 0
),
duplicate_keys AS (
    SELECT order_id
    FROM proposed_order_view
    GROUP BY order_id
    HAVING COUNT(*) > 1
)
SELECT
    'vw_valid_orders' AS view_name,
    'one row per order_id' AS expected_grain,
    (SELECT COUNT(*) FROM proposed_order_view) AS row_count,
    (SELECT COUNT(DISTINCT order_id) FROM proposed_order_view) AS distinct_key_count,
    (SELECT COUNT(*) FROM duplicate_keys) AS duplicate_key_count,
    CASE WHEN (SELECT COUNT(*) FROM duplicate_keys) = 0 THEN 'PASS' ELSE 'REVIEW' END AS status,
    'Duplicate order IDs indicate the proposed output may not match the expected grain.' AS review_message;
