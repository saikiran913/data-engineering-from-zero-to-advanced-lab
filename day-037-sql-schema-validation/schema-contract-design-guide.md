# Schema Contract Design Guide

## Start with the Validation Rule

Write the rule in plain language before writing SQL. Example: every required expected column must appear in the observed schema.

## Define Exception Level

| Level | Use when |
|---|---|
| Schema | The issue affects the dataset structure |
| Column | The issue affects one column contract |
| Consumer | The issue affects a downstream user |
| Summary | The issue is aggregated for review |

## Define Stage

State whether the schema belongs to source, clean, reporting, or another interface. Day 037 uses expected schema, observed V1, and observed V2.

## Define Entity Key

The entity key should identify what is affected. For schema validation, this is often `column_name`. For consumer impact, it may be `consumer_id`.

## Define Issue Category

Use controlled categories such as:

- `MISSING_COLUMN`
- `UNEXPECTED_COLUMN`
- `TYPE_MISMATCH`
- `NULLABILITY_MISMATCH`
- `POSSIBLE_RENAME`
- `REMOVED_COLUMN`
- `POSITION_CHANGE`
- `CONSUMER_IMPACT`
- `SEMANTIC_REVIEW`

## Define Issue Type

Issue type should be specific, such as `MISSING_REQUIRED_COLUMN` or `ORDER_AMOUNT_TYPE_CHANGED`.

## Define Expected Value

Expected value comes from the contract. It may be an expected column name, type, nullability flag, or position.

## Define Actual Value

Actual value comes from the observed schema. If a column is missing, a text value such as `COLUMN_NOT_PRESENT` can make the output easier to read.

## Define Difference

For schema validation, the difference is often a label such as `TYPE_CHANGED`, `ADDED_IN_V2`, or `REMOVED_IN_V2`.

## Define Severity Rule

Simple beginner severity rules:

| Severity | Use when |
|---|---|
| `HIGH_REVIEW` | Required, key, high-sensitivity, or likely breaking change |
| `REVIEW` | Needs human review but may not be urgent |
| `INFO` | Likely informational additive change |

## Define Audit Context

Useful context includes schema version, observed timestamp, expected position, observed position, and source interface.

## Define Review Message

A review message should explain the issue and the next action in one clear sentence.

## Define Duplicate-Exception Key

A useful duplicate key may include:

- exception level
- comparison scope
- entity key
- issue category
- issue type

## Define Summary Dimensions

Useful summaries include:

- severity
- issue category
- change type
- schema version
- consumer sensitivity
- required flag

## Reusable Rule Template

| Field | Example |
|---|---|
| Rule ID | `SVR001` |
| Rule name | Required column must exist |
| Stage | Expected to observed V2 |
| Exception level | Schema |
| Source object | `expected_order_schema` |
| Target object | `observed_order_schema_v2` |
| Grain | One row per affected column |
| Entity key | `column_name` |
| Issue category | `MISSING_COLUMN` |
| Issue type | `MISSING_REQUIRED_COLUMN` |
| Expected condition | Required expected column appears in observed schema |
| Expected value | Expected column and type |
| Actual value | Observed column or missing marker |
| Severity rule | Required missing columns are `HIGH_REVIEW` |
| Evidence fields | Expected type, observed type, nullable flags |
| Source/audit fields | Source version, observed timestamp |
| Review message | Required column is missing from observed schema |
| Duplicate key | Level, scope, entity key, category, type |
| Owner role | Data engineering or reporting owner |
| Review date | Date when review is performed |

