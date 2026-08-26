-- Day 039: Post-Change Validation
-- Purpose: Compare before and expected-after snapshots after a conceptual change.
-- Safety: All executable SQL is read-only and SELECT-based.
-- These queries validate expected results only; they do not commit or rollback.
-- Target population: accounts 101 and 202; orders O2001 and O2002.
-- Expected affected rows: 2 accounts and 2 orders.

-- Query 1: before and expected-after total balance comparison.
WITH before_total AS (
    SELECT SUM(balance_amount) AS total_balance
    FROM account_balances_before
),
after_total AS (
    SELECT SUM(balance_amount) AS total_balance
    FROM account_balances_expected_after
)
SELECT
    b.total_balance AS before_total,
    a.total_balance AS expected_after_total,
    a.total_balance - b.total_balance AS difference
FROM before_total AS b
CROSS JOIN after_total AS a;

-- Query 2: accounts expected to change.
SELECT
    b.account_id,
    b.balance_amount AS before_balance,
    a.balance_amount AS expected_after_balance,
    a.balance_amount - b.balance_amount AS expected_change
FROM account_balances_before AS b
JOIN account_balances_expected_after AS a
    ON b.account_id = a.account_id
WHERE b.balance_amount <> a.balance_amount
ORDER BY b.account_id;

-- Query 3: unrelated account balance differences should return no rows.
SELECT
    b.account_id,
    b.balance_amount AS before_balance,
    a.balance_amount AS expected_after_balance
FROM account_balances_before AS b
JOIN account_balances_expected_after AS a
    ON b.account_id = a.account_id
WHERE b.account_id NOT IN (101, 202)
  AND b.balance_amount <> a.balance_amount;

-- Query 4: expected order status and review-flag changes.
SELECT
    b.order_id,
    b.order_status AS before_status,
    a.order_status AS expected_after_status,
    b.review_flag AS before_review_flag,
    a.review_flag AS expected_after_review_flag
FROM order_status_before AS b
JOIN order_status_expected_after AS a
    ON b.order_id = a.order_id
WHERE b.order_id IN ('O2001', 'O2002')
ORDER BY b.order_id;

