# Day 039 - SQL Transactions Fundamentals: Atomicity, COMMIT, ROLLBACK, and Safe Multi-Step Changes

Day 039 introduces SQL transaction thinking: atomicity, commit, rollback, safe multi-step changes, and validation before commit.

Day 038 described rules that data should follow. Day 039 explains how related changes can be treated as one controlled unit so partial changes do not leave data inconsistent.

## Learning Objectives

By the end of Day 039, you should understand:

- what a transaction is
- why transactions exist
- transaction boundaries
- atomicity and all-or-nothing thinking
- what `COMMIT` means conceptually
- what `ROLLBACK` means conceptually
- what autocommit means conceptually
- why platform behaviour varies
- why validation should happen before commit
- why expected affected rows matter
- how control totals catch unintended changes
- why rollback is not a backup
- why atomicity does not make bad logic correct
- why transaction scope should stay focused
- why transaction examples in this lesson are commented only

## Why Transactions Matter

Transactions matter when related changes should succeed together or fail together.

Examples:

- changing two related rows together
- updating a parent and child record consistently
- changing order status and related audit state
- applying a reference-data correction
- moving a value between two balances conceptually
- validating expected affected rows before committing

## Required Warnings

> A transaction helps control whether a group of database changes is committed together, but it does not make incorrect business logic correct.

> `COMMIT`, `ROLLBACK`, autocommit behaviour, supported statements, and transaction isolation differ across SQL platforms. Always verify platform behaviour before using transaction syntax.

> A rollback is not a replacement for backups, audit history, validation, or recovery planning.

> Day 039 teaches transaction concepts using read-only validation and commented change examples. It does not execute production data changes.

## Suggested Learning Order

1. Read `notes.md`
2. Review `sample-tables.md`
3. Inspect the sample CSVs
4. Run `transaction-mental-model.sql`
5. Study atomicity examples
6. Study commit and rollback concepts
7. Review autocommit
8. Run pre-change validation
9. Run post-change validation
10. Review multi-step change scenarios
11. Review failure scenarios
12. Build transaction-review summaries
13. Study safe change planning
14. Complete the debugging lab
15. Run the integrated workflow
16. Review the cheat sheet
17. Complete practice questions
18. Read the summary and glossary

## Files

| File | Purpose | Recommended order |
|---|---|---|
| `README.md` | Day 039 landing page | 1 |
| `notes.md` | Transaction concept notes | 2 |
| `sample-tables.md` | Sample CSV guide | 3 |
| `transaction-mental-model.sql` | Basic before/after transaction thinking | 4 |
| `atomicity-examples.sql` | All-or-nothing examples | 5 |
| `commit-and-rollback-concepts.sql` | Commit and rollback concepts | 6 |
| `autocommit-concept.sql` | Autocommit review | 7 |
| `pre-change-validation.sql` | Validation before changes | 8 |
| `post-change-validation.sql` | Expected after-state validation | 9 |
| `multi-step-change-review.sql` | Related change review | 10 |
| `transaction-failure-scenarios.sql` | Failure-path examples | 11 |
| `transaction-review-summary.sql` | Summary queries | 12 |
| `safe-change-planning.sql` | Safe planning checklist queries | 13 |
| `transaction-debugging-lab.sql` | Risky patterns and safer alternatives | 14 |
| `integrated-transaction-workflow.sql` | End-to-end read-only workflow | 15 |
| `query-explanations.md` | SQL pattern explanations | 16 |
| `transaction-cheatsheet.md` | Quick reference | 17 |
| `transaction-safety-guide.md` | Practical safety guide | 18 |
| `common-mistakes.md` | Common mistakes | 19 |
| `real-world-examples.md` | Generic scenarios | 20 |
| `beginner-summary.md` | Lesson recap | 21 |
| `glossary.md` | Alphabetised terms | 22 |
| `practice-questions.md` | Self-study and answer key | 23 |

## Main Concepts

| Concept | Simple meaning |
|---|---|
| Transaction | One logical unit of database work |
| Transaction boundary | Start, statements, validation, commit or rollback |
| Atomicity | All-or-nothing thinking for related changes |
| Commit | Accept uncommitted changes conceptually |
| Rollback | Abandon uncommitted changes within supported scope |
| Autocommit | Tool or platform commits statements automatically |
| Pre-change validation | Checks before a change begins |
| Post-change validation | Checks before accepting the after state |
| Affected population | Rows expected to change |
| Expected row count | Planned number of affected rows |
| Partial change | Some related steps happen but others do not |
| Consistency | Related data remains aligned |
| Failure path | What to do if validation fails |
| Validation checkpoint | Evidence check before continuing |

## Safe-Learning Note

All executable SQL is read-only. Write statements are commented conceptual examples only. No production changes are performed. Do not copy transaction examples into a real production system without platform-specific review and approval.

## Navigation

- Previous Day: [Day 038 - SQL Constraint Concepts](../day-038-sql-constraint-concepts/)
- Next Day: [Day 040 - SQL Index Fundamentals: Faster Reads, Write Trade-offs, and Index Selection Thinking](../day-040-sql-index-fundamentals/)
- [Back to Main Learning Path](../README.md)
