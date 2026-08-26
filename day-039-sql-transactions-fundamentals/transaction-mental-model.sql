-- Day 039: Transaction Mental Model
-- Purpose: Understand transaction thinking with read-only before/after comparisons.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Write and transaction syntax appears only in commented conceptual examples.
-- Target population: accounts 101 and 202 for a conceptual transfer.
-- Expected affected rows: 2 accounts.

-- Query 1: inspect the target accounts before the conceptual change.
SELECT
    account_id,
    account_name,
    balance_amount,
    account_status,
    last_updated
FROM account_balances_before
WHERE account_id IN (101, 202)
ORDER BY account_id;

-- Query 2: inspect the expected target accounts after the conceptual change.
SELECT
    account_id,
    account_name,
    balance_amount,
    account_status,
    last_updated
FROM account_balances_expected_after
WHERE account_id IN (101, 202)
ORDER BY account_id;

-- Query 3: compare before and expected-after target balances.
SELECT
    b.account_id,
    b.balance_amount AS before_balance,
    a.balance_amount AS expected_after_balance,
    a.balance_amount - b.balance_amount AS expected_change
FROM account_balances_before AS b
JOIN account_balances_expected_after AS a
    ON b.account_id = a.account_id
WHERE b.account_id IN (101, 202)
ORDER BY b.account_id;

-- CONCEPTUAL ONLY - DO NOT RUN
-- Validate target rows.
-- Begin a transaction.
-- Change source account and target account.
-- Validate after-state evidence.
-- Commit only if validation passes.
-- Rollback if validation fails.

