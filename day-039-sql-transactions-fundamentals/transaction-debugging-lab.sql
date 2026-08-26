-- Day 039: Transaction Debugging Lab
-- Purpose: Show risky transaction thinking and safer read-only planning patterns.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Conceptual write and transaction syntax appears only in comments.
-- Target population: educational scenarios from before and expected-after snapshots.
-- Expected affected rows: depends on the planned scenario.

-- Mistake 1: risky because it checks no target row count.
SELECT
    account_id,
    balance_amount
FROM account_balances_before
WHERE account_status = 'ACTIVE';

-- Safer 1: count the exact target keys first.
SELECT
    COUNT(*) AS target_account_count
FROM account_balances_before
WHERE account_id IN (101, 202);

-- Mistake 2: risky because it ignores unchanged rows.
SELECT
    b.account_id,
    a.balance_amount - b.balance_amount AS expected_change
FROM account_balances_before AS b
JOIN account_balances_expected_after AS a
    ON b.account_id = a.account_id
WHERE b.account_id IN (101, 202);

-- Safer 2: confirm unrelated rows did not change.
SELECT
    b.account_id,
    b.balance_amount AS before_balance,
    a.balance_amount AS expected_after_balance
FROM account_balances_before AS b
JOIN account_balances_expected_after AS a
    ON b.account_id = a.account_id
WHERE b.account_id NOT IN (101, 202)
  AND b.balance_amount <> a.balance_amount;

-- Mistake 3: risky because it treats rollback as backup.
SELECT
    'Rollback will fix every mistake' AS unsafe_assumption;

-- Safer 3: document rollback limitation.
SELECT
    'Rollback helps only within supported uncommitted transaction scope' AS safer_assumption,
    'Backups and recovery planning are separate controls' AS recovery_note;

-- CONCEPTUAL ONLY - DO NOT RUN
-- Unsafe learning pattern:
-- UPDATE orders SET order_status = 'COMPLETED';
-- COMMIT;
--
-- Safer thinking:
-- Preview exact target keys.
-- Count expected affected rows.
-- Validate after-state evidence before commit.

