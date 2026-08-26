-- Day 038: Constraint Validation Summary
-- Purpose: Summarise constraint-like validation findings.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Summary queries do not create or change constraints.
-- Grain: one summary row per rule family or table.

-- Query 1: rule catalog by constraint concept.
SELECT
    constraint_concept,
    COUNT(*) AS rule_count
FROM constraint_rules
GROUP BY constraint_concept
ORDER BY constraint_concept;

-- Query 2: rule catalog by severity.
SELECT
    severity,
    COUNT(*) AS rule_count
FROM constraint_rules
GROUP BY severity
ORDER BY severity;

-- Query 3: customer key validation summary.
SELECT
    'customers' AS table_name,
    COUNT(*) AS row_count,
    COUNT(customer_id) AS non_null_key_count,
    COUNT(DISTINCT customer_id) AS distinct_key_count
FROM customers;

-- Query 4: order key validation summary.
SELECT
    'orders' AS table_name,
    COUNT(*) AS row_count,
    COUNT(order_id) AS non_null_key_count,
    COUNT(DISTINCT order_id) AS distinct_key_count
FROM orders;

-- Query 5: payment key validation summary.
SELECT
    'payments' AS table_name,
    COUNT(*) AS row_count,
    COUNT(payment_id) AS non_null_key_count,
    COUNT(DISTINCT payment_id) AS distinct_key_count
FROM payments;

-- Query 6: casebook by concept.
SELECT
    constraint_concept,
    COUNT(*) AS case_count
FROM constraint_casebook
GROUP BY constraint_concept
ORDER BY constraint_concept;

