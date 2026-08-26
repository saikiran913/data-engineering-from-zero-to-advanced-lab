# Day 039 Practice Questions

## Section A: Concept Checks

1. What is a transaction?
2. What does atomicity mean?
3. What does `COMMIT` mean conceptually?
4. What does `ROLLBACK` mean conceptually?
5. What is a transaction boundary?
6. What is autocommit?
7. Why should pre-change validation happen?
8. Why should post-change validation happen before commit?
9. What are expected affected rows?
10. What is a control total?
11. What is a partial change?
12. Why can partial changes be dangerous?
13. Why is rollback not a backup?
14. Why does atomicity not guarantee business correctness?
15. Why should transaction scope stay focused?
16. Why do multi-step related changes often need transaction thinking?
17. What is a failure path?
18. Why do platform differences matter?
19. Why is Day 039 executable SQL read-only?
20. What is a commit condition?
21. What is a rollback condition?
22. Why should write examples remain commented in this repository?

## Section B: Transaction or Not?

Classify each scenario as transaction useful conceptually, single independent change, read-only/no transaction needed, related multi-step change, transaction scope too broad, or requires more business context.

1. Move 250 from Account 101 to Account 202.
2. Change order status and clear the review flag for the same orders.
3. Run a read-only monthly report.
4. Update one independent note field.
5. Change customer status and related audit state.
6. Correct a parent key and matching child references.
7. Change many unrelated reference tables at once.
8. A filter expects one row but matches ten rows.
9. Source account key does not exist.
10. Target account key does not exist.
11. A post-change total does not match the before total.
12. An unrelated row changed unexpectedly.
13. Commit happens before validation.
14. Validation fails before commit.
15. A committed change is later found incorrect.

## Section C: Complete the Validation SQL

1. Check target account keys exist.
2. Count target account rows.
3. Check duplicate account keys in the target population.
4. Capture before total balance.
5. Capture expected after total balance.
6. Compare before and expected after balances for changed accounts.
7. Check unrelated balances are unchanged.
8. Check target orders exist.
9. Compare before and expected after order statuses.
10. Compare before and expected after review flags.
11. Compare before and expected after order row counts.
12. Check total balance preservation.
13. Summarise rules by validation stage.
14. Summarise casebook scenarios by atomicity need.
15. Build rollback-condition summary from transaction rules.

## Section D: Fix the Mistake

1. A transaction plan has no expected affected-row count.
2. A plan uses a broad filter.
3. Writes happen before pre-validation.
4. Commit happens before post-validation.
5. Rollback is treated as a backup.
6. Atomicity is treated as proof of correctness.
7. The transaction includes unrelated changes.
8. No unchanged-row check exists.
9. No control total is captured.
10. No duplicate-key check exists.
11. Autocommit is assumed disabled.
12. Platform transaction syntax is assumed universal.
13. A conceptual write block is not commented.
14. A failure path is not documented.
15. No audit evidence is kept.

## Section E: Design the Transaction Plan

For each scenario, define purpose, target tables, keys, expected rows, pre-checks, conceptual transaction steps, post-checks, commit condition, and rollback condition.

1. Two-account transfer.
2. Order status plus review flag update.
3. Customer status plus audit-state update.
4. Parent-child key correction.
5. Reference-data correction.
6. One independent row change.
7. Bulk correction with expected affected rows.
8. Source key missing scenario.
9. Target key missing scenario.
10. Unrelated rows changed scenario.

## Section F: Mini Case Study

Using the supplied balance and order examples:

1. Identify the target rows.
2. Validate unique keys.
3. Capture before-state totals.
4. Define conceptual transaction steps.
5. Compare expected after-state.
6. Confirm total preservation.
7. Confirm unrelated rows unchanged.
8. Define commit condition.
9. Define rollback condition.
10. Build transaction review summary.

## Answer Key

### Section A Answers

1. A transaction is one logical unit of database work.
2. Atomicity means all-or-nothing thinking.
3. `COMMIT` accepts uncommitted changes according to platform behaviour.
4. `ROLLBACK` abandons uncommitted changes within supported scope.
5. A transaction boundary is the start, contents, validation, and ending decision.
6. Autocommit means individual statements may be committed automatically.
7. Pre-change validation confirms the starting state and target rows.
8. Post-change validation checks the result before acceptance.
9. Expected affected rows are the planned number of rows to change.
10. A control total is a summary value used to catch unintended changes.
11. A partial change is when some related steps happen but others do not.
12. Partial changes can leave related data inconsistent.
13. Rollback is limited to supported uncommitted scope and does not replace recovery planning.
14. Wrong business logic can still be committed atomically.
15. Focused scope reduces unintended risk.
16. Related steps often need to succeed together.
17. A failure path defines what to do if validation fails.
18. Syntax, autocommit, and rollback behaviour vary by platform.
19. The repository is a safe public learning path.
20. A commit condition is evidence required before accepting changes.
21. A rollback condition is evidence that should stop acceptance.
22. Commented examples prevent accidental writes.

### Section B Answers

