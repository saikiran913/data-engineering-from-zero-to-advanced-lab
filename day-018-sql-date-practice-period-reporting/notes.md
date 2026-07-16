# Day 018 Notes

## Big Idea

Day 018 practises date reporting at a monthly level. A monthly report summarises many daily records into a smaller business-friendly view.

## Reporting Grain

Grain means the level of detail in a result.

| Grain | Meaning | Example |
| --- | --- | --- |
| Daily | One result per date | Sales by `order_date` |
| Monthly | One result per year and month | Sales by June 2026 |
| Country-month | One result per country per month | UK sales in June 2026 |
| Channel-month | One result per channel per month | Search revenue in July 2026 |

## Why Year and Month Go Together

Do not group by month alone. Month `6` could mean June 2025, June 2026, or June in another year. Group by year and month together.

## One-Month Filter

Use start-inclusive and end-exclusive logic:

```sql
WHERE order_date >= '2026-06-01'
AND order_date < '2026-07-01'
```

This means June 1 is included and July 1 is excluded.

## Period Comparison

A period comparison compares one reporting window with another.

Beginner approach:

1. Run one query for period A.
2. Run one query for period B.
3. Compare the outputs manually.

## Monthly Quality Checks

Common monthly checks:

- latest summary period
- failed monthly pipeline runs
- zero monthly orders
- low monthly sales
- high failed payments
- duplicate-looking summary rows
- missing-looking months

## HAVING Reminder

`HAVING` filters grouped results. Day 018 uses it only for duplicate summary checks.

## Business Context

A low month is not always a data problem. It might be a seasonal pattern, an incomplete month, or a campaign pause. Always combine SQL checks with business context.
