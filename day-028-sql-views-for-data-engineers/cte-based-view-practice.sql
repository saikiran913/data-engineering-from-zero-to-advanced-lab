-- Day 028: CTE-Based View Practice
-- Purpose: Use CTEs inside view definitions for readable saved query logic.
-- Safety: This file contains example view definitions only and does not deploy objects automatically.
-- Check existing object names before executing CREATE VIEW.

-- Latest customer version view.
-- Output grain: one row per customer_id.
-- Tie-breaker is an example rule that should be reviewed by the business.
CREATE VIEW vw_latest_customers AS
WITH ranked_customers AS (
    SELECT
        customer_id,
        customer_name,
        country,
        customer_status,
        signup_date,
        email_address,
        updated_at,
        source_file,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY updated_at DESC, source_file DESC
        ) AS row_num
    FROM raw_customers
),
latest_customers AS (
    SELECT
        customer_id,
        customer_name,
        country,
        customer_status,
        signup_date,
        updated_at,
        source_file
    FROM ranked_customers
    WHERE row_num = 1
)
SELECT
    customer_id,
    customer_name,
    country,
    customer_status,
    signup_date,
    updated_at,
    source_file
FROM latest_customers;

SELECT customer_id, COUNT(*) AS row_count
FROM vw_latest_customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Latest valid order view.
CREATE VIEW vw_latest_valid_orders AS
WITH ranked_orders AS (
    SELECT
        order_id,
        customer_id,
        order_date,
        order_status,
        order_amount,
        updated_at,
        source_file,
        ROW_NUMBER() OVER (
            PARTITION BY order_id
            ORDER BY updated_at DESC, source_file DESC
        ) AS row_num
    FROM raw_orders
    WHERE customer_id IS NOT NULL
      AND order_amount > 0
)
SELECT
    order_id,
    customer_id,
    order_date,
    order_status,
    order_amount,
    updated_at,
    source_file
FROM ranked_orders
WHERE row_num = 1;

-- Customer sales reporting view.
CREATE VIEW vw_customer_sales_reporting AS
WITH valid_orders AS (
    SELECT
        order_id,
        customer_id,
        order_date,
        order_amount
    FROM raw_orders
    WHERE customer_id IS NOT NULL
      AND order_amount > 0
      AND order_status = 'COMPLETED'
),
customer_totals AS (
    SELECT
        customer_id,
        COUNT(*) AS completed_order_count,
        SUM(order_amount) AS completed_order_amount
    FROM valid_orders
    GROUP BY customer_id
),
customer_details AS (
    SELECT
        customer_id,
        customer_name,
        country,
        customer_status
    FROM raw_customers
    WHERE customer_status = 'ACTIVE'
)
SELECT
    customer_details.customer_id,
    customer_details.customer_name,
    customer_details.country,
    customer_totals.completed_order_count,
    customer_totals.completed_order_amount
FROM customer_details
INNER JOIN customer_totals
    ON customer_details.customer_id = customer_totals.customer_id;

-- Campaign clean reporting view.
CREATE VIEW vw_campaign_clean_reporting AS
WITH ranked_campaign_deliveries AS (
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
        source_file,
        ROW_NUMBER() OVER (
            PARTITION BY campaign_id, metric_date, channel, country
            ORDER BY loaded_at DESC, source_file DESC
        ) AS row_num
    FROM campaign_daily_metrics
),
latest_delivery AS (
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
    FROM ranked_campaign_deliveries
    WHERE row_num = 1
),
valid_metrics AS (
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
    FROM latest_delivery
    WHERE spend IS NOT NULL
      AND impressions >= 0
      AND conversions >= 0
)
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
FROM valid_metrics;

-- Review queue view using UNION ALL.
CREATE VIEW vw_data_quality_review_queue AS
SELECT
    'raw_customers' AS dataset_name,
    customer_id AS entity_key,
    'CUSTOMER_FIELD_REVIEW' AS issue_type,
    updated_at AS audit_timestamp,
    source_file
FROM raw_customers
WHERE country IS NULL
   OR email_address IS NULL

UNION ALL

SELECT
    'raw_orders' AS dataset_name,
    order_id AS entity_key,
    'ORDER_VALUE_REVIEW' AS issue_type,
    updated_at AS audit_timestamp,
    source_file
FROM raw_orders
WHERE customer_id IS NULL
   OR order_amount <= 0

UNION ALL

SELECT
    'campaign_daily_metrics' AS dataset_name,
    campaign_id AS entity_key,
    'CAMPAIGN_METRIC_REVIEW' AS issue_type,
    loaded_at AS audit_timestamp,
    source_file
FROM campaign_daily_metrics
WHERE spend IS NULL
   OR impressions = 0;
