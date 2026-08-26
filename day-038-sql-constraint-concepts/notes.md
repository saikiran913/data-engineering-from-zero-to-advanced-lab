# Day 038 Notes - SQL Constraint Concepts

## What Is a SQL Constraint?

A SQL constraint expresses a rule that data is expected to follow. Some databases enforce constraints directly. In many data engineering environments, important rules may also be documented and validated using read-only SQL checks.

## Why Constraints Matter

Constraints help:

- protect structural assumptions
- protect relationships
- reduce invalid values
- make grain and keys explicit
- support downstream trust

## Primary Key Concept

A primary key identifies one row in a table. Conceptually, it should be unique and generally non-null. Some tables use one column as a primary key. Others use multiple columns.

Exact platform semantics vary, so Day 038 validates primary-key-like rules with read-only SQL.

## Business Key Versus Primary Key

A business key, also called a natural key, comes from business meaning. Example: `customer_id`.

A primary key is the database row identifier. It may be the same as the business key or different.

A surrogate key is an internal or generated identifier conceptually. Day 038 does not teach key generation.

## Composite Primary Key Concept

A composite key uses more than one column to identify a row.

Examples:

- `order_id + line_number`
- `report_date + country_group`
- `customer_id + effective_date`

Composite keys connect directly to table grain.

## Foreign Key Concept

A foreign key is a child-table value that refers to a parent-table key. It supports referential integrity.

Examples:

- orders reference customers through `customer_id`
- payments reference orders through `order_id`

## Parent and Child

In `customers -> orders`, customers are the parent and orders are the child.

In `orders -> payments`, orders are the parent and payments are the child.

## Orphan Record

An orphan record is a child row with no matching parent. Example: an order has `customer_id = C999`, but there is no customer `C999`.

Orphans should be reported for review, not automatically deleted.

## UNIQUE Concept

A unique rule means a column or column combination should not duplicate. It can be different from a primary key.

Null handling under `UNIQUE` varies by database, so do not assume one universal behaviour.

## CHECK Concept

A check rule validates allowed values or conditions.

Examples:

- `amount >= 0`
- status in an allowed list
- `start_date <= end_date`
- quantity greater than 0

These are business rules, not universal truths.

## NOT NULL Concept

Not-null means a field must contain a value. Requiredness depends on business meaning and the data contract.

## Constraints Versus Validation Queries

A constraint is a rule, possibly database-enforced. A validation query is read-only evidence that data currently follows or violates a rule.

## Constraints Versus Schema Contracts

A schema contract can document rules even if the database does not enforce them. It can include types, requiredness, keys, relationships, and allowed values.

## Constraints in Analytical Systems

Warehouses and lakehouse systems differ. Some analytical platforms may accept constraint declarations without enforcing every rule. Data engineers should still validate important rules when trust matters.

## Constraint-Like Exception Workflow

1. Define the rule.
2. Define table grain.
3. Define the business key.
4. Define expected condition.
5. Run read-only validation.
6. Identify violating rows.
7. Classify issue.
8. Assign educational severity.
9. Preserve audit context.
10. Summarise violations.
11. Review business meaning.
12. Do not auto-delete.

## Common Mistakes

- assuming every ID is a primary key
- ignoring nulls in key validation
- checking uniqueness but not requiredness
- using wrong composite-key columns
- checking foreign keys with inner joins only
- deleting orphan records automatically
- treating every orphan as invalid without business context
- assuming `UNIQUE` null semantics are universal
- using check rules without documented business logic
- treating negative values as universally invalid
- confusing `NOT NULL` with non-empty string
- relying only on declared constraints
- assuming constraints are enforced everywhere
- creating constraints without reviewing existing data
- providing no exception output
- documenting no grain

## Required Warnings

> A constraint describes an important rule about data structure or allowed values. Whether the database actually enforces that rule depends on the SQL platform and implementation.

> A primary-key-like validation should confirm both uniqueness and requiredness. A unique-looking column with nulls may not satisfy the intended business rule.

> Foreign-key validation should identify unmatched child records for review. It should not automatically delete orphan records.

> Day 038 teaches constraint concepts and read-only validation patterns. It does not create, alter, drop, enable, or disable database constraints.

