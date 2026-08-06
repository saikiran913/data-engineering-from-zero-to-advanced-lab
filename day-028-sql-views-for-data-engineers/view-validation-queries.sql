-- Day 028: View Validation Queries
-- Purpose: Validate row counts, uniqueness, nulls, totals, joins, dependencies, and review summaries.
-- Safety: This file contains read-only validation examples and does not deploy objects automatically.

-- Validation 1: Source-query row count versus view row count.
SELECT COUNT(*) AS source_active_customer_rows
FROM raw_customers
WHERE customer_status = 'ACTIVE';

SELECT COUNT(*) AS view_active_customer_rows
FROM vw_active_customers;

-- Validation 2: Expected key uniqueness.
SELECT customer_id, COUNT(*) AS row_count
FROM vw_latest_customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Validation 3: Duplicate-key detection in raw orders.
SELECT order_id, COUNT(*) AS raw_order_version_count
FROM raw_orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Validation 4: Null critical columns.
SELECT customer_id, country, email_address
FROM raw_customers
WHERE country IS NULL
   OR email_address IS NULL;

-- Validation 5: Total reconciliation.
SELECT SUM(order_amount) AS source_completed_order_amount
FROM raw_orders
WHERE customer_id IS NOT NULL
  AND order_amount > 0
  AND order_status = 'COMPLETED';

SELECT SUM(completed_order_amount) AS view_completed_order_amount
FROM vw_customer_order_summary;

-- Validation 6: Filtered-row reconciliation.
SELECT
    COUNT(*) AS accepted_order_rows
FROM raw_orders
WHERE customer_id IS NOT NULL
  AND order_amount > 0
  AND order_status IN ('COMPLETED', 'PENDING', 'REFUNDED');

SELECT
    COUNT(*) AS review_order_rows
FROM raw_orders
WHERE customer_id IS NULL
   OR order_amount <= 0;

-- Validation 7: Join row-multiplication check.
SELECT order_id, COUNT(*) AS joined_rows
FROM vw_order_customer_details
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Validation 8: Derived-column validation.
SELECT
    order_id,
    order_status,
    CASE
        WHEN order_status = 'REFUND_REQUESTED' THEN 'REFUND_REVIEW'
        ELSE order_status
    END AS expected_business_order_status
FROM raw_orders;

-- Validation 9: Column exposure review.
-- Metadata inspection varies by platform. Manually confirm that public customer views exclude email_address.

-- Validation 10: Boundary-date validation.
SELECT
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS latest_order_date
FROM vw_valid_orders;

-- Validation 11: Dependency availability checklist.
SELECT
    view_name,
    source_objects,
    output_grain,
    dependency_risk
FROM view_definition_examples
ORDER BY view_name;

-- Validation 12: Combined review summary.
SELECT
    'null_customer_country' AS check_name,
    COUNT(*) AS issue_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'REVIEW' END AS status,
    'Customer country should be reviewed before country-level reporting.' AS review_message
FROM raw_customers
WHERE country IS NULL

UNION ALL

SELECT
    'invalid_order_amount' AS check_name,
    COUNT(*) AS issue_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'REVIEW' END AS status,
    'Zero or negative order amounts should be reviewed.' AS review_message
FROM raw_orders
WHERE order_amount <= 0

UNION ALL

SELECT
    'null_campaign_spend' AS check_name,
    COUNT(*) AS issue_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'REVIEW' END AS status,
    'Null campaign spend affects spend reporting.' AS review_message
FROM campaign_daily_metrics
WHERE spend IS NULL;
