# Day 039 Notes - SQL Transactions Fundamentals

## What Is a Transaction?

A transaction is one logical unit of work. It may contain multiple SQL statements. Ideally, all intended changes are committed together or none of them are accepted.

Day 039 teaches the mental model safely. Runnable SQL remains read-only.

## Transaction Boundary

A transaction boundary describes:

- where the transaction starts
- which statements belong inside it
- which validation checks happen before acceptance
- whether the result is committed or rolled back

## Atomicity

Atomicity means all-or-nothing thinking.

```text
Step A changes one related record.
Step B changes another related record.

If Step A succeeds and Step B fails,
the system may become inconsistent.

Atomicity helps treat A + B as one unit.
```

## COMMIT

`COMMIT` accepts the transaction's changes according to platform semantics. Exact durability and implementation details are outside the Day 039 scope.

## ROLLBACK

`ROLLBACK` abandons uncommitted changes within the supported transaction scope. Exact behaviour varies, and some statements or platforms may behave differently.

## Autocommit

Many tools and SQL platforms automatically commit individual statements. This is called autocommit. Do not assume transaction mode. Always understand the environment before running write SQL.

## Transactions Versus Validation

A transaction controls the change boundary. Validation checks whether the change is appropriate. Both ideas matter.

## Transactions Versus Backups

Rollback is not a backup. It helps only within transaction rules and uncommitted scope. Committed bad changes may require backups, audit history, or recovery planning.

## Transactions Versus Business Correctness

A wrong query inside a transaction can still commit wrong data. Atomic does not mean correct.

## Multi-Step Change Example

Conceptual flow:

1. Define expected population.
2. Run pre-change validation.
3. Begin transaction conceptually.
4. Execute related changes conceptually.
5. Run post-change validation.
6. If valid, commit conceptually.
7. If invalid, rollback conceptually.
8. Record evidence.

All write steps in Day 039 are comments only.

## Transaction Size

Huge changes may be risky. Long transactions may affect resources and other users. Detailed performance, locking, and isolation behaviour are outside Day 039 scope.

## Concurrency Concept

Other users or processes may interact with the same data. Transaction isolation controls visibility conceptually, but isolation levels are out of scope for this lesson.

## Safe Transaction Planning Workflow

1. Define business purpose.
2. Identify tables.
3. Identify keys.
4. Define expected affected rows.
5. Validate current state.
6. Identify rollback condition.
7. Group related changes.
8. Execute only in an approved environment.
9. Validate changed state.
10. Commit only after validation.
11. Roll back on failed validation.
12. Document result.

## Common Mistakes

- assuming autocommit is off
- running writes before validation
- having no expected row count
- using no key filter
- using an overly broad `WHERE`
- putting unrelated changes in one transaction
- committing before validation
- assuming rollback works after commit
- treating rollback as backup
- assuming atomicity guarantees business correctness
- keeping a transaction open unnecessarily
- having no post-change validation
- having no audit evidence
- assuming platform syntax is universal
- copying conceptual code directly into production

## Required Warnings

> A transaction helps control whether a group of database changes is committed together, but it does not make incorrect business logic correct.

> `COMMIT`, `ROLLBACK`, autocommit behaviour, supported statements, and transaction isolation differ across SQL platforms. Always verify platform behaviour before using transaction syntax.

> A rollback is not a replacement for backups, audit history, validation, or recovery planning.

> Day 039 teaches transaction concepts using read-only validation and commented change examples. It does not execute production data changes.

