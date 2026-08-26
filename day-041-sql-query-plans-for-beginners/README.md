# Day 041 - SQL Query Plans for Beginners

Day 041 introduces query-plan thinking for beginners: `EXPLAIN`, scans, filters, joins, sorts, aggregates, estimated rows, and cost awareness.

Day 040 discussed index selection thinking. Day 041 shows how query plans can reveal how a database intends to access and process data. Plans provide useful evidence, but they must be interpreted carefully because SQL platforms show plans differently.

## Learning Objectives

By the end of this day, you should understand:

- what a query plan is
- what an execution plan is
- what `EXPLAIN` means conceptually
- why databases build plans
- why plan formats differ by SQL platform
- what table scans, index lookups, filters, joins, sorts, and aggregates mean
- what estimated rows mean
- what cost means conceptually
- why cost is not elapsed time
- why scans are not automatically bad
- why index lookups are not automatically good
- why join order and row multiplication matter
- why filtering earlier can reduce downstream work
- why sorting and grouping large row sets can be expensive
- why query plans can change when data, statistics, indexes, or platforms change
- why plan reading should support evidence-based investigation

## Why Query Plans Matter for Data Engineers

Data engineers often review query behaviour when pipelines, reporting jobs, or validation checks become slow or surprising.

Examples:

- a query unexpectedly scans a large table
- a join produces many more rows than expected
- a sort appears after a large intermediate result
- a filter is applied later than expected
- one version of a query produces fewer estimated rows
- an index exists but the optimizer still chooses a scan
- a query plan changes after data volume grows

## Required Warnings

> A table scan is not automatically a performance problem. Scanning a small table, or a large portion of a table that the query genuinely needs, can be reasonable.

> Query-plan costs are optimizer estimates and are platform-specific. A cost value is not the same thing as elapsed time and should not be compared directly across database systems.

> `EXPLAIN`, `EXPLAIN PLAN`, and `EXPLAIN ANALYZE` behave differently across SQL platforms. Some variants may execute the query, so verify platform behaviour before using them on production systems.

> Day 041 teaches how to read plans conceptually. It does not prescribe production tuning actions, index changes, query hints, or database configuration changes.

## Suggested Learning Order

1. Read `notes.md`
2. Review `sample-tables.md`
3. Inspect the plan CSVs
4. Study `explain-concept.sql`
5. Review table scans
6. Review filter steps
7. Review join plans
8. Review sort and aggregate steps
9. Review estimated rows
10. Review cost awareness
11. Compare sample plans
12. Study plan-change scenarios
13. Build a review summary
14. Complete the debugging lab
15. Run the integrated workflow
16. Review the cheat sheet
17. Complete practice questions
18. Read the summary and glossary

## Files

| File | Purpose | Recommended order |
|---|---|---|
| `README.md` | Day 041 landing page | 1 |
| `notes.md` | Detailed query-plan concepts | 2 |
| `sample-tables.md` | Sample data and plan metadata guide | 3 |
| `explain-concept.sql` | Safe introduction to conceptual `EXPLAIN` usage | 4 |
| `table-scan-review.sql` | Table scan review | 5 |
| `filter-plan-review.sql` | Filter operator review | 6 |
| `join-plan-review.sql` | Join plan review | 7 |
| `sort-and-aggregate-plan-review.sql` | Sort and aggregate review | 8 |
| `estimated-rows-review.sql` | Estimated row-count review | 9 |
| `cost-awareness.sql` | Cost awareness practice | 10 |
| `plan-comparison-practice.sql` | Compare simplified plans | 11 |
| `plan-change-scenarios.sql` | Why plans may change | 12 |
| `query-plan-review-summary.sql` | Summarise plan evidence | 13 |
| `query-plan-debugging-lab.sql` | Guided troubleshooting lab | 14 |
| `integrated-query-plan-workflow.sql` | End-to-end workflow | 15 |
| `query-explanations.md` | Explanations for SQL files | 16 |
| `query-plan-cheatsheet.md` | Quick reference | 17 |
| `query-plan-reading-guide.md` | Step-by-step reading guide | 18 |
| `common-mistakes.md` | Common beginner mistakes | 19 |
| `real-world-examples.md` | Practical scenarios | 20 |
| `beginner-summary.md` | Beginner recap | 21 |
| `glossary.md` | Key terms | 22 |
| `practice-questions.md` | Exercises and answer key | 23 |

## Main Concepts

| Concept | Simple meaning |
|---|---|
| Query plan | The database's chosen strategy for producing a query result |
| Execution plan | The plan the database uses, or expects to use, when running a query |
| `EXPLAIN` | A way to ask the database to show planning information |
| Estimated plan | A plan based on optimizer estimates before full execution evidence |
| Actual plan concept | Plan information that may include execution measurements on some platforms |
| Table scan | Reading a table or substantial portion of it |
| Index lookup | Using an available access path to narrow row access conceptually |
| Filter operator | Applying `WHERE` logic to remove rows |
| Join operator | Combining rows from related inputs |
| Sort operator | Ordering rows for final output or processing |
| Aggregate operator | Grouping and summarising rows |
| Estimated rows | The optimizer's guess about row counts |
| Cost | A platform-specific internal estimate of work |
| Optimizer | The database component that chooses a plan |
| Statistics | Metadata that helps the optimizer estimate data distribution |
| Plan tree | A visual or textual structure of plan steps |
| Plan comparison | Reviewing two plans to identify meaningful differences |

## Safe-Learning Note

All executable SQL in this lesson is read-only. Plan examples are simplified. `EXPLAIN` syntax varies by platform, and `EXPLAIN ANALYZE` can execute a query on some systems. This lesson performs no production tuning action, index change, query hint, or database configuration change.

## Navigation

- Previous Day: [Day 040 - SQL Index Fundamentals](../day-040-sql-index-fundamentals/)
- Next Day: [Day 042 - SQL Performance Habits](../day-042-sql-performance-habits/)
- [Back to Main Learning Path](../README.md)
