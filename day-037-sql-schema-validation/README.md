# Day 037 - SQL Schema Validation: Column Contracts, Data Types, Required Fields, and Change Detection

Day 037 introduces schema validation: checking whether the structure of a dataset still matches the expected contract. This includes column contracts, data types, required fields, schema drift, and change detection.

Day 036 focused on exception reporting. Day 037 shifts from row-level findings to structural validation. Schema exceptions can also feed investigation-friendly review queues when a column is missing, renamed, type-changed, or risky for consumers.

## Learning Objectives

By the end of Day 037, you should understand:

- what a schema is
- what a schema contract is
- why column contracts matter
- required and optional columns
- missing required columns
- unexpected columns
- renamed and removed column risk
- expected and observed data types
- type compatibility at a beginner level
- nullability expectations
- semantic column meaning
- why column order is fragile
- schema drift
- additive and breaking changes
- why `SELECT *` consumers can be affected by added columns
- consumer impact review
- schema exception reporting
- why schema validation should not perform migrations

## Why Schema Validation Matters

Data engineers often receive data from files, tables, feeds, or upstream systems. A pipeline may still run, but downstream users can break if the shape changes.

Examples:

- a required column disappears
- a source team renames a field
- an integer or decimal column becomes text
- a timestamp becomes a date
- an optional column becomes unexpectedly null everywhere
- a new column appears
- downstream SQL uses `SELECT *`
- a reporting consumer expects a stable column list
- a field keeps the same name but changes business meaning

## Required Warnings

> A schema match does not prove that the data values are correct. Schema validation checks structure, not full data quality.

> A missing, renamed, removed, or type-changed column can break downstream consumers even when the source query still runs successfully.

> An unexpected column is not automatically a defect. It may be an intentional additive change, but downstream consumers should still be reviewed.

> Schema validation should detect and report structural changes. It should not automatically alter tables, rename columns, or migrate data.

## Suggested Learning Order

1. Read `notes.md`
2. Review `sample-tables.md`
3. Inspect schema CSV files
4. Compare expected and observed columns
5. Validate required columns
6. Review unexpected columns
7. Validate data types
8. Validate nullability contracts
9. Review renamed and removed columns
10. Review additive changes
11. Detect schema changes
12. Review consumer impact
13. Build schema exceptions
14. Build validation summary
15. Complete the debugging lab
16. Run the integrated workflow
17. Review the cheat sheet
18. Complete practice questions
19. Read the summary and glossary

## Files

| File | Purpose | Recommended order |
|---|---|---|
| `README.md` | Day 037 landing page | 1 |
| `notes.md` | Detailed conceptual notes | 2 |
| `sample-tables.md` | Guide to supplied CSV files | 3 |
| `expected-vs-observed-columns.sql` | Compare expected and observed columns | 4 |
| `required-column-validation.sql` | Find missing required and optional columns | 5 |
| `unexpected-column-review.sql` | Review columns not in the contract | 6 |
| `data-type-validation.sql` | Compare expected and observed data types | 7 |
| `nullability-contract-validation.sql` | Compare nullability metadata | 8 |
| `renamed-and-removed-column-review.sql` | Review removed and possible renamed columns | 9 |
| `additive-change-review.sql` | Review additive schema changes | 10 |
| `schema-change-detection.sql` | Compare V1 and V2 observed schemas | 11 |
| `consumer-impact-review.sql` | Identify affected downstream consumers | 12 |
| `schema-exception-reporting.sql` | Build schema exception rows | 13 |
| `schema-validation-summary.sql` | Summarise schema validation findings | 14 |
| `schema-debugging-lab.sql` | Learn from risky patterns | 15 |
| `integrated-schema-validation-workflow.sql` | End-to-end schema validation flow | 16 |
| `query-explanations.md` | Explanation of SQL patterns | 17 |
| `schema-validation-cheatsheet.md` | Reusable quick reference | 18 |
| `schema-contract-design-guide.md` | Practical schema-contract template | 19 |
| `common-mistakes.md` | Common schema-validation mistakes | 20 |
| `real-world-examples.md` | Generic schema-change scenarios | 21 |
| `beginner-summary.md` | Beginner-friendly recap | 22 |
| `glossary.md` | Alphabetised terms | 23 |
| `practice-questions.md` | Self-study questions and answer key | 24 |

## Main Concepts

| Concept | Simple meaning |
|---|---|
| Schema | The structure of a dataset |
| Schema contract | The agreed expected structure for consumers |
| Column contract | The expected name, type, nullability, and meaning of one column |
| Required column | A column that must be present |
| Optional column | A column that may be absent if the contract allows it |
| Expected schema | The documented contract |
| Observed schema | The structure currently found in the source |
| Schema drift | Difference between expected and observed structure |
| Additive change | A new column or structure added to the source |
| Breaking change | A change likely to break consumers |
| Data-type change | A column type changed, such as `DECIMAL` to `TEXT` |
| Nullability | Whether metadata says a column may contain nulls |
| Semantic meaning | What the column means to the business |
| Consumer impact | How a schema change may affect downstream users |
| Schema exception | A review row describing a structural issue |

## Safe-Learning Note

All executable SQL in Day 037 is read-only. No schema is altered. No column is added, removed, or renamed. All structural changes are detected and reported only. Production migrations, schema registries, deployment, and database-specific DDL remain out of scope.

## Navigation

- Previous Day: [Day 036 - SQL Exception Reporting](../day-036-sql-exception-reporting/)
- Next Day: [Day 038 - SQL Constraint Concepts: Primary Keys, Foreign Keys, UNIQUE, CHECK, and NOT NULL](../day-038-sql-constraint-concepts/)
- [Back to Main Learning Path](../README.md)
