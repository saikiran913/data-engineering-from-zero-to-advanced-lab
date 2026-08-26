-- Day 038: Composite-Key-Like Validation
-- Purpose: Show how multiple columns can define a row grain.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Constraint validation only reports issues; it does not define or change constraints.
-- Table grain: examples use available tables and conceptual multi-column keys.
-- Candidate keys: payment_id, order_id plus payment_date conceptually.

-- Query 1: duplicate payment rows by payment_id and order_id.
SELECT
    payment_id,
    order_id,
    COUNT(*) AS row_count
FROM payments
WHERE payment_id IS NOT NULL
  AND order_id IS NOT NULL
GROUP BY payment_id, order_id
HAVING COUNT(*) > 1;

-- Query 2: duplicate order rows by order_id and customer_id.
SELECT
    order_id,
    customer_id,
    COUNT(*) AS row_count
FROM orders
WHERE order_id IS NOT NULL
  AND customer_id IS NOT NULL
GROUP BY order_id, customer_id
HAVING COUNT(*) > 1;

-- Query 3: reporting-style composite grain example using order_date and order_status.
SELECT
    order_date,
    order_status,
    COUNT(*) AS row_count,
    SUM(order_amount) AS total_order_amount
FROM orders
WHERE order_date IS NOT NULL
GROUP BY order_date, order_status
ORDER BY order_date, order_status;

-- Query 4: conceptual composite-key rule catalog rows.
SELECT
    rule_id,
    table_name,
    constraint_concept,
    column_or_columns,
    expected_condition,
    review_message
FROM constraint_rules
WHERE constraint_concept = 'COMPOSITE_KEY';

