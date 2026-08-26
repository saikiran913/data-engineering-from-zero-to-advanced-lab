-- Day 039: Atomicity Examples
-- Purpose: Show all-or-nothing thinking using read-only comparisons.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Write and transaction syntax appears only in commented conceptual examples.
-- Target population: account transfer and order status review examples.
-- Expected affected rows: 2 accounts and 2 orders.

-- Query 1: account transfer expected changes.
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

-- Query 2: the total balance should be preserved.
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

-- Query 3: order status and review flag should change together.
SELECT
    b.order_id,
    b.order_status AS before_status,
    a.order_status AS expected_after_status,
    b.review_flag AS before_review_flag,
    a.review_flag AS expected_after_review_flag
FROM order_status_before AS b
JOIN order_status_expected_after AS a
    ON b.order_id = a.order_id
WHERE b.order_status <> a.order_status
   OR b.review_flag <> a.review_flag
ORDER BY b.order_id;

-- CONCEPTUAL ONLY - DO NOT RUN
-- BEGIN TRANSACTION;
-- UPDATE account_balances SET balance_amount = balance_amount - 250 WHERE account_id = 101;
-- UPDATE account_balances SET balance_amount = balance_amount + 250 WHERE account_id = 202;
-- Run post-change SELECT validation here.
-- COMMIT or ROLLBACK based on validation evidence.

