# Day 038 - SQL Constraint Concepts: Primary Keys, Foreign Keys, UNIQUE, CHECK, and NOT NULL

Day 038 introduces SQL constraint concepts from a Data Engineering perspective. The focus is primary keys, foreign keys, uniqueness, check rules, required fields, and read-only validation.

Day 037 validated schema structure. Day 038 focuses on important rules within that structure. Constraints describe expectations around keys, relationships, allowed values, and nullability.

## Learning Objectives

By the end of Day 038, you should understand:

- what a database constraint is
- why constraints exist
- primary-key-like row identity
- business keys and surrogate keys conceptually
- composite keys and grain
- foreign keys and parent-child relationships
- orphan records
- unique-rule validation
- check-like allowed-value and range rules
- not-null required-field rules
- why key validation needs uniqueness and requiredness
- how to validate relationships with safe joins
- how to report constraint violations as exceptions
- why enforcement varies by SQL platform
- why violations should be investigated, not automatically removed

## Why Constraint Concepts Matter

Data engineers often rely on important rules even when a database does not enforce them.

Examples:

- one customer ID should identify one customer
- one order should not appear twice at clean grain
- every order customer ID should match a customer
- every payment order ID should match an order
- product code should be unique
- order amount should meet documented range rules
- order status should come from an allowed list
- required keys should not be null

## Required Warnings

> A constraint describes an important rule about data structure or allowed values. Whether the database actually enforces that rule depends on the SQL platform and implementation.

> A primary-key-like validation should confirm both uniqueness and requiredness. A unique-looking column with nulls may not satisfy the intended business rule.

> Foreign-key validation should identify unmatched child records for review. It should not automatically delete orphan records.

> Day 038 teaches constraint concepts and read-only validation patterns. It does not create, alter, drop, enable, or disable database constraints.

## Suggested Learning Order

1. Read `notes.md`
2. Review `sample-tables.md`
3. Inspect CSV files
4. Validate primary-key-like rules
5. Validate composite keys
6. Validate foreign-key-like relationships
7. Validate uniqueness
8. Validate check-like rules
9. Validate not-null rules
10. Review parent-child relationships
11. Build constraint exceptions
12. Build the validation summary
13. Complete design scenarios
14. Complete the debugging lab
15. Run the integrated workflow
16. Review the cheat sheet
17. Complete practice questions
18. Read the summary and glossary

## Files

| File | Purpose | Recommended order |
|---|---|---|
| `README.md` | Day 038 landing page | 1 |
| `notes.md` | Constraint concept notes | 2 |
| `sample-tables.md` | Sample CSV guide | 3 |
| `primary-key-validation.sql` | Key uniqueness and null checks | 4 |
| `composite-key-validation.sql` | Multi-column grain checks | 5 |
| `foreign-key-validation.sql` | Parent-child orphan checks | 6 |
| `unique-rule-validation.sql` | Additional uniqueness rules | 7 |
| `check-rule-validation.sql` | Allowed-value and range checks | 8 |
| `not-null-validation.sql` | Required-field checks | 9 |
| `parent-child-relationship-review.sql` | Relationship review patterns | 10 |
| `constraint-exception-reporting.sql` | Review queue outputs | 11 |
| `constraint-validation-summary.sql` | Summary queries | 12 |
| `constraint-design-scenarios.sql` | Rule design examples | 13 |
| `constraint-debugging-lab.sql` | Mistakes and safer patterns | 14 |
| `integrated-constraint-validation-workflow.sql` | End-to-end validation workflow | 15 |
| `query-explanations.md` | SQL pattern explanations | 16 |
| `constraint-cheatsheet.md` | Quick reference | 17 |
| `constraint-design-guide.md` | Practical design guide | 18 |
| `common-mistakes.md` | Common beginner mistakes | 19 |
| `real-world-examples.md` | Generic examples | 20 |
| `beginner-summary.md` | Lesson recap | 21 |
| `glossary.md` | Alphabetised terms | 22 |
| `practice-questions.md` | Self-study and answer key | 23 |

## Main Concepts

| Concept | Simple meaning |
|---|---|
| Constraint | A rule data is expected to follow |
| Primary key | Column or columns that identify one row |
| Business key | Key with business meaning |
| Surrogate key | Internal identifier conceptually |
| Composite key | Key made from more than one column |
| Foreign key | Child value that references a parent value |
| Parent table | Table being referenced |
| Child table | Table containing the reference |
| Orphan record | Child row with no matching parent |
| Unique rule | Value or combination should not duplicate |
| Check rule | Allowed-value or range condition |
| Not-null rule | Field must contain a value |
| Enforced rule | Database actively checks the rule |
| Documented rule | Rule recorded and validated by queries |
| Constraint exception | Review output for a rule violation |

## Safe-Learning Note

All executable SQL in Day 038 is read-only. No actual database constraint is created. No source data is modified. Violations are reported for investigation. Constraint syntax and enforcement behaviour vary by SQL platform.

## Navigation

- Previous Day: [Day 037 - SQL Schema Validation](../day-037-sql-schema-validation/)
- Next Day: [Day 039 - SQL Transactions Fundamentals: Atomicity, COMMIT, ROLLBACK, and Safe Multi-Step Changes](../day-039-sql-transactions-fundamentals/)
- [Back to Main Learning Path](../README.md)
