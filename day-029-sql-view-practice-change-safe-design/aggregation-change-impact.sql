-- Day 029: Aggregation Change Impact
-- Purpose: Review how aggregation changes affect grain, totals, and business meaning.
-- Safety: Read-only examples only. No production view is deployed or replaced.

-- One row per order versus one row per customer.
WITH order_grain AS (
    SELECT order_id, customer_id, order_amount
    FROM orders_source
    WHERE order_status = 'COMPLETED'
      AND order_amount > 0
),
customer_grain AS (
    SELECT customer_id, SUM(order_amount) AS customer_order_amount
    FROM orders_source
    WHERE order_status = 'COMPLETED'
      AND order_amount > 0
    GROUP BY customer_id
)
SELECT
    'ORDER_TO_CUSTOMER_GRAIN' AS check_name,
    (SELECT COUNT(*) FROM order_grain) AS old_row_count,
    (SELECT COUNT(*) FROM customer_grain) AS new_row_count,
    (SELECT SUM(order_amount) FROM order_grain) AS old_total,
    (SELECT SUM(customer_order_amount) FROM customer_grain) AS new_total;

-- Daily campaign summary versus monthly-style summary.
WITH daily_summary AS (
    SELECT campaign_id, metric_date, channel, country, SUM(spend) AS spend
    FROM campaign_metrics_source
    WHERE spend IS NOT NULL
    GROUP BY campaign_id, metric_date, channel, country
),
monthly_style_summary AS (
    SELECT campaign_id, channel, country, SUM(spend) AS spend
    FROM campaign_metrics_source
    WHERE spend IS NOT NULL
    GROUP BY campaign_id, channel, country
)
SELECT
    'DAILY_TO_MONTHLY_STYLE_GRAIN' AS check_name,
    (SELECT COUNT(*) FROM daily_summary) AS old_row_count,
    (SELECT COUNT(*) FROM monthly_style_summary) AS new_row_count,
    (SELECT SUM(spend) FROM daily_summary) AS old_total,
    (SELECT SUM(spend) FROM monthly_style_summary) AS new_total;

-- Total amount versus average amount.
SELECT
    customer_id,
    SUM(order_amount) AS total_completed_amount,
    AVG(order_amount) AS average_completed_amount
FROM orders_source
WHERE order_status = 'COMPLETED'
  AND order_amount > 0
GROUP BY customer_id
ORDER BY customer_id;

-- Counting rows versus counting distinct orders.
SELECT
    COUNT(*) AS row_count,
    COUNT(DISTINCT order_id) AS distinct_order_count
FROM orders_source
WHERE order_status = 'COMPLETED'
  AND order_amount > 0;

-- Including cancelled orders in totals.
WITH old_logic AS (
    SELECT order_amount
    FROM orders_source
    WHERE order_status = 'COMPLETED'
      AND order_amount > 0
),
new_logic AS (
    SELECT order_amount
    FROM orders_source
    WHERE order_status IN ('COMPLETED', 'CANCELLED')
      AND order_amount > 0
)
SELECT
    'CANCELLED_IN_TOTALS' AS check_name,
    (SELECT SUM(order_amount) FROM old_logic) AS old_total,
    (SELECT SUM(order_amount) FROM new_logic) AS new_total,
    'Review whether cancelled orders belong in reporting totals.' AS review_message;

-- Null-handling change in aggregation.
SELECT
    country,
    COUNT(*) AS customer_rows
FROM customers_source
GROUP BY country
UNION ALL
SELECT
    CASE WHEN country IS NULL THEN 'UNKNOWN' ELSE country END AS country,
    COUNT(*)
FROM customers_source
GROUP BY CASE WHEN country IS NULL THEN 'UNKNOWN' ELSE country END;

-- Grouping-column removal and addition.
SELECT
    channel,
    country,
    SUM(spend) AS channel_country_spend
FROM campaign_metrics_source
WHERE spend IS NOT NULL
GROUP BY channel, country;

SELECT
    channel,
    country,
    campaign_id,
    SUM(spend) AS campaign_channel_country_spend
FROM campaign_metrics_source
WHERE spend IS NOT NULL
GROUP BY channel, country, campaign_id;

-- Aggregation-impact summary.
WITH old_logic AS (
    SELECT order_id, order_amount
    FROM orders_source
    WHERE order_status = 'COMPLETED'
      AND order_amount > 0
),
new_logic AS (
    SELECT customer_id, SUM(order_amount) AS order_amount
    FROM orders_source
    WHERE order_status = 'COMPLETED'
      AND order_amount > 0
    GROUP BY customer_id
)
SELECT
    'one row per order' AS old_grain,
    'one row per customer' AS new_grain,
    (SELECT COUNT(*) FROM old_logic) AS old_row_count,
    (SELECT COUNT(*) FROM new_logic) AS new_row_count,
    (SELECT SUM(order_amount) FROM old_logic) AS old_total,
    (SELECT SUM(order_amount) FROM new_logic) AS new_total,
    (SELECT SUM(order_amount) FROM new_logic) - (SELECT SUM(order_amount) FROM old_logic) AS difference,
    'Row count changes are expected when grain changes; totals should reconcile if business rules match.' AS review_message;
