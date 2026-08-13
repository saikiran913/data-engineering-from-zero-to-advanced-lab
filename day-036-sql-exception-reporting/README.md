# Day 036 - SQL Exception Reporting: Review Queues, Severity Levels, and Investigable Data-Quality Outputs

## Review Queues, Severity Levels, Issue Categories, and Investigation-Friendly Outputs

Day 035 identified completeness gaps. Day 036 teaches how to present data-quality findings for review. The goal is not only to detect an issue, but to make investigation practical.

An exception report should answer what failed, where it failed, which record or group is affected, what was expected, what was observed, how serious the issue is, what evidence is available, and what should be investigated next.

## Learning Objectives

By the end of Day 036, you should understand:

- what an exception, exception report, and review queue are
- the difference between record-level, metric-level, and stage-level exceptions
- the difference between an exception and a validation summary
- why every exception needs a clear issue category and issue type
- why severity should follow documented rules
- how to define entity keys and stage context
- how to capture expected values, actual values, and differences
- how to preserve source-file and timestamp context
- how to write investigation-friendly review messages
- how to align multiple exception types into one queue with `UNION ALL`
- how to avoid duplicate exception rows
- how to summarise exceptions by stage, category, type, and severity
- why an exception queue should not automatically correct data

## Required Warnings

> An exception report should explain what needs investigation. It should not automatically decide how the underlying data must be corrected.

> Severity levels are business rules. They should be documented consistently rather than guessed from the size or appearance of an issue.

> Combining different exception types is useful only when their output columns have consistent meanings and compatible data types.

> A review queue is not proof that every listed item is a confirmed defect. Some records may be expected exceptions or require business-context review.

## Suggested Learning Order

| Order | File | Purpose |
|---|---|---|
| 1 | `notes.md` | Learn exception-reporting concepts |
| 2 | `sample-tables.md` | Understand sample data and exception cases |
| 3 | `sample-data/` | Inspect CSV files |
| 4 | `record-level-exceptions.sql` | Build record-level exceptions |
| 5 | `metric-level-exceptions.sql` | Build metric-level exceptions |
| 6 | `stage-level-exceptions.sql` | Build stage-level exceptions |
| 7 | `issue-category-design.sql` | Review issue categories |
| 8 | `severity-level-design.sql` | Review severity design |
| 9 | `review-queue-building.sql` | Build a review queue |
| 10 | `multi-rule-exception-queue.sql` | Combine multiple rules |
| 11 | `exception-deduplication.sql` | Review duplicate exception rows |
| 12 | `exception-summary-reporting.sql` | Summarise exceptions |
| 13 | `investigation-context.sql` | Add audit context |
| 14 | `exception-debugging-lab.sql` | Debug weak exception outputs |
| 15 | `integrated-exception-workflow.sql` | Run the integrated workflow |
| 16 | `exception-reporting-cheatsheet.md` | Review reusable patterns |
| 17 | `practice-questions.md` | Complete self-study |
| 18 | `beginner-summary.md` and `glossary.md` | Revise key ideas |

## Files

| File | Purpose | Recommended Order |
|---|---|---|
| `README.md` | Day 036 landing page | 1 |
| `notes.md` | Detailed exception-reporting notes | 2 |
| `sample-tables.md` | Dataset documentation | 3 |
| `record-level-exceptions.sql` | Record-level review rows | 4 |
| `metric-level-exceptions.sql` | Metric-level review rows | 5 |
| `stage-level-exceptions.sql` | Stage-level review rows | 6 |
| `issue-category-design.sql` | Category design review | 7 |
| `severity-level-design.sql` | Severity design review | 8 |
| `review-queue-building.sql` | Basic review queue | 9 |
| `multi-rule-exception-queue.sql` | Combined queue with `UNION ALL` | 10 |
| `exception-deduplication.sql` | Duplicate exception checks | 11 |
| `exception-summary-reporting.sql` | Queue summaries | 12 |
| `investigation-context.sql` | Source and audit context | 13 |
| `exception-debugging-lab.sql` | Debugging practice | 14 |
| `integrated-exception-workflow.sql` | End-to-end workflow | 15 |
| `query-explanations.md` | SQL explanations | 16 |
| `exception-reporting-cheatsheet.md` | Quick reference | 17 |
| `exception-rule-design-guide.md` | Rule design guide | 18 |
| `common-mistakes.md` | Common mistakes | 19 |
| `real-world-examples.md` | Generic scenarios | 20 |
| `beginner-summary.md` | Plain-language recap | 21 |
| `glossary.md` | Alphabetical glossary | 22 |
| `practice-questions.md` | Questions and answer key | 23 |

## Main Concepts

| Concept | Simple Meaning |
|---|---|
| Exception | A review item from a validation rule |
| Review queue | A structured list of exceptions |
| Record-level exception | A row-level issue, usually tied to an entity key |
| Metric-level exception | A mismatch in a count, total, or grouped metric |
| Stage-level exception | A stage or delivery issue |
| Issue category | Stable high-level issue group |
| Issue type | Specific reason inside a category |
| Severity | Rule-based priority label |
| Entity key | Affected order, file, group, or metric |
| Expected value | What the rule expected |
| Actual value | What was observed |
| Difference | Numeric or descriptive gap |
| Evidence | Fields that help investigation |
| Review message | Human-readable next step |

## Safe-Learning Note

All executable SQL is read-only. Exception outputs do not modify data. Severity is educational and rule-based. No automated remediation, ticketing, alerting, or production ownership system is built.

Type casting, text concatenation, and generated identifiers vary across SQL platforms. When combining exception types with `UNION ALL`, output columns should have aligned meanings and compatible data types.

## Navigation

- Previous Day: [Day 035 - SQL Data Completeness Checks](../day-035-sql-data-completeness-checks/)
- Next Day: [Day 037 - SQL Schema Validation: Column Contracts, Data Types, Required Fields, and Change Detection](../day-037-sql-schema-validation/)
- [Back to Main Learning Path](../README.md)
