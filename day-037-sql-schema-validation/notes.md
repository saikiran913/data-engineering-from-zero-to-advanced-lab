# Day 037 Notes - SQL Schema Validation

## What Is a Schema?

A schema describes the structure of a dataset. For a beginner, think of it as the expected shape of a table or file.

A schema may include:

- column names
- data types
- nullability expectations
- business meaning
- required or optional status
- grain-related key fields

Schema validation checks whether the structure is still what consumers expect.

## What Is a Schema Contract?

A schema contract is the agreed expectation for how a dataset is exposed to downstream consumers. It documents what columns should exist, what they mean, and how they should behave structurally.

For example, a clean order dataset may promise that `order_id`, `customer_id`, `order_date`, and `order_amount` are present with stable meanings.

## Column Contract

For each important column, a contract may document:

- name
- type
- required flag
- nullable flag
- business meaning
- consumer sensitivity
- example value
- source mapping

This helps teams know whether a change is harmless, risky, or breaking.

## Expected Schema Versus Observed Schema

Expected schema means the documented contract.

Observed schema means what the current input, file, table, or interface exposes.

Schema validation compares the expected schema to the observed schema and reports differences.

## Required Versus Optional Columns

Required columns must be present. If they are missing, downstream SQL, reports, extracts, and validation checks can break.

Optional columns may be absent if the contract allows it. Even then, absence may still need review if a consumer started using that column.

Requiredness should be documented rather than guessed.

## Missing Required Column

A missing required column is usually high risk because consumers may depend on it. If `customer_id` disappears, customer reports and validation checks may fail.

## Missing Optional Column

A missing optional column may be acceptable, but it still deserves review when consumers use it. Optional does not mean undocumented.

## Unexpected Column

An unexpected column is observed but not listed in the expected schema.

It could be:

- an intentional additive change
- an accidental upstream change
- a renamed column appearing under a new name
- a field that affects `SELECT *` consumers
- a problem for fixed-schema exports

Unexpected columns should be reviewed, not automatically rejected.

## Renamed Column

A renamed column often appears as one removed column plus one added column. For example, `customer_id` may disappear and `customer_identifier` may appear.

Semantic similarity may suggest a rename, but SQL alone should not automatically decide that the meaning is identical. Human and business review are needed.

## Removed Column

A removed column can be breaking. Downstream queries may fail, reports may lose fields, and extracts may no longer match their expected layouts.

## Data Types

Day 037 uses simple generic type families:

- integer-like
- decimal or numeric
- text or string
- date
- timestamp
- boolean-like

Exact type names vary by SQL platform, so this lesson uses supplied schema CSV files instead of platform-specific metadata tables.

## Type Changes

Type changes should be reviewed carefully:

- integer to decimal may be compatible in some contexts but still changes precision expectations
- integer to text can break numeric calculations
- text to integer can fail when text contains non-numeric values
- date to timestamp can affect grouping
- timestamp to date can remove time detail
- wider or narrower text lengths can affect exports
- numeric precision changes can affect rounding

Do not assume universal compatibility rules.

## Nullability Expectations

Nullability metadata describes whether a column is allowed to contain nulls. Actual row-level null values are a separate completeness check.

> Schema nullability metadata and actual null values are related but not identical checks.

For example, a column may be marked nullable even if today it has no null values. Another column may be marked non-nullable but still need data-quality validation in some source environments.

## Semantic Drift

Semantic drift means the business meaning changes even if the column name and type stay the same.

Examples:

- `order_amount` changes from gross amount to net amount
- `status` codes change meaning
- `customer_id` changes source system

Pure schema comparison may not detect semantic drift.

## Column Order Caution

SQL consumers should prefer explicit column names. Relying on column position is fragile because a new or reordered column can change outputs.

Some exports are still position-sensitive, so position changes should be reviewed, but column order should not be the primary contract.

## Schema Drift

Schema drift is a structural difference between expected and observed schema. It can be small, such as a new audit column, or risky, such as a removed required key.

## Additive Changes

Additive changes add structure, such as:

- a new optional audit column
- a new descriptive column
- a new source-system column

Additive changes are not automatically defects, but they can affect consumers using `SELECT *` or fixed column exports.

## Potentially Breaking Changes

Potentially breaking changes include:

- required column removed
- required column renamed
- incompatible type change
- key column removed
- nullability becoming more permissive or restrictive
- semantic meaning changing

## Consumer Impact

Consumers include:

- reporting queries
- analyst queries
- downstream views
- extracts
- application reports
- validation reports

Consumer impact review asks: who depends on this schema, and what could break?

## Safe Schema-Validation Workflow

1. Define expected schema.
2. Capture observed schema.
3. Compare column names.
4. Identify missing required columns.
5. Identify missing optional columns.
6. Identify unexpected columns.
7. Compare data types.
8. Compare nullability expectations.
9. Review possible renames.
10. Review consumer dependencies.
11. Classify the change.
12. Create schema exceptions.
13. Produce validation summary.
14. Document review outcome.

## Common Mistakes

- relying on column order
- having no expected schema
- having no required or optional distinction
- treating every extra column as failure
- ignoring `SELECT *` consumers
- assuming rename automatically
- assuming type change is safe
- comparing raw type strings without normalisation
- confusing actual nulls with nullability metadata
- ignoring semantic meaning
- ignoring consumer impact
- using platform-specific metadata too early
- reporting drift without severity
- mixing schema validation with migration

## Required Warnings

> A schema match does not prove that the data values are correct. Schema validation checks structure, not full data quality.

> A missing, renamed, removed, or type-changed column can break downstream consumers even when the source query still runs successfully.

> An unexpected column is not automatically a defect. It may be an intentional additive change, but downstream consumers should still be reviewed.

> Schema validation should detect and report structural changes. It should not automatically alter tables, rename columns, or migrate data.

