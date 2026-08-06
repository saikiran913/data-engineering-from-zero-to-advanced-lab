-- Day 028: Simple View Practice
-- Purpose: Create beginner-friendly single-source view examples.
-- Safety: This file contains example view definitions only and does not deploy objects automatically.
-- Check existing object names before executing CREATE VIEW.

-- Active customers view.
-- Source grain: one row per customer version.
-- Output grain: one row per active customer version.
-- Excluded columns: email_address.
CREATE VIEW vw_active_customers AS
SELECT
    customer_id,
    customer_name,
    country,
    customer_status,
    signup_date,
    updated_at,
    source_file
FROM raw_customers
WHERE customer_status = 'ACTIVE';

SELECT COUNT(*) AS active_customer_view_rows
FROM vw_active_customers;

-- Valid orders view.
-- Rules: customer_id is present, amount is positive, and status is accepted for reporting.
-- Excluded rows are review candidates, not rows to remove from the source.
CREATE VIEW vw_valid_orders AS
SELECT
    order_id,
    customer_id,
    order_date,
    order_status,
    order_amount,
    updated_at,
    source_file
FROM raw_orders
WHERE customer_id IS NOT NULL
  AND order_amount > 0
  AND order_status IN ('COMPLETED', 'PENDING', 'REFUNDED');

SELECT SUM(order_amount) AS valid_order_amount_total
FROM vw_valid_orders;

-- Successful payments view.
-- Output grain: one row per successful payment attempt.
CREATE VIEW vw_successful_payments AS
SELECT
    payment_id,
    order_id,
    payment_status,
    payment_amount,
    payment_date,
    updated_at,
    source_file
FROM raw_payments
WHERE payment_status = 'SUCCESS'
  AND payment_amount IS NOT NULL;

SELECT COUNT(*) AS successful_payment_rows
FROM vw_successful_payments;

-- Active products view.
-- Output grain: one row per active product.
CREATE VIEW vw_active_products AS
SELECT
    product_id,
    product_name,
    category,
    unit_price,
    product_status,
    updated_at
FROM product_catalog
WHERE product_status = 'ACTIVE';

SELECT product_id, product_name, category, unit_price
FROM vw_active_products
ORDER BY product_id;

-- Campaign valid-metrics view.
-- Rules: spend is present, impressions are non-negative, and conversions are non-negative.
CREATE VIEW vw_campaign_valid_metrics AS
SELECT
    campaign_id,
    metric_date,
    channel,
    country,
    impressions,
    clicks,
    conversions,
    spend,
    loaded_at,
    source_file
FROM campaign_daily_metrics
WHERE spend IS NOT NULL
  AND impressions >= 0
  AND conversions >= 0;

SELECT COUNT(*) AS valid_campaign_metric_rows
FROM vw_campaign_valid_metrics;

-- Data-quality review view.
-- Purpose: expose suspicious rows for investigation instead of hiding them.
CREATE VIEW vw_source_quality_review AS
SELECT
    'raw_customers' AS dataset_name,
    customer_id AS entity_key,
    'MISSING_COUNTRY_OR_EMAIL' AS issue_type,
    updated_at AS audit_timestamp,
    source_file
FROM raw_customers
WHERE country IS NULL
   OR email_address IS NULL

UNION ALL

SELECT
    'raw_orders' AS dataset_name,
    order_id AS entity_key,
    'INVALID_ORDER_FOR_REPORTING' AS issue_type,
    updated_at AS audit_timestamp,
    source_file
FROM raw_orders
WHERE customer_id IS NULL
   OR order_amount <= 0;

SELECT dataset_name, entity_key, issue_type
FROM vw_source_quality_review
ORDER BY dataset_name, entity_key;
