# Day 030 Review Notes

## What Is a Table?

A table stores rows. It has a defined schema and persists beyond one query. A table may represent raw, clean, or reporting data. Production table design also involves permissions, storage, ownership, and lifecycle decisions, which are outside Day 030.

## What Is a View?

A view stores query logic. It can be queried like a table in a `SELECT`, depends on underlying objects, and usually does not store a copied result.

## What Is a CTE?

A CTE is a named query step used inside one statement. It is good for readability and step-by-step logic, but it is not reusable across separate statements.

## What Is a Subquery?

A subquery is a query inside another query. It is useful for smaller embedded logic, such as filtering against a calculated result.

## Comparison Table

| Feature | Table | View | CTE | Subquery |
|---|---|---|---|---|
| Persists | Yes | Yes as object logic | No | No |
| Stores rows | Yes | Usually no | No | No |
| Stores query definition | Not usually | Yes | Inside one statement | Inside another query |
| Reusable across statements | Yes | Yes | No | No |
| Dependency risk | Source and load process | Underlying objects | Current statement inputs | Parent query inputs |
| Typical consumer | pipeline, report, analyst | report, analyst, downstream query | query author | query author |
| Suitable for one-time logic | Sometimes too much | Usually too much | Yes | Yes |
| Suitable for stored history | Yes | No | No | No |
| Suitable for reporting interface | Yes, if stored output needed | Yes, if live logic is enough | No | No |
| Suitable for readable multi-step logic | Sometimes | Sometimes | Yes | Limited |

## Raw, Clean, and Reporting Layers

Raw tables preserve source-aligned history, audit fields, and replay ability. Clean tables or interfaces apply validation and standardisation with documented business rules. Reporting tables or views serve consumer needs with stable grain and clear metrics.

## When to Use a CTE

Use a CTE for multi-step validation, deduplication, aggregation before ranking, or one-off report logic inside one statement.

## When to Use a Subquery

Use a subquery for a smaller embedded step such as filtering against an average, checking existence, or using a small derived table.

## Persistence, Reuse, Freshness, and Auditability

Persistence means the result or object remains beyond one query. Reuse can be within one query or across many consumers. Views normally reflect underlying logic when queried, while tables contain stored results from a load or creation process. Raw history often belongs in stored tables because auditability matters.

## Dependencies and Consumers

Views and CTEs depend on upstream objects. Consumers may include pipelines, analysts, dashboards, extracts, validation processes, and application reports.

## Interface Decision Workflow

1. Define the business question.
2. Define source grain.
3. Define output grain.
4. Decide whether rows must be stored.
5. Decide whether logic must be reusable.
6. Decide whether history is required.
7. Identify consumers.
8. Identify dependencies.
9. Identify freshness needs.
10. Identify validation checks.
11. Choose the simplest suitable interface.
12. Document limitations.

## Common Mistakes

Common mistakes include using a view when history must be stored, creating a table for one small query step, using a CTE when many consumers need reuse, using deeply nested subqueries, exposing raw tables directly to every consumer, assuming a view is always current and fast, assuming a table is automatically trusted, undocumented grain, hidden dependencies, repeated logic across reports, no audit fields, no validation, and choosing technology before business requirements.
