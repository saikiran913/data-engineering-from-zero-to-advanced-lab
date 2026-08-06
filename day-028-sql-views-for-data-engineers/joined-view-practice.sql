-- Day 028: Joined View Practice
-- Purpose: Create views based on joins while documenting grain and row-multiplication risk.
-- Safety: This file contains example view definitions only and does not deploy objects automatically.
-- Check existing object names before executing CREATE VIEW.

-- Order-customer details view.
-- Join key: customer_id. Join type: INNER JOIN.
-- Expected grain: one row per valid order version, assuming one matching customer version.
-- Risk: duplicate customer versions can multiply order rows.
CREATE VIEW vw_order_customer_details AS
SELECT
    o.order_id,
    o.order_date,
    o.order_status,
    o.order_amount,
    c.customer_id,
    c.customer_name,
    c.country,
    o.updated_at AS order_updated_at,
    o.source_file AS order_source_file
FROM raw_orders AS o
INNER JOIN raw_customers AS c
    ON o.customer_id = c.customer_id
WHERE o.customer_id IS NOT NULL
  AND o.order_amount > 0;

SELECT order_id, COUNT(*) AS rows_per_order
FROM vw_order_customer_details
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Order-payment details view.
-- Expected grain: one row per payment attempt joined to an order.
-- Multiple payment attempts are expected and should be documented.
CREATE VIEW vw_order_payment_attempt_details AS
SELECT
    o.order_id,
    o.customer_id,
    o.order_date,
    o.order_amount,
    p.payment_id,
    p.payment_status,
    p.payment_amount,
    p.payment_date,
    p.updated_at AS payment_updated_at
FROM raw_orders AS o
INNER JOIN raw_payments AS p
    ON o.order_id = p.order_id;

SELECT order_id, COUNT(*) AS payment_attempt_rows
FROM vw_order_payment_attempt_details
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Customer-order summary interface.
CREATE VIEW vw_customer_order_summary_interface AS
WITH valid_orders AS (
    SELECT
        customer_id,
        COUNT(*) AS valid_order_count,
        SUM(order_amount) AS valid_order_amount
    FROM raw_orders
    WHERE customer_id IS NOT NULL
      AND order_amount > 0
      AND order_status = 'COMPLETED'
    GROUP BY customer_id
)
SELECT
    c.customer_id,
    c.customer_name,
    c.country,
    v.valid_order_count,
    v.valid_order_amount,
    c.updated_at AS customer_updated_at
FROM raw_customers AS c
INNER JOIN valid_orders AS v
    ON c.customer_id = v.customer_id
WHERE c.customer_status = 'ACTIVE';

SELECT SUM(valid_order_amount) AS interface_total_amount
FROM vw_customer_order_summary_interface;

-- Campaign reporting enrichment using only existing source columns.
CREATE VIEW vw_campaign_reporting_enriched AS
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
        WHEN channel IN ('Search', 'Social', 'Display') THEN 'KNOWN_CHANNEL'
        ELSE 'REVIEW_CHANNEL'
    END AS channel_review_status,
    loaded_at,
    source_file
FROM campaign_daily_metrics;

-- Unmatched-record review view.
CREATE VIEW vw_unmatched_record_review AS
SELECT
    'ORDER_WITHOUT_CUSTOMER' AS issue_type,
    o.order_id AS entity_key,
    o.customer_id AS related_key,
    o.updated_at AS audit_timestamp
FROM raw_orders AS o
LEFT JOIN raw_customers AS c
    ON o.customer_id = c.customer_id
WHERE o.customer_id IS NOT NULL
  AND c.customer_id IS NULL

UNION ALL

SELECT
    'PAYMENT_WITHOUT_ORDER' AS issue_type,
    p.payment_id AS entity_key,
    p.order_id AS related_key,
    p.updated_at AS audit_timestamp
FROM raw_payments AS p
LEFT JOIN raw_orders AS o
    ON p.order_id = o.order_id
WHERE o.order_id IS NULL;

SELECT issue_type, COUNT(*) AS issue_count
FROM vw_unmatched_record_review
GROUP BY issue_type;
