# Constraint Design Guide

## Start with the Table Grain

Before choosing a key, define what one row represents. A customer table should have one row per customer. An order table should have one row per order.

## Choose Candidate Keys

A candidate key is a column or column combination that could identify one row.

Ask:

- Is it non-null?
- Is it unique?
- Does it match the grain?
- Is it stable enough for consumers?

## Decide the Constraint Concept

| Concept | Use when |
|---|---|
| Primary key | A column or combination identifies one row |
| Composite key | More than one column identifies one row |
| Foreign key | A child value should match a parent value |
| Unique | A non-key value should not duplicate |
| Check | Values should follow an allowed condition |
| Not null | A field is required |
| Validation-only | A business rule needs review but may not suit an enforced constraint |

## Document Relationships

| Parent table | Parent key | Child table | Child key | Relationship meaning | Null allowed? | Orphan allowed? |
|---|---|---|---|---|---|---|
| `customers` | `customer_id` | `orders` | `customer_id` | Order belongs to customer | No for this lesson | No for this lesson |
| `orders` | `order_id` | `payments` | `order_id` | Payment belongs to order | No for this lesson | No for this lesson |

## Define Validation Output

Include:

- table name
- entity key
- constraint concept
- issue type
- expected rule
- actual result
- severity
- source file
- loaded timestamp
- review message

## Severity Guidance

| Severity | Use when |
|---|---|
| `HIGH_REVIEW` | Missing key, duplicate key, orphan child, required field missing |
| `REVIEW` | Unsupported status, range issue, unique rule issue |
| `INFO` | Documented informational case |

## Design Template

| Field | Example |
|---|---|
| Table | `orders` |
| Grain | One row per order |
| Candidate key | `order_id` |
| Constraint concept | Primary key |
| Expected condition | `order_id` is non-null and unique |
| Nullable rule | Not null |
| Validation query | Null check plus duplicate check |
| Severity | `HIGH_REVIEW` |
| Exception output | One row per violation |
| Review message | Order key should identify one order |

