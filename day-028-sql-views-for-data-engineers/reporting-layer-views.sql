-- Day 028: Reporting Layer Views
-- Purpose: Show clean interfaces for report consumers.
-- Safety: This file contains example view definitions only and does not deploy objects automatically.
-- Check existing object names before executing CREATE VIEW.

-- Customer reporting view.
-- Consumer: analyst or report user. Output grain: one row per customer version.
CREATE VIEW vw_customer_reporting AS
SELECT
    customer_id,
    customer_name,
    country,
    customer_status AS status,
    signup_date
FROM raw_customers;

-- Order reporting view.
CREATE VIEW vw_order_reporting AS
SELECT
    order_id,
    customer_id,
    order_date,
    CASE
        WHEN order_status = 'REFUND_REQUESTED' THEN 'REFUND_REVIEW'
        ELSE order_status
    END AS business_order_status,
    order_amount,
    updated_at AS order_updated_at
FROM raw_orders
WHERE customer_id IS NOT NULL;

-- Customer sales summary view.
CREATE VIEW vw_reporting_customer_sales_summary AS
SELECT
    customer_id,
    COUNT(*) AS completed_order_count,
    SUM(order_amount) AS completed_order_amount
FROM raw_orders
WHERE customer_id IS NOT NULL
  AND order_status = 'COMPLETED'
  AND order_amount > 0
GROUP BY customer_id;

-- Campaign daily reporting view.
CREATE VIEW vw_reporting_campaign_daily AS
SELECT
    campaign_id,
    metric_date,
    channel,
    country,
    impressions,
    clicks,
    conversions,
    spend,
    loaded_at
FROM campaign_daily_metrics
WHERE spend IS NOT NULL;

-- Campaign performance review view.
CREATE VIEW vw_campaign_performance_review AS
SELECT
    campaign_id,
    metric_date,
    channel,
    country,
    impressions,
    clicks,
    conversions,
    spend,
    CASE
        WHEN spend IS NULL THEN 'REVIEW_NULL_SPEND'
        WHEN impressions = 0 THEN 'REVIEW_ZERO_IMPRESSIONS'
        WHEN conversions = 0 THEN 'INFO_ZERO_CONVERSIONS'
        ELSE 'OK'
    END AS review_status,
    loaded_at,
    source_file
FROM campaign_daily_metrics;

-- Payment exception view.
CREATE VIEW vw_payment_exception AS
SELECT
    payment_id,
    order_id,
    payment_status,
    payment_amount,
    payment_date,
    CASE
        WHEN payment_amount IS NULL THEN 'REVIEW_NULL_PAYMENT_AMOUNT'
        WHEN payment_status IN ('FAILED', 'PENDING', 'REFUNDED') THEN 'REVIEW_PAYMENT_STATUS'
        ELSE 'OK'
    END AS payment_review_status,
    updated_at,
    source_file
FROM raw_payments
WHERE payment_amount IS NULL
   OR payment_status IN ('FAILED', 'PENDING', 'REFUNDED');

-- Validation checks for reporting views.
SELECT COUNT(*) AS customer_reporting_rows
FROM vw_customer_reporting;

SELECT SUM(completed_order_amount) AS reporting_sales_total
FROM vw_reporting_customer_sales_summary;
