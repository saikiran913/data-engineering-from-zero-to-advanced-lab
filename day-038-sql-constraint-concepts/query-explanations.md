# Day 038 Query Explanations

Day 038 uses read-only SQL to validate constraint-like rules. The queries do not create constraints; they produce evidence for review.

## Primary-Key-Like Validation

Business purpose: check whether a candidate key identifies one row.

Grain: one row per customer, order, or payment.

Evidence: row count, non-null key count, distinct key count, duplicate key rows, and null key rows.

Common risk: checking uniqueness but forgetting that the key should also be required.

## Composite-Key Validation

Business purpose: show how multiple columns can define a grain.

Grain: a combination such as `payment_id + order_id` or a conceptual `order_id + line_number`.

Evidence: grouped counts using more than one column.

Common risk: choosing columns that do not actually describe the intended row grain.

## Foreign-Key-Like Validation

Business purpose: find child records with missing parent records.

Relationship: `customers -> orders` and `orders -> payments`.

Evidence: left joins that keep the child row and show missing parent matches.

Common risk: using an inner join, which hides orphan rows instead of reporting them.

## Unique-Rule Validation

Business purpose: check additional uniqueness rules, such as product code uniqueness.

Grain: one row per product.

Evidence: grouped duplicate counts and duplicate rows with audit context.

Common risk: confusing a unique rule with a primary key rule.

## Check-Rule Validation

Business purpose: validate documented allowed values and ranges.

Evidence: unsupported statuses, negative amounts, zero prices, and other condition failures.

Common risk: treating a sample range rule as universal business truth.

## Not-Null Validation

Business purpose: identify required fields that are missing.

Evidence: rows where key or reporting fields are null.

Common risk: confusing null with blank text. Blank-string handling varies by platform and source.

## Parent-Child Review

Business purpose: understand relationships beyond simple orphan checks.

Evidence: customers with no orders, orders with no payments, and child counts per parent.

Common risk: assuming every parent must have children without a business rule.

## Constraint Exceptions

Business purpose: turn violations into review-queue rows.

Output fields: table name, entity key, constraint concept, issue type, expected rule, actual result, severity, audit fields, and review message.

Common risk: reporting a violation without enough context for investigation.

## Integrated Workflow

The integrated workflow combines:

1. null customer keys
2. duplicate order keys
3. orphan order customers
4. orphan payment orders
5. unsupported order statuses
6. missing product codes

`UNION ALL` is used because every violation row should be preserved for review.

## Platform Note

Constraint syntax and enforcement differ by SQL platform. Validation queries remain useful even when a database does not enforce every declared rule.

