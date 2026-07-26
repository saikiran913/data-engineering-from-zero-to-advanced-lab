# Day 026 - SQL Window Function Practice: Running Totals, Cumulative Metrics, and Moving Averages

Cumulative calculations, rolling windows, explicit window frames, and validation.

## Learning Goal

By the end of Day 026, you should understand how windowed aggregate functions calculate running totals, cumulative counts, cumulative averages, cumulative minimums and maximums, moving sums, and moving averages while keeping original rows visible.

## Connection to Day 025

Day 025 compared neighbouring rows using `LAG` and `LEAD`. Day 026 expands the window to include several or all earlier rows. `LAG` looks at a specific neighbour, while cumulative and moving functions summarise a defined frame of rows.

## Required Warnings

> Running totals and moving averages depend on the ordering rule and data grain. If the sequence is wrong, the result will also be wrong.

> A row-based moving window counts rows, not necessarily calendar days. Missing dates or multiple rows on the same date can change what the window represents.

> Window-frame defaults can vary in effect across SQL platforms and data patterns. Use an explicit ROWS frame in beginner examples so the intended calculation is clear.

## Why These Metrics Matter for Data Engineers

Running totals and moving metrics support cumulative sales, cumulative order counts, cumulative pipeline records, inventory trend summaries, campaign rolling averages, short-term smoothing, load-volume monitoring, sudden-change review, reporting-ready metrics, and validation of grouped totals.

## Suggested Learning Order

1. Read `notes.md`.
2. Review `sample-tables.md`.
3. Inspect CSV files.
4. Run `running-total-concept.sql`.
5. Practise cumulative metrics.
6. Practise moving sums.
7. Practise moving averages.
8. Study partitioned analysis.
9. Study explicit window frames.
10. Run cumulative validation.
11. Run moving-window validation.
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
| `running-total-concept.sql` | First running-total examples | 4 |
| `cumulative-metrics-practice.sql` | Cumulative sums, counts, averages, min, and max | 5 |
| `moving-sum-practice.sql` | Row-based moving sums | 6 |
| `moving-average-practice.sql` | Row-based moving averages | 7 |
| `partitioned-cumulative-analysis.sql` | Partitioned and global examples | 8 |
| `window-frame-practice.sql` | Explicit frame examples | 9 |
| `cumulative-validation-queries.sql` | Running-total validation | 10 |
| `moving-window-validation.sql` | Moving-window validation | 11 |
| `step-by-step-cumulative-workflows.sql` | Worked workflows | 12 |
| `query-explanations.md` | Pattern explanations | 13 |
| `window-frame-cheatsheet.md` | Quick reference | 14 |
| `metric-selection-guide.md` | Choosing the right metric | 15 |
| `common-mistakes.md` | Common errors and safer approaches | 16 |
| `real-world-examples.md` | Practical scenarios | 17 |
| `beginner-summary.md` | End-of-day summary | 18 |
| `glossary.md` | Simple definitions | 19 |
| `practice-questions.md` | Exercises and answer key | 20 |

## Main Concepts

| Concept | Simple Meaning |
| --- | --- |
| Windowed aggregate | Aggregate calculated per row over a window |
| Running total | Total from the start through the current row |
| Cumulative count | Count so far |
| Cumulative average | Average from the start through the current row |
| Moving sum | Sum over a limited recent frame |
| Moving average | Average over a limited recent frame |
| Window frame | Rows included for the current calculation |
| Current row | Row currently being calculated |
| Preceding row | Row before the current row |
| Unbounded preceding | Start at the first row in the partition |
| Partition | Group where calculation restarts |
| Ordering column | Column defining sequence |
| Business grain | What one input row represents |
| Row-based window | Frame that counts rows |
| Validation | Checks proving the metric is trustworthy |

## Safe-Learning Note

All SQL is read-only. No source data is changed. Moving windows count rows unless a different frame is defined. Missing dates and duplicate rows must be reviewed. Cumulative metrics should be reconciled to grouped totals.

## Navigation

- Previous: [Day 025 - SQL Window Functions Practice](../day-025-sql-lag-lead-row-comparisons/)
- Next: [Day 027 - SQL Window Function Review](../day-027-sql-window-function-review/)
- [Back to Main Learning Path](../README.md)
