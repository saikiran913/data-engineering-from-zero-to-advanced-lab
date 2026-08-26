# Day 039 Transaction Cheatsheet

## Transaction Mental Model

```text
Validate -> Begin -> Change -> Validate -> Commit
                                  |
                                  v
                              Rollback
```

This diagram is conceptual. Day 039 executable SQL remains read-only.

## Pre-Change Checklist

- define business purpose
- identify exact keys
- preview target rows
- count target rows
- check duplicates
- capture control totals
- understand platform behaviour

## Post-Change Checklist

- confirm affected-row count
- confirm target keys
- compare control totals
- check related rows
- check unchanged rows
- confirm expected values

## Commit Checklist

- target population matched
- post-change validation passed
- control totals reconciled
- no unintended rows changed
- rollback condition did not occur
- evidence is documented

## Rollback Checklist

- row count unexpected
- key missing or duplicated
- control total mismatch
- unrelated row changed
- business rule failed
- validation evidence does not match the plan

## Autocommit Warning

Autocommit behaviour varies by SQL tool and platform. Never assume a transaction is open or closed without checking the environment.

## Expected Affected-Row Template

```sql
SELECT
    COUNT(*) AS target_row_count
FROM table_name
WHERE business_key IN (...);
```

## Control-Total Template

```sql
SELECT
    SUM(amount_column) AS control_total
FROM table_name;
```

## Conceptual Transaction Block

```sql
-- CONCEPTUAL ONLY - DO NOT RUN
-- BEGIN TRANSACTION;
-- UPDATE first_related_table ...
-- UPDATE second_related_table ...
-- Run post-change SELECT validation here.
-- COMMIT if validation passes.
-- ROLLBACK if validation fails.
```

