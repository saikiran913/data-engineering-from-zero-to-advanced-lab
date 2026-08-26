# Transaction Safety Guide

## Before Changing Anything

- define business purpose
- identify exact keys
- preview target rows
- count target rows
- check duplicates
- capture control totals
- understand platform behaviour

## During a Transaction Conceptually

- keep scope narrow
- group related changes
- validate before commit
- avoid unrelated work
- keep evidence readable

## Before Commit

Check:

- affected-row count
- key validation
- control totals
- related-row consistency
- no unintended rows

## When to Rollback Conceptually

Rollback thinking is needed when:

- row count is unexpected
- key mismatch appears
- control total does not reconcile
- business rule fails
- unintended rows are affected

## After Commit

After an approved commit in a real environment, teams usually need independent validation, audit evidence, and downstream review if needed.

## Transaction Safety Template

| Field | Example |
|---|---|
| Scenario | Account balance transfer concept |
| Tables | Account balance table |
| Keys | 101 and 202 |
| Expected rows | 2 |
| Before controls | Grand total balance |
| After controls | Same grand total balance |
| Commit condition | Target rows and totals match expected after state |
| Rollback condition | Row count or control total mismatch |
| Owner role | Data engineering reviewer |
| Review date | Date of review |

