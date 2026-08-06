# Day 027 - SQL Window Function Review

## Ranking, Row Comparisons, Cumulative Metrics, Debugging, and Validation

Day 027 is a review and integration day. It does not introduce a new family of window functions. Instead, it helps you choose between the patterns from Days 024, 025, and 026, combine them carefully, and validate the results before trusting them.

## Learning Objectives

By the end of this day, you should be able to:

- Choose between `ROW_NUMBER`, `RANK`, and `DENSE_RANK`.
- Choose between `LAG` and `LEAD`.
- Choose a cumulative or moving window aggregate.
- Define the business grain before writing SQL.
- Select the correct `PARTITION BY` and window `ORDER BY`.
- Document tie, boundary, and frame policies.
- Use CTEs to filter window-function results safely.
- Validate each calculated column separately.
- Build review outputs that identify records for investigation.

## Connection to Previous Days

Day 024 introduced ranking functions: `ROW_NUMBER`, `RANK`, and `DENSE_RANK`.

Day 025 introduced row comparison functions: `LAG` and `LEAD`.

Day 026 introduced windowed aggregates such as `SUM`, `COUNT`, `AVG`, `MIN`, and `MAX` with explicit `ROWS` frames.

Day 027 brings these ideas together. Real reporting questions often need ranking, previous-row comparison, and cumulative analysis in the same workflow.

## Why a Review Day Matters

Window-function syntax can look correct while the business logic is wrong. A query can run successfully and still answer the wrong question if the partition, ordering rule, tie policy, or frame is incorrect.

Important warnings:

1. The correct window function depends on the business question, data grain, partition, ordering, tie policy, and frame. Syntax alone is not enough.
2. Combining several window functions can make a query useful, but it can also hide incorrect logic. Validate each calculated column separately before trusting the combined result.
3. A review query should identify records for investigation. It should not automatically delete, overwrite, or approve source data.

## Suggested Learning Order

| Step | File | Purpose |
|---|---|---|
| 1 | `review-notes.md` | Review the mental model before practicing |
| 2 | `sample-tables.md` | Understand the sample datasets and review risks |
| 3 | `function-choice-practice.sql` | Decide which function fits each business question |
| 4 | `ranking-review.sql` | Review ranking, ties, and top-per-group logic |
| 5 | `lag-lead-review.sql` | Review previous and next row comparisons |
| 6 | `cumulative-review.sql` | Review running totals and moving windows |
| 7 | `mixed-window-analysis.sql` | Combine multiple window patterns carefully |
| 8 | `debugging-window-queries.sql` | Learn common errors and safer corrections |
| 9 | `validation-workflows.sql` | Practice checks before trusting results |
| 10 | `mini-project.sql` | Build a read-only monitoring report |

## Main Concepts

| Concept | Simple Meaning |
|---|---|
| Business grain | What one row represents in business terms |
| Partition | The group where the window calculation restarts |
| Ordering rule | The sequence used inside each partition |
| Tie policy | What should happen when values are equal |
| Boundary policy | What should happen at the first or last row |
| Frame | Which rows are included in a cumulative or moving calculation |
| Ranking | Assigning a position within a group |
| Row comparison | Comparing a row with a previous or next row |
| Cumulative analysis | Calculating values so far |
| Rolling analysis | Calculating values across recent rows |
| Validation | Checking whether results match expectations |
| Review queue | A read-only list of rows that need investigation |
| Exception report | A report that highlights suspicious records |

## Safe Learning Note

All SQL in Day 027 is read-only and `SELECT`-based. The queries are designed to inspect, rank, compare, calculate, and review data. They do not change source data.

Date arithmetic, default window frames, and type handling can vary across SQL platforms. The examples use beginner-friendly SQL patterns, and cumulative or moving examples use explicit `ROWS` frames to make the intended row window clear.

## Navigation

- Previous Day: [Day 026 - SQL Window Function Practice: Running Totals, Cumulative Metrics, and Moving Averages](../day-026-sql-running-totals-moving-averages/)
- Next Day: [Day 028 - SQL Views for Data Engineers](../day-028-sql-views-for-data-engineers/)
- [Back to Main Learning Path](../README.md)
