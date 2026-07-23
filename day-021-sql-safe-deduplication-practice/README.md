# Day 021 - SQL Safe Deduplication Practice

SQL safe deduplication practice with `ROW_NUMBER`, keeping latest or earliest records, duplicate resolution rules, and review-first thinking.

## Learning Goal

By the end of Day 021, you should understand why duplicate investigation comes before deduplication, what `ROW_NUMBER` means conceptually, how `PARTITION BY` forms duplicate groups, how `ORDER BY` inside `ROW_NUMBER` decides which row receives number 1, and how documented business rules help select latest, earliest, preferred-status, or review-required records.

## Connection to Day 020

Day 020 taught how to identify and investigate duplicates using `DISTINCT`, business keys, `GROUP BY`, and `HAVING`. Day 021 now shows how to apply documented business rules to select one record safely.

Do not jump directly to deleting duplicates. Day 021 uses safe `SELECT`-based review queries only.

## Required Warning

ROW_NUMBER can help select one record per duplicate group, but it does not decide the correct business rule by itself. The business rule decides what should be kept. ROW_NUMBER only helps implement that rule.

## Why This Matters for Data Engineers

Duplicate versions can appear because of repeated file loads, late-arriving updates, status changes, source-system corrections, repeated events, multiple snapshots, reprocessed extracts, and overlapping data deliveries.

Clean downstream tables often need one reliable record per business key. Raw data should still remain available for audit and troubleshooting.

## Suggested Learning Order

1. Read `notes.md`.
2. Review `sample-tables.md`.
3. Open the CSV files in `sample-data/`.
4. Run `row-number-concept.sql`.
5. Run `keep-latest-record-practice.sql`.
6. Run `keep-earliest-record-practice.sql`.
7. Study `duplicate-resolution-patterns.sql`.
8. Review `safe-dedup-review-queries.sql`.
9. Read `query-explanations.md`.
10. Complete `practice-questions.md`.
11. Review `beginner-summary.md` and `glossary.md`.

## Files in This Folder

| File | Purpose | Order |
| --- | --- | --- |
| `README.md` | Main lesson | 1 |
| `notes.md` | Conceptual notes | 2 |
| `sample-tables.md` | Dataset documentation | 3 |
| `row-number-concept.sql` | First `ROW_NUMBER` examples | 4 |
| `keep-latest-record-practice.sql` | Latest-version patterns | 5 |
| `keep-earliest-record-practice.sql` | Earliest-version patterns | 6 |
| `duplicate-resolution-patterns.sql` | Business-rule patterns | 7 |
| `safe-dedup-review-queries.sql` | Review and validation queries | 8 |
| `query-explanations.md` | Query explanations | 9 |
| `row-number-cheatsheet.md` | Reusable patterns | 10 |
| `deduplication-rules-guide.md` | Rule documentation guide | 11 |
| `real-world-examples.md` | Practical scenarios | 12 |
| `beginner-summary.md` | Summary | 13 |
| `glossary.md` | Definitions | 14 |
| `practice-questions.md` | Exercises and answer key | 15 |

## Main Concepts

| Concept | Simple Meaning |
| --- | --- |
| business key | Column or columns identifying one logical record |
| duplicate group | Records sharing the same business key |
| record version | One version of a repeated record |
| `ROW_NUMBER` | Assigns sequence numbers within a group |
| `PARTITION BY` | Creates the groups where numbering restarts |
| `ORDER BY` inside `ROW_NUMBER` | Decides which row becomes number 1 |
| latest record | Row selected by newest timestamp rule |
| earliest record | Row selected by oldest timestamp rule |
| preferred status | Status chosen by documented priority |
| tie-breaker | Extra ordering column used when primary values tie |
| review flag | Label showing rows that need human/business review |
| raw layer | Preserved source history |
| clean layer | Data after documented rules are applied |

## Safe-Learning Note

All SQL is `SELECT`-based. The source data is not changed. Learners should inspect results before applying rules in real work. Production deduplication should be tested and reviewed.

## Navigation

- Previous: [Day 020 - SQL Duplicate Handling Fundamentals](../day-020-sql-duplicate-handling-fundamentals/)
- Next: [Day 022 - SQL Subqueries for Data Engineers](../day-022-sql-subqueries-for-data-engineers/)
- [Back to Main Learning Path](../README.md)
