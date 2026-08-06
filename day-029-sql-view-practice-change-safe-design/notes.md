# Day 029 Notes - Change-Safe View Design

## Views as Interfaces

A view is not only query logic. It is also an interface consumed by reports, dashboards, scheduled extracts, analyst queries, applications, and other views. When an interface changes, consumers can be affected.

## Upstream Dependencies

Views can depend on source tables, source columns, source data types, source grain, source filters, and source views. If an upstream column is renamed or its meaning changes, a view can break or return different results.

## Downstream Consumers

Downstream consumers include reports, dashboards, scheduled extracts, analyst queries, other views, and applications. Day 029 uses generic consumer metadata to practise impact review.

## Column Contract

Consumers may depend on column name, data type, nullability behaviour, business meaning, format, presence, absence, and sometimes column order. Relying on order is risky, but some exports and fixed schemas still do it.

## Output Grain Contract

One row per order is different from one row per order-payment attempt. One row per customer-month is different from one row per customer. Grain changes can be high-risk because row counts and totals often change.

## Change Categories

| Change | Typical risk |
|---|---|
| Add column | Fixed-schema consumers may be affected |
| Remove column | Reports can fail |
| Rename column | Queries referencing the old name can fail |
| Change type | Calculations or comparisons can fail |
| Change filter | Records can be added or removed |
| Change join | Rows can multiply or disappear |
| Change aggregation | Grain and totals can change |
| Change business rule | Meaning can change silently |
| Change grain | Keys, counts, and totals can change |
| Change null handling | Distributions and filters can change |

## Breaking Versus Lower-Risk Changes

Risk depends on consumers and platform behaviour. Do not call any change universally safe. Even adding a column can affect consumers that use `SELECT *` or fixed column positions.

## Why Common Changes Are Risky

Renaming is risky because consumers may reference the old name. Filters are risky because they change included records. Joins are risky because they can multiply or remove rows. Aggregations are risky because they change output grain. Null handling is risky because it can change grouping, filtering, and totals. Business meaning is risky when the same alias starts to mean something different.

## Dependency Map

```text
source tables
   |
clean view
   |
reporting view
   |
dashboard / analyst query
```

## Validation Dimensions

Validate row count, distinct key count, duplicate keys, null counts, totals, minimum and maximum dates, status distribution, representative samples, excluded records, and unmatched joins.

## Old-Versus-New Comparison

1. Represent old logic as one CTE.
2. Represent proposed logic as another CTE.
3. Compare rows, keys, totals, nulls, dates, and samples.
4. Review differences.
5. Document expected differences.

## Regression Testing Concept

Regression validation checks whether previously expected behaviour remains stable after a proposed change. Some differences may be expected, but they still need explanation.

## Representative Samples

Aggregate validation is not enough. A row-level sample helps show which records changed and whether the change makes business sense.

## Consumer Review

Document consumer name, expected columns, expected grain, critical fields, query or refresh pattern, owner role, and change sensitivity.

## Change-Safe Workflow

1. Document current view.
2. Identify sources.
3. Identify consumers.
4. Define proposed change.
5. Classify risk.
6. Create old and new queries.
7. Compare metrics.
8. Inspect samples.
9. Document expected differences.
10. Obtain review.
11. Deploy outside this learning scope.
12. Validate after deployment.

## Common Mistakes

Common mistakes include assuming SQL success means safe, having no consumer list, not documenting grain, changing aliases casually, changing joins without row-count checks, changing filters without excluded-row review, changing aggregation without reconciliation, using `SELECT *`, deep dependency chains, no sample checks, no null comparison, no date-boundary comparison, and not communicating business meaning.
