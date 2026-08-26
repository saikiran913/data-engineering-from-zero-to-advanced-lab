# Day 039 Query Explanations

Day 039 uses read-only comparisons to explain transaction thinking safely.

## Transaction Boundary

Business purpose: define where related work begins and ends.

What is validated: target rows, before state, expected after state, and commit or rollback conditions.

Why it matters: unclear boundaries create partial-change risk.

Common risk: including unrelated statements in one transaction.

## Atomicity

Business purpose: treat related changes as one unit.

What is validated: account decreases and increases, order status and review flag changes.

Why it matters: one related step succeeding while another fails can create inconsistent data.

Common risk: assuming atomicity means the business logic is correct.

## Commit

Business purpose: accept transaction changes after validation.

What is validated: expected row counts, control totals, target rows, and unchanged rows.

Why it matters: committing too early can make recovery harder.

Common risk: committing before post-change validation.

## Rollback

Business purpose: abandon uncommitted changes when validation fails.

What is validated: rollback condition, failed post-check, unexpected row count, or total mismatch.

Why it matters: failure paths should be known before a change begins.

Common risk: treating rollback as a backup.

## Autocommit

Business purpose: understand whether statements are committed automatically.

What is validated: platform behaviour and tool settings conceptually.

Why it matters: transaction syntax and behaviour vary.

Common risk: assuming autocommit is disabled.

## Pre-Change Validation

Business purpose: prove the starting state matches the plan.

What is validated: keys exist, expected row count matches, duplicates are absent, and before totals are captured.

Common risk: running changes before knowing the target population.

## Post-Change Validation

Business purpose: check expected after-state before accepting changes.

What is validated: totals, changed rows, unchanged rows, statuses, review flags, and row counts.

Common risk: checking only changed rows and ignoring unrelated rows.

## Line-by-Line Before/After Comparison

| Query part | Meaning |
|---|---|
| `FROM account_balances_before AS b` | Starts from the before-state snapshot |
| `JOIN account_balances_expected_after AS a` | Matches each before account to expected after state |
| `ON b.account_id = a.account_id` | Compares the same account key |
| `b.balance_amount AS before_balance` | Shows the starting balance |
| `a.balance_amount AS expected_after_balance` | Shows the planned after balance |
| `a.balance_amount - b.balance_amount` | Shows the expected change |
| `WHERE b.balance_amount <> a.balance_amount` | Returns only rows expected to change |

## Concept Table

| Concept | Main question | Safe learning pattern |
|---|---|---|
| Transaction boundary | What work belongs together? | Document scope and target rows |
| Atomicity | Should steps succeed together? | Compare related before/after changes |
| Commit | Is the result acceptable? | Validate before accepting |
| Rollback | What if validation fails? | Define failure conditions before changes |
| Autocommit | Are statements committed automatically? | Verify platform behaviour |
| Control total | Did total values stay consistent? | Compare before and after totals |

