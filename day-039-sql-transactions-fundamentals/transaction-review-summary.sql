-- Day 039: Transaction Review Summary
-- Purpose: Summarise pre-change and post-change validation evidence.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Summary queries do not perform transaction control or data changes.
-- Target population: conceptual balance and order-status changes.
-- Expected affected rows: 2 accounts and 2 orders.

-- Query 1: rules by validation stage.
SELECT
    validation_stage,
    COUNT(*) AS rule_count
FROM transaction_rules
GROUP BY validation_stage
ORDER BY validation_stage;

-- Query 2: rules by severity.
SELECT
    severity,
    COUNT(*) AS rule_count
FROM transaction_rules
GROUP BY severity
ORDER BY severity;

-- Query 3: account snapshot row counts.
SELECT
    'before' AS snapshot_name,
    COUNT(*) AS row_count
FROM account_balances_before

UNION ALL

SELECT
    'expected_after' AS snapshot_name,
    COUNT(*) AS row_count
FROM account_balances_expected_after;

-- Query 4: order snapshot row counts.
SELECT
    'before' AS snapshot_name,
    COUNT(*) AS row_count
FROM order_status_before

UNION ALL

SELECT
    'expected_after' AS snapshot_name,
    COUNT(*) AS row_count
FROM order_status_expected_after;

-- Query 5: transaction scenarios by atomicity need.
SELECT
    atomicity_need,
    COUNT(*) AS scenario_count
FROM transaction_casebook
GROUP BY atomicity_need
ORDER BY atomicity_need;

