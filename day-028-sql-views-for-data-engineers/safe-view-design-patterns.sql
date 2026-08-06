-- Day 028: Safe View Design Patterns
-- Purpose: Show safer beginner patterns for reusable view definitions.
-- Safety: This file contains example view definitions only and does not deploy objects automatically.
-- Check existing object names before executing CREATE VIEW.

-- Pattern 1: Explicit column selection.
CREATE VIEW vw_pattern_explicit_customer_columns AS
SELECT
    customer_id,
    customer_name,
    country,
    customer_status,
    updated_at
FROM raw_customers;

-- Validation: confirm row count.
SELECT COUNT(*) AS row_count
FROM vw_pattern_explicit_customer_columns;

-- Pattern 2: Stable aliases.
CREATE VIEW vw_pattern_order_status_aliases AS
SELECT
    order_id,
    order_status AS source_order_status,
    CASE
        WHEN order_status = 'REFUND_REQUESTED' THEN 'REFUND_REVIEW'
        ELSE order_status
    END AS reporting_order_status
FROM raw_orders;

-- Pattern 3: Documented grain.
-- Output grain: one row per payment attempt.
CREATE VIEW vw_pattern_payment_attempts AS
SELECT
    payment_id,
    order_id,
    payment_status,
    payment_amount,
    updated_at
FROM raw_payments;

-- Pattern 4: Separate clean view and review view.
CREATE VIEW vw_pattern_clean_orders AS
SELECT
    order_id,
    customer_id,
    order_date,
    order_amount
FROM raw_orders
WHERE customer_id IS NOT NULL
  AND order_amount > 0;

CREATE VIEW vw_pattern_order_review AS
SELECT
    order_id,
    customer_id,
    order_amount,
    'ORDER_REVIEW' AS review_reason
FROM raw_orders
WHERE customer_id IS NULL
   OR order_amount <= 0;

-- Pattern 5: Aggregate before joining.
CREATE VIEW vw_pattern_customer_totals_before_join AS
WITH order_totals AS (
    SELECT
        customer_id,
        SUM(order_amount) AS completed_order_amount
    FROM raw_orders
    WHERE customer_id IS NOT NULL
      AND order_status = 'COMPLETED'
      AND order_amount > 0
    GROUP BY customer_id
)
SELECT
    c.customer_id,
    c.customer_name,
    order_totals.completed_order_amount
FROM raw_customers AS c
INNER JOIN order_totals
    ON c.customer_id = order_totals.customer_id;

-- Pattern 6: Deduplicate before exposing current-state data.
CREATE VIEW vw_pattern_current_orders AS
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

-- Pattern 7: Preserve audit columns.
CREATE VIEW vw_pattern_orders_with_audit AS
SELECT
    order_id,
    customer_id,
    order_date,
    order_amount,
    updated_at,
    source_file
FROM raw_orders;

-- Pattern 8: Exclude unnecessary sensitive columns.
CREATE VIEW vw_pattern_restricted_customers AS
SELECT
    customer_id,
    customer_name,
    country,
    customer_status
FROM raw_customers;

-- Pattern 9: Clear status standardisation.
CREATE VIEW vw_pattern_standard_order_status AS
SELECT
    order_id,
    CASE
        WHEN order_status IN ('COMPLETED', 'PENDING', 'CANCELLED', 'REFUNDED') THEN order_status
        WHEN order_status = 'REFUND_REQUESTED' THEN 'REFUND_REVIEW'
        ELSE 'STATUS_REVIEW'
    END AS standard_order_status
FROM raw_orders;

-- Pattern 10: Validate before creation.
SELECT order_id, COUNT(*) AS version_count
FROM raw_orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Pattern 11: Query the view with an outer ORDER BY.
SELECT
    order_id,
    customer_id,
    order_date
FROM vw_pattern_current_orders
ORDER BY order_date, order_id;

-- Pattern 12: Avoid deep nested views.
-- Prefer documenting dependencies and keeping view chains shallow.
SELECT
    view_name,
    source_objects,
    dependency_risk
FROM view_definition_examples
WHERE dependency_risk IS NOT NULL;
