-- Day 039: Integrated Transaction Workflow
-- Purpose: Combine read-only transaction planning and validation evidence.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Transaction and write syntax appears only in conceptual comments.
-- Target population: accounts 101 and 202; orders O2001 and O2002.
-- Expected affected rows: 2 accounts and 2 orders.

-- Step 1: pre-change target counts.
SELECT
    'account_targets' AS check_name,
    COUNT(*) AS actual_count,
    2 AS expected_count,
    CASE
        WHEN COUNT(*) = 2 THEN 'PASS'
        ELSE 'REVIEW'
    END AS validation_status
FROM account_balances_before
WHERE account_id IN (101, 202)

UNION ALL

SELECT
    'order_targets' AS check_name,
    COUNT(*) AS actual_count,
    2 AS expected_count,
    CASE
        WHEN COUNT(*) = 2 THEN 'PASS'
        ELSE 'REVIEW'
    END AS validation_status
FROM order_status_before
WHERE order_id IN ('O2001', 'O2002');

-- Step 2: account before-versus-expected-after comparison.
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

-- Step 3: control-total preservation.
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
    a.total_balance - b.total_balance AS difference,
    CASE
        WHEN a.total_balance = b.total_balance THEN 'PASS'
        ELSE 'ROLLBACK_REVIEW'
    END AS validation_status
FROM before_total AS b
CROSS JOIN after_total AS a;

-- Step 4: order status and review flag expected state.
SELECT
    b.order_id,
    b.order_status AS before_status,
    a.order_status AS expected_after_status,
    b.review_flag AS before_review_flag,
    a.review_flag AS expected_after_review_flag,
    CASE
        WHEN a.order_status = 'COMPLETED'
          AND a.review_flag = 'No'
        THEN 'PASS'
        ELSE 'ROLLBACK_REVIEW'
    END AS validation_status
FROM order_status_before AS b
JOIN order_status_expected_after AS a
    ON b.order_id = a.order_id
WHERE b.order_id IN ('O2001', 'O2002')
ORDER BY b.order_id;

-- CONCEPTUAL ONLY - DO NOT RUN
-- Validate starting state with SELECT.
-- BEGIN TRANSACTION;
-- Perform only the approved related changes.
-- Validate resulting state with SELECT.
-- COMMIT only if validation passes.
-- ROLLBACK if validation fails.

