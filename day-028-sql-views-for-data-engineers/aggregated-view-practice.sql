-- Day 028: Aggregated View Practice
-- Purpose: Create aggregate reporting views and validation queries.
-- Safety: This file contains example view definitions only and does not deploy objects automatically.
-- Check existing object names before executing CREATE VIEW.

-- Customer order summary view.
-- Input grain: one row per order version. Output grain: one row per customer_id.
CREATE VIEW vw_customer_order_summary AS
SELECT
    customer_id,
    COUNT(*) AS completed_order_count,
    SUM(order_amount) AS completed_order_amount,
    MIN(order_date) AS first_completed_order_date,
    MAX(order_date) AS latest_completed_order_date
FROM raw_orders
WHERE customer_id IS NOT NULL
  AND order_amount > 0
  AND order_status = 'COMPLETED'
GROUP BY customer_id;

SELECT SUM(completed_order_amount) AS view_completed_order_amount
FROM vw_customer_order_summary;

-- Country customer summary view.
CREATE VIEW vw_country_customer_summary AS
SELECT
    country,
    COUNT(*) AS customer_version_count,
    MIN(signup_date) AS first_signup_date,
    MAX(updated_at) AS latest_customer_update
FROM raw_customers
WHERE country IS NOT NULL
GROUP BY country;

SELECT country, customer_version_count
FROM vw_country_customer_summary
ORDER BY country;

-- Payment status summary view.
CREATE VIEW vw_payment_status_summary AS
SELECT
    payment_status,
    COUNT(*) AS payment_attempt_count,
    SUM(payment_amount) AS total_payment_amount,
    MIN(payment_date) AS first_payment_date,
    MAX(payment_date) AS latest_payment_date
FROM raw_payments
GROUP BY payment_status;

-- Campaign daily reporting view.
-- Output grain: one row per campaign-date-channel-country.
CREATE VIEW vw_campaign_daily_reporting AS
SELECT
    campaign_id,
    metric_date,
    channel,
    country,
    SUM(impressions) AS impressions,
    SUM(clicks) AS clicks,
    SUM(conversions) AS conversions,
    SUM(spend) AS spend,
    MAX(loaded_at) AS latest_loaded_at
FROM campaign_daily_metrics
WHERE spend IS NOT NULL
GROUP BY campaign_id, metric_date, channel, country;

-- Campaign channel-country summary view.
CREATE VIEW vw_campaign_channel_country_summary AS
SELECT
    channel,
    country,
    COUNT(*) AS delivery_row_count,
    SUM(impressions) AS total_impressions,
    SUM(clicks) AS total_clicks,
    SUM(conversions) AS total_conversions,
    SUM(spend) AS total_spend
FROM campaign_daily_metrics
WHERE spend IS NOT NULL
GROUP BY channel, country;

-- Product category summary view.
CREATE VIEW vw_product_category_summary AS
SELECT
    category,
    COUNT(*) AS product_count,
    AVG(unit_price) AS average_unit_price,
    MIN(unit_price) AS lowest_unit_price,
    MAX(unit_price) AS highest_unit_price
FROM product_catalog
WHERE category IS NOT NULL
GROUP BY category;

-- Validation total for completed orders.
SELECT SUM(order_amount) AS source_completed_amount
FROM raw_orders
WHERE customer_id IS NOT NULL
  AND order_amount > 0
  AND order_status = 'COMPLETED';