| # | Classification | Reason |
|---|---|---|
| 1 | Related multi-step change | Two balances must stay aligned |
| 2 | Related multi-step change | Status and flag should change together |
| 3 | Read-only/no transaction needed | No data change occurs |
| 4 | Single independent change | One isolated row may not need broad transaction scope |
| 5 | Related multi-step change | Business state and audit state should align |
| 6 | Transaction useful conceptually | Parent and child consistency matters |
| 7 | Transaction scope too broad | Unrelated changes should be separated |
| 8 | Requires more business context | The target filter is unsafe |
| 9 | Requires more business context | Starting state is invalid |
| 10 | Requires more business context | Target state is invalid |
| 11 | Transaction useful conceptually | Validation failure suggests rollback thinking |
| 12 | Transaction useful conceptually | Unintended side effect needs rollback review |
| 13 | Requires more business context | Recovery depends on platform and timing |
| 14 | Transaction useful conceptually | Rollback thinking applies before commit |
| 15 | Requires more business context | Rollback may not apply after commit |

### Section C Sample Answers

```sql
-- 1 and 2. Check target account keys and count rows.
SELECT
    COUNT(*) AS target_account_count
FROM account_balances_before
WHERE account_id IN (101, 202);
```

```sql
-- 3. Duplicate target account keys.
SELECT
    account_id,
    COUNT(*) AS row_count
FROM account_balances_before
WHERE account_id IN (101, 202)
GROUP BY account_id
HAVING COUNT(*) > 1;
```

```sql
-- 4. Before total balance.
SELECT
    SUM(balance_amount) AS before_total_balance
FROM account_balances_before;
```

```sql
-- 5. Expected after total balance.
SELECT
    SUM(balance_amount) AS expected_after_total_balance
FROM account_balances_expected_after;
```

```sql
-- 6. Changed account comparison.
SELECT
    b.account_id,
    b.balance_amount AS before_balance,
    a.balance_amount AS expected_after_balance,
    a.balance_amount - b.balance_amount AS expected_change
FROM account_balances_before AS b
JOIN account_balances_expected_after AS a
    ON b.account_id = a.account_id
WHERE b.balance_amount <> a.balance_amount;
```

```sql
-- 7. Unchanged account check.
SELECT
    b.account_id,
    b.balance_amount,
    a.balance_amount AS expected_after_balance
FROM account_balances_before AS b
JOIN account_balances_expected_after AS a
    ON b.account_id = a.account_id
WHERE b.account_id NOT IN (101, 202)
  AND b.balance_amount <> a.balance_amount;
```

```sql
-- 8. Target orders exist.
SELECT
    COUNT(*) AS target_order_count
FROM order_status_before
WHERE order_id IN ('O2001', 'O2002');
```

```sql
-- 9 and 10. Order status and review flag comparison.
SELECT
    b.order_id,
    b.order_status AS before_status,
    a.order_status AS expected_after_status,
    b.review_flag AS before_review_flag,
    a.review_flag AS expected_after_review_flag
FROM order_status_before AS b
JOIN order_status_expected_after AS a
    ON b.order_id = a.order_id
WHERE b.order_id IN ('O2001', 'O2002');
```

```sql
-- 11. Order row counts.
SELECT 'before' AS snapshot_name, COUNT(*) AS row_count
FROM order_status_before
UNION ALL
SELECT 'expected_after' AS snapshot_name, COUNT(*) AS row_count
FROM order_status_expected_after;
```

```sql
-- 12. Total preservation.
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
    a.total_balance AS after_total,
    a.total_balance - b.total_balance AS difference
FROM before_total AS b
CROSS JOIN after_total AS a;
```

```sql
-- 13. Rules by stage.
SELECT validation_stage, COUNT(*) AS rule_count
FROM transaction_rules
GROUP BY validation_stage;
```

```sql
-- 14. Scenarios by atomicity need.
SELECT atomicity_need, COUNT(*) AS scenario_count
FROM transaction_casebook
GROUP BY atomicity_need;
```

```sql
-- 15. Rollback-condition summary.
SELECT
    rule_id,
    scenario_name,
    expected_condition,
    review_message
FROM transaction_rules
WHERE rule_name = 'rollback_condition';
```

### Section D Answers

1. Add an expected affected-row count.
2. Use exact keys and preview target rows.
3. Run pre-validation first.
4. Run post-validation before commit.
5. Treat rollback and backup as different controls.
6. Validate business logic separately.
7. Split unrelated work.
8. Compare unrelated rows.
9. Capture before and after totals.
10. Check key uniqueness.
11. Verify platform settings.
12. Verify platform syntax.
13. Comment and label conceptual write blocks.
14. Define rollback and failure conditions.
15. Store review evidence.

### Section E Answer Guidance

Strong plans identify purpose, exact keys, expected row counts, before controls, conceptual related steps, post-checks, commit conditions, rollback conditions, owner role, and review evidence.

### Section F Answer Guidance

A complete answer should identify accounts 101 and 202, orders O2001 and O2002, validate expected row counts, compare before and expected after snapshots, confirm total preservation, confirm unrelated rows are unchanged, and define commit only after all evidence passes. All executable SQL should remain SELECT-based.

