# Day 042 - SQL Performance Habits

Day 042 introduces practical SQL performance habits: projection, filtering, join reduction, aggregation strategy, and avoiding unnecessary work.

Day 041 taught how to read broad query-plan signals. Day 042 applies that thinking to everyday query-writing habits. The goal is to reduce unnecessary rows, columns, joins, sorts, and repeated logic without changing the business result.

## Learning Objectives

By the end of this day, you should understand:

- what projection means in SQL
- why selecting only needed columns is often better than `SELECT *`
- when `SELECT *` may still be acceptable during quick exploration
- why wide rows can increase unnecessary processing conceptually
- what column pruning and row pruning mean
- why filters should match the true business population
- why filtering earlier is useful only when logically safe
- why join inputs should be as small as practical
- why unnecessary joins add work and risk
- how accidental row multiplication happens
- why pre-aggregation can help or hurt depending on grain
- why `DISTINCT` should not hide a bad join
- why `ORDER BY` should have a real purpose
- why repeated logic can create unnecessary complexity and work
- why CTE performance varies by platform
- why query rewrites must be validated
- how query-plan evidence can support performance hypotheses

## Why Performance Habits Matter for Data Engineers

Data engineers often maintain SQL used in pipelines, reporting datasets, validation checks, and dashboards. Small habits can make those queries clearer and easier to review.

Examples:

- a query reads many columns but uses only three
- a full-year dataset is loaded before filtering to one month
- a customer table is joined even though no customer columns are used
- a join multiplies rows unexpectedly
- `DISTINCT` hides a duplication issue
- sorting is performed even though downstream consumers do not require order
- aggregation is repeated multiple times
- the same large subquery is repeated in several branches
- a reporting query carries unnecessary columns through every CTE

## Required Warnings

> A faster query is not better if it changes the business result. Performance rewrites must preserve the intended grain, filters, joins, and calculations.

> Filtering earlier can reduce work, but only when the filter is logically safe at that stage. Moving a filter across joins or aggregations can change results.

> `DISTINCT` can remove duplicate rows, but it should not be used to hide an incorrect join or an undefined output grain.

> Day 042 teaches general performance habits. Actual performance depends on the SQL platform, optimizer, data volume, statistics, storage design, and workload.

## Suggested Learning Order

1. Read `notes.md`
2. Review `sample-tables.md`
3. Inspect sample CSVs
4. Practise projection
5. Practise filtering
6. Review join reduction
7. Review row multiplication
8. Study aggregation strategy
9. Review `DISTINCT` and deduplication
10. Review sorting
11. Review repeated work
12. Compare naive and improved queries
13. Validate equivalent outputs
14. Build habit summaries
15. Complete the debugging lab
16. Run the integrated workflow
17. Review the cheat sheet
18. Complete practice questions
19. Read the summary and glossary

## Files

| File | Purpose | Recommended order |
|---|---|---|
| `README.md` | Day 042 landing page | 1 |
| `notes.md` | Detailed performance-habit notes | 2 |
| `sample-tables.md` | Sample data guide | 3 |
| `projection-practice.sql` | Column-selection practice | 4 |
| `filtering-practice.sql` | Row-filtering practice | 5 |
| `join-reduction-practice.sql` | Join necessity and input reduction | 6 |
| `row-multiplication-review.sql` | Join row-growth checks | 7 |
| `aggregation-strategy.sql` | Aggregation grain practice | 8 |
| `distinct-and-dedup-review.sql` | `DISTINCT` and duplicate review | 9 |
| `sort-reduction-practice.sql` | Sort purpose review | 10 |
| `repeated-work-review.sql` | Repeated logic review | 11 |
| `naive-vs-improved-queries.sql` | Paired query rewrites | 12 |
| `performance-validation.sql` | Correctness validation checks | 13 |
| `performance-habit-summary.sql` | Casebook habit summary | 14 |
| `performance-debugging-lab.sql` | Weak-query debugging lab | 15 |
| `integrated-performance-workflow.sql` | End-to-end workflow | 16 |
| `query-explanations.md` | SQL file explanations | 17 |
| `performance-habits-cheatsheet.md` | Quick reference | 18 |
| `query-simplification-guide.md` | Step-by-step review guide | 19 |
| `common-mistakes.md` | Mistakes and safer habits | 20 |
| `real-world-examples.md` | Practical scenarios | 21 |
| `beginner-summary.md` | Lesson recap | 22 |
| `glossary.md` | Alphabetised terms | 23 |
| `practice-questions.md` | Exercises and answer key | 24 |

## Main Concepts

| Concept | Simple meaning |
|---|---|
| Projection | Choosing output columns |
| Column pruning | Keeping only needed columns |
| Filtering | Keeping only needed rows |
| Row pruning | Reducing irrelevant rows |
| Early filtering | Applying filters earlier when logically safe |
| Join reduction | Removing or narrowing joins when business meaning allows |
| Join input size | Number of rows and columns entering a join |
| Row multiplication | More rows after a join |
| Pre-aggregation | Grouping before a later step |
| Output grain | What one row represents |
| Unnecessary sort | Ordering rows with no real requirement |
| Unnecessary `DISTINCT` | Removing duplicates without understanding why they appeared |
| Repeated work | Duplicated logic or calculations |
| Query simplification | Making a query smaller and clearer |
| Semantic equivalence | Same business meaning after a rewrite |
| Performance validation | Checking counts, keys, totals, and grouped outputs |

## Safe-Learning Note

All executable SQL is read-only. Performance rewrites must preserve results. No production tuning commands, index changes, hints, database configuration changes, or object deployments are included. Platform behaviour may differ.

## Navigation

- Previous Day: [Day 041 - SQL Query Plans for Beginners](../day-041-sql-query-plans-for-beginners/)
- Next Day: [Day 043 - SQL for Semi-Structured Data](../day-043-sql-semi-structured-data/)
- [Back to Main Learning Path](../README.md)
