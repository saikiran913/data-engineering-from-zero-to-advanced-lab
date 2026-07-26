# Day 025 - SQL Window Functions Practice: LAG, LEAD, and Row-to-Row Comparisons

Previous values, next values, change detection, date gaps, and sequence validation.

## Learning Goal

By the end of Day 025, you should understand how `LAG` looks backward, how `LEAD` looks forward, how ordering defines previous and next rows, and how row-to-row comparisons support change detection, gap detection, sequence validation, and review queues.

## Connection to Day 024

Day 024 introduced ranking functions. Ranking compares row positions. Day 025 continues window functions by using `LAG` and `LEAD` to compare neighbouring rows inside a defined sequence.

## Required Warnings

> LAG and LEAD compare rows according to the ordering rule you provide. If the ordering is incomplete or incorrect, the comparison may be misleading.

> The first row in a LAG sequence and the last row in a LEAD sequence normally have no neighbouring row. A NULL result at the boundary is often expected, not an error.

> Row-to-row comparison does not automatically explain why a value changed. It only shows that a change exists according to the selected sequence.

## Why LAG and LEAD Matter for Data Engineers

Data engineers use row-to-row comparison to compare current and previous order values, detect payment-status changes, track product price changes, find missing daily files, identify gaps in event sequences, check arrival order, compare current and next events, identify first and last known states, create change logs, and build validation outputs.

## Suggested Learning Order

1. Read `notes.md`.
2. Review `sample-tables.md`.
3. Inspect CSV files.
4. Run `lag-lead-concept.sql`.
5. Practise previous-value comparisons.
6. Practise next-value comparisons.
7. Study change-detection patterns.
8. Study date-gap detection.
9. Study sequence validation.
10. Study first and last row analysis.
11. Run validation queries.
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
| `lag-lead-concept.sql` | First `LAG` and `LEAD` examples | 4 |
| `previous-value-comparisons.sql` | `LAG` practice | 5 |
| `next-value-comparisons.sql` | `LEAD` practice | 6 |
| `change-detection-patterns.sql` | Status and value changes | 7 |
| `date-gap-detection.sql` | Missing date review | 8 |
| `sequence-validation.sql` | Numeric sequence checks | 9 |
| `first-last-row-analysis.sql` | Boundary row analysis | 10 |
| `row-comparison-validation.sql` | Validation checks | 11 |
| `step-by-step-lag-lead-workflows.sql` | Worked workflows | 12 |
| `query-explanations.md` | Pattern explanations | 13 |
| `lag-lead-cheatsheet.md` | Quick reference | 14 |
| `function-selection-guide.md` | Choosing the right approach | 15 |
| `common-mistakes.md` | Common errors and safer approaches | 16 |
| `real-world-examples.md` | Practical scenarios | 17 |
| `beginner-summary.md` | End-of-day summary | 18 |
| `glossary.md` | Simple definitions | 19 |
| `practice-questions.md` | Exercises and answer key | 20 |

## Main Concepts

| Concept | Simple Meaning |
| --- | --- |
| Previous row | Earlier row in the defined sequence |
| Next row | Following row in the defined sequence |
| Sequence | Ordered rows inside a group |
| `LAG` | Returns a value from a previous row |
| `LEAD` | Returns a value from a next row |
| Offset | How many rows backward or forward to look |
| Default value | Replacement value when no neighbour exists |
| Boundary row | First or last row with no neighbour |
| Partition | Independent sequence group |
| Ordering rule | Columns that define row order |
| Change flag | Label showing whether a value changed |
| Date gap | Missing or irregular date interval |
| Sequence gap | Missing numeric sequence value |
| Review queue | Output of records needing investigation |
| Business grain | What one row represents |

## Safe-Learning Note

All SQL is read-only. No source data is changed. Null boundary values may be expected. Ordering rules must be checked. Duplicate timestamps may require documented tie-breakers. Change detection shows a difference, not a business cause.

Date-difference syntax varies across SQL platforms, so date-gap examples include platform-neutral comments.

## Navigation

- Previous: [Day 024 - SQL Window Functions for Data Engineers](../day-024-sql-window-functions-ranking/)
- Next: [Day 026 - SQL Window Function Practice](../day-026-sql-running-totals-moving-averages/)
- [Back to Main Learning Path](../README.md)
