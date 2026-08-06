-- Day 029: Change-Safe View Patterns
-- Purpose: Practise safer patterns before changing a shared view interface.
-- Safety: Read-only examples only. No production view is deployed or replaced.

-- Pattern 1: Explicit column list.
WITH proposed_view_logic AS (
    SELECT
        order_id,
        customer_id,
        order_date,
        order_status,
        order_amount,
        updated_at
    FROM orders_source
)
SELECT COUNT(*) AS proposed_row_count
FROM proposed_view_logic;

-- Pattern 2: Stable aliases.
SELECT
    order_id,
    order_amount AS completed_order_amount
FROM orders_source
WHERE order_status = 'COMPLETED'
  AND order_amount > 0;

-- Pattern 3: Documented grain.
SELECT
    'vw_valid_orders' AS view_name,
    'one row per order_id after validation' AS documented_grain,
    'order_id' AS business_key;

-- Pattern 4: Consumer inventory.
SELECT
    view_name,
    consumer_name,
    change_sensitivity,
    owner_role
FROM view_consumers
ORDER BY view_name, change_sensitivity;

-- Pattern 5: Old/new CTE comparison.
WITH old_logic AS (
    SELECT order_id, order_amount
    FROM orders_source
    WHERE order_status = 'COMPLETED'
),
new_logic AS (
    SELECT order_id, order_amount
    FROM orders_source
    WHERE order_status IN ('COMPLETED', 'REFUNDED')
)
SELECT
    (SELECT COUNT(*) FROM old_logic) AS old_row_count,
    (SELECT COUNT(*) FROM new_logic) AS new_row_count,
    'Compare row counts before changing filter rules.' AS validation_step;

-- Pattern 6: Separate clean and exception outputs.
SELECT
    order_id,
    customer_id,
    order_amount,
    'CLEAN_ORDER_CANDIDATE' AS output_type
FROM orders_source
WHERE customer_id IS NOT NULL
  AND order_amount > 0
UNION ALL
SELECT
    order_id,
    customer_id,
    order_amount,
    'ORDER_REVIEW_CANDIDATE' AS output_type
FROM orders_source
WHERE customer_id IS NULL
   OR order_amount <= 0;

-- Pattern 7: Aggregate before join.
WITH order_totals AS (
    SELECT customer_id, SUM(order_amount) AS completed_order_amount
    FROM orders_source
    WHERE order_status = 'COMPLETED'
      AND order_amount > 0
    GROUP BY customer_id
)
SELECT
    c.customer_id,
    c.customer_name,
    order_totals.completed_order_amount
FROM customers_source AS c
INNER JOIN order_totals
    ON c.customer_id = order_totals.customer_id;

-- Pattern 8: Preserve audit columns.
SELECT
    order_id,
    customer_id,
    order_status,
    order_amount,
    updated_at
FROM orders_source;

-- Pattern 9: Additive change with consumer review.
SELECT
    consumer_name,
    view_name,
    'ADD_UPDATED_AT_COLUMN' AS proposed_change,
    change_sensitivity,
    'Review fixed schemas before adding the audit column.' AS validation_step
FROM view_consumers
WHERE view_name = 'vw_valid_orders';

-- Pattern 10: Change log entry using documented cases.
SELECT
    case_id,
    view_name,
    change_type,
    proposed_change_summary,
    required_validation
FROM view_change_cases
ORDER BY case_id;

-- Pattern 11: Representative sample checks.
SELECT
    order_id,
    customer_id,
    order_status,
    order_amount,
    updated_at
FROM orders_source
ORDER BY order_id, updated_at
LIMIT 10;

-- Pattern 12: Post-change validation checklist concept.
SELECT
    'ROW_COUNT' AS check_name,
    'Compare old and new row counts.' AS validation_step
UNION ALL
SELECT 'KEY_UNIQUENESS', 'Check expected business keys.'
UNION ALL
SELECT 'TOTAL_RECONCILIATION', 'Compare important totals.'
UNION ALL
SELECT 'CONSUMER_REVIEW', 'Review high-sensitivity consumers.';
