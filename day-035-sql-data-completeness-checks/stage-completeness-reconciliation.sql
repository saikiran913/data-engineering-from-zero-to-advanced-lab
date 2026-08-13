-- Day 035: Stage Completeness Reconciliation
-- Purpose: Compare completeness between source, stage, clean, and reporting.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Completeness queries do not modify or fabricate data.

-- Query 1: source-to-stage key coverage.
WITH source_keys AS (
    SELECT DISTINCT order_id
    FROM source_customer_orders
    WHERE order_id IS NOT NULL
),
stage_keys AS (
    SELECT DISTINCT order_id
    FROM staged_customer_orders
    WHERE order_id IS NOT NULL
)
SELECT
    (SELECT COUNT(*) FROM source_keys) AS source_key_count,
    (SELECT COUNT(*) FROM stage_keys) AS stage_key_count,
    (SELECT COUNT(*) FROM source_keys)
        - (SELECT COUNT(*) FROM stage_keys) AS key_count_difference;

-- Query 2: accepted stage to clean coverage.
WITH accepted_orders AS (
    SELECT DISTINCT order_id
    FROM staged_customer_orders
    WHERE validation_status = 'ACCEPTED'
),
clean_orders AS (
    SELECT DISTINCT order_id
    FROM clean_customer_orders
)
SELECT
    a.order_id AS accepted_order_id
FROM accepted_orders AS a
LEFT JOIN clean_orders AS c
    ON a.order_id = c.order_id
WHERE c.order_id IS NULL
ORDER BY
    a.order_id;

-- Query 3: clean to reporting date coverage.
SELECT
    c.order_date,
    c.country_group
FROM clean_customer_orders AS c
LEFT JOIN reporting_customer_orders AS r
    ON c.order_date = r.report_date
   AND c.country_group = r.country_group
WHERE r.report_date IS NULL
GROUP BY
    c.order_date,
    c.country_group
ORDER BY
    c.order_date,
    c.country_group;

-- Query 4: accepted and review row counts.
SELECT
    COUNT(*) AS staged_count,
    SUM(CASE WHEN validation_status = 'ACCEPTED' THEN 1 ELSE 0 END) AS accepted_count,
    SUM(CASE WHEN validation_status = 'REVIEW' THEN 1 ELSE 0 END) AS review_count
FROM staged_customer_orders;
