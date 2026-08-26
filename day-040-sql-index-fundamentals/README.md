# Day 040 - SQL Index Fundamentals: Faster Reads, Write Trade-offs, and Index Selection Thinking

Day 040 introduces SQL index fundamentals from a Data Engineering perspective: faster reads, write trade-offs, selectivity, query patterns, and index selection thinking.

Day 039 focused on safe multi-step changes. Day 040 focuses on read performance concepts. Indexes can speed up some reads, but they add maintenance cost to writes.

## Learning Objectives

By the end of Day 040, you should understand:

- what an index is conceptually
- why an index can speed up some lookups
- why a table can still be queried without an index
- why an index does not change query meaning
- table scan versus index lookup thinking
- selectivity and cardinality
- why frequent filters matter
- why join columns can be candidates
- why sort patterns can matter
- why composite index column order matters
- why indexes consume storage
- why writes can become more expensive
- why over-indexing is risky
- why operational and analytical systems differ
- why platform behaviour matters
- why index selection should start from workload evidence

## Why Index Fundamentals Matter

Data engineers often work near query performance questions, even when they are not database administrators.

Examples:

- repeated lookup by `order_id`
- filtering recent records by date
- joining orders to customers
- searching by a selective business key
- sorting by a frequently used reporting column
- write-heavy ingestion tables
- append-heavy fact tables
- analytical warehouses where traditional indexes may not be the main tuning mechanism

## Required Warnings

> An index can improve some read patterns, but it adds storage and write-maintenance cost. More indexes do not automatically mean better performance.

> Index usefulness depends on the SQL platform, table size, data distribution, query pattern, and optimizer behaviour. Day 040 teaches general reasoning, not universal tuning rules.

> A column that appears in a `WHERE` or `JOIN` clause is not automatically a good index candidate. Selectivity, frequency, workload, and table design matter.

> Day 040 explains index concepts and selection thinking. It does not create, drop, rebuild, or deploy indexes.

## Suggested Learning Order

1. Read `notes.md`
2. Review `sample-tables.md`
3. Inspect workload CSVs
4. Run `index-mental-model.sql`
5. Study selectivity
6. Review filter patterns
7. Review join columns
8. Review sort patterns
9. Study composite-index thinking
10. Review read/write trade-offs
11. Review candidate indexes
12. Review poor candidates
13. Analyse the workload
14. Complete the debugging lab
15. Run the integrated workflow
16. Review the cheat sheet
17. Complete practice questions
18. Read the summary and glossary

## Files

| File | Purpose | Recommended order |
|---|---|---|
| `README.md` | Day 040 landing page | 1 |
| `notes.md` | Index concept notes | 2 |
| `sample-tables.md` | Workload CSV guide | 3 |
| `index-mental-model.sql` | Basic index thinking | 4 |
| `selectivity-analysis.sql` | Cardinality and selectivity analysis | 5 |
| `filter-pattern-analysis.sql` | Filter workload review | 6 |
| `join-column-analysis.sql` | Join-column review | 7 |
| `sort-pattern-analysis.sql` | Sort-pattern review | 8 |
| `composite-index-thinking.sql` | Multi-column index concepts | 9 |
| `read-write-tradeoff-analysis.sql` | Read/write cost review | 10 |
| `candidate-index-review.sql` | Candidate classification | 11 |
| `poor-index-candidate-review.sql` | Weak candidate review | 12 |
| `workload-index-selection.sql` | Workload-driven selection summary | 13 |
| `index-debugging-lab.sql` | Risky assumptions and safer patterns | 14 |
| `integrated-index-selection-workflow.sql` | End-to-end selection workflow | 15 |
| `query-explanations.md` | SQL pattern explanations | 16 |
| `index-cheatsheet.md` | Quick reference | 17 |
| `index-selection-guide.md` | Practical selection guide | 18 |
| `common-mistakes.md` | Common beginner mistakes | 19 |
| `real-world-examples.md` | Generic scenarios | 20 |
| `beginner-summary.md` | Lesson recap | 21 |
| `glossary.md` | Alphabetised terms | 22 |
| `practice-questions.md` | Self-study and answer key | 23 |

## Main Concepts

| Concept | Simple meaning |
|---|---|
| Index | Additional access structure that may help reads |
| Access path | How the database finds rows conceptually |
| Full scan | Examine a larger part of the table |
| Lookup | Find a smaller target set |
| Selectivity | How narrowly a column identifies rows |
| Cardinality | Number of distinct values |
| Filter column | Column used in `WHERE` |
| Join column | Column used to connect tables |
| Sort column | Column used in `ORDER BY` |
| Composite index | Conceptual index over multiple columns |
| Leading column | First column in a composite index |
| Write overhead | Extra maintenance work during writes |
| Workload-driven design | Choosing based on real query patterns |

## Safe-Learning Note

All executable SQL is read-only. No index is created or dropped. Index syntax appears only as commented conceptual material. Production tuning requires platform-specific evidence, query plans, table size, and workload testing.

## Navigation

- Previous Day: [Day 039 - SQL Transactions Fundamentals](../day-039-sql-transactions-fundamentals/)
- Next Day: [Day 041 - SQL Query Plans for Beginners](../day-041-sql-query-plans-for-beginners/)
- [Back to Main Learning Path](../README.md)
