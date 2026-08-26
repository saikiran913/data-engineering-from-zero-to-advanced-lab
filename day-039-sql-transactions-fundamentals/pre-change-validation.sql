-- Day 039: Pre-Change Validation
-- Purpose: Validate target rows and control totals before any conceptual change.
-- Safety: All executable SQL is read-only and SELECT-based.
-- No write or transaction statement is executable in this file.
-- Target population: accounts 101 and 202; orders O2001 and O2002.
-- Expected affected rows: 2 accounts and 2 orders.

-- Query 1: target account row count before the conceptual transfer.
SELECT
    COUNT(*) AS target_account_count
FROM account_balances_before
WHERE account_id IN (101, 202);

-- Query 2: duplicate target account key check.
SELECT
    account_id,
    COUNT(*) AS row_count
FROM account_balances_before
WHERE account_id IN (101, 202)
GROUP BY account_id
HAVING COUNT(*) > 1;

-- Query 3: before-state balance total.
SELECT
    SUM(balance_amount) AS before_total_balance
FROM account_balances_before;

-- Query 4: target order row count before conceptual status change.
SELECT
    COUNT(*) AS target_order_count
FROM order_status_before
WHERE order_id IN ('O2001', 'O2002');

-- Query 5: target order current state.
SELECT
    order_id,
    customer_id,
    order_status,
    review_flag,
    last_updated
FROM order_status_before
WHERE order_id IN ('O2001', 'O2002')
ORDER BY order_id;

