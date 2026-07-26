# Day 024 - SQL Window Functions for Data Engineers

`RANK`, `DENSE_RANK`, ties, top-per-group analysis, and group-based comparisons.

## Learning Goal

By the end of Day 024, you should understand how ranking window functions compare records inside logical groups while keeping the original rows visible. You will compare `ROW_NUMBER`, `RANK`, and `DENSE_RANK`, learn how ties affect results, and use CTEs to filter ranked output safely.

## Connection to Earlier Days

Day 021 introduced `ROW_NUMBER` for safe deduplication. Day 023 introduced CTEs for readable query steps. Day 024 combines those foundations and introduces tie-aware ranking with `RANK` and `DENSE_RANK`.

## Required Warnings

> ROW_NUMBER, RANK, and DENSE_RANK answer different questions. Choose the function based on how ties should be handled.

> A ranking function orders records according to the columns you provide. It does not decide whether those columns represent the correct business rule.

> Ranking output should be validated for ties, null ordering values, unexpected groups, and incorrect data grain before it is used in reporting.

## Why Ranking Matters for Data Engineers

Ranking helps answer practical questions such as:

- Which products are top within each category?
- Which customers have the highest sales within each country?
- Which campaigns perform best by channel and country?
- Which sales days are strongest within each region?
- Which issue groups should be reviewed first?
- Should tied winners all be preserved?
- Should exactly one row be selected with a documented tie-breaker?

## Suggested Learning Order

1. Read `notes.md`.
2. Review `sample-tables.md`.
3. Inspect CSV files.
4. Run `window-function-concept.sql`.
5. Compare the three ranking functions.
6. Practise `RANK`.
7. Practise `DENSE_RANK`.
8. Study top-per-group analysis.
9. Study tie-aware ranking.
10. Run validation queries.
11. Complete group-based analysis.
12. Complete step-by-step workflows.
13. Review the cheat sheet.
14. Complete practice questions.
15. Read the summary and glossary.

## Files in This Folder

| File | Purpose | Order |
| --- | --- | --- |
| `README.md` | Main lesson | 1 |
| `notes.md` | Conceptual notes | 2 |
| `sample-tables.md` | Dataset documentation | 3 |
| `window-function-concept.sql` | First window ranking examples | 4 |
| `row-number-vs-rank-vs-dense-rank.sql` | Side-by-side function comparison | 5 |
| `rank-practice.sql` | `RANK` practice | 6 |
| `dense-rank-practice.sql` | `DENSE_RANK` practice | 7 |
| `top-per-group-analysis.sql` | Top and bottom records per group | 8 |
| `tie-aware-ranking.sql` | Tie detection and review | 9 |
| `ranking-validation-queries.sql` | Ranking validation checks | 10 |
| `group-based-analysis.sql` | Ranking inside business groups | 11 |
| `step-by-step-ranking-workflows.sql` | Worked ranking workflows | 12 |
| `query-explanations.md` | Pattern explanations | 13 |
| `ranking-cheatsheet.md` | Quick reference | 14 |
| `function-selection-guide.md` | Choosing the right function | 15 |
| `common-mistakes.md` | Common errors and safer approaches | 16 |
| `real-world-examples.md` | Practical scenarios | 17 |
| `beginner-summary.md` | End-of-day summary | 18 |
| `glossary.md` | Simple definitions | 19 |
| `practice-questions.md` | Exercises and answer key | 20 |

## Main Concepts

| Concept | Simple Meaning |
| --- | --- |
| Window function | Calculates a value for each row without collapsing rows |
| `OVER` | Defines the window used by the function |
| `PARTITION BY` | Splits rows into groups where ranking restarts |
| Window `ORDER BY` | Controls ranking order |
| `ROW_NUMBER` | Gives unique sequence numbers |
| `RANK` | Preserves ties and skips numbers after ties |
| `DENSE_RANK` | Preserves ties without skipped numbers |
| Top-per-group | Highest ranked records inside each group |
| Tie policy | Business rule for handling equal values |
| Ranking grain | What one ranked row represents |

## Safe-Learning Note

All SQL in Day 024 is read-only. Ranking functions do not approve business truth by themselves. Always validate partitions, ties, nulls, duplicates, row counts, and output grain before using rankings in reporting.

## Navigation

- Previous: [Day 023 - SQL Common Table Expressions for Data Engineers](../day-023-sql-common-table-expressions/)
- Next: [Day 025 - SQL Window Functions Practice](../day-025-sql-lag-lead-row-comparisons/)
- [Back to Main Learning Path](../README.md)
