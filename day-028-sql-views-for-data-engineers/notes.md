# Day 028 Notes - SQL Views

## What Is a SQL View?

A SQL view is a named query definition. After a view is created in a database, it can usually be queried like a table:

```sql
CREATE VIEW active_customers_view AS
SELECT
    customer_id,
    customer_name,
    country
FROM raw_customers
WHERE customer_status = 'ACTIVE';
```

`CREATE VIEW active_customers_view AS` gives the query a reusable name. The `SELECT` defines which columns and rows the view should expose. The `WHERE` clause keeps only active customers.

Then a consumer can query:

```sql
SELECT *
FROM active_customers_view;
```

In a real reusable view, explicit columns are safer than `SELECT *`. It is shown here only to demonstrate that a view can be queried like a table.

## View Versus Table

| Feature | Standard View | Table |
|---|---|---|
| Stores data | Usually no separate copy | Yes |
| Stores query definition | Yes | No |
| Survives after statement | Yes | Yes |
| Depends on other objects | Yes | Not always |
| Common purpose | Reusable interface | Stored rows |
| Refresh behaviour | Usually evaluated when queried | Data changes when loaded or modified |

Platform behaviour can vary, especially for special view types.

## View Versus CTE

A CTE exists for one statement. A view remains as a named database object after creation. Use a CTE to organise one query. Use a view when the same logic should be reused by later statements or consumers.

## View Versus Subquery

A subquery is embedded inside another query. A view is named and reusable. Both represent query logic, but a view can become a stable interface.

## View Versus Materialized View

A standard view normally evaluates source logic when queried. A materialized view may store a result physically. Refresh rules and support vary across platforms. Materialized views are out of scope for Day 028.

## Why Use a View?

Views can provide reusable logic, simpler consumer queries, controlled column exposure, consistent calculations, cleaner reporting interfaces, fewer repeated joins, and stable business-facing names.

## View Output Grain

Every view should document what one row represents:

- one row per customer
- one row per order
- one row per customer-month
- one row per campaign-date-country-channel

## View Columns

Choose columns intentionally. Use clear aliases for derived columns. Avoid duplicate names and unexplained abbreviations. Retain useful audit fields, and avoid exposing unnecessary sensitive fields such as email addresses in public reporting views.

## Why Avoid `SELECT *`

`SELECT *` is risky because source schema changes can alter view output, expose new fields, change column order, break consumers, and reduce clarity.

## Views Built From Joins

Views can join tables, but the output grain depends on the relationship. If a customer has duplicate versions or an order has multiple payment attempts, rows may multiply. Document the join key, join type, and expected grain.

## Views Built From Aggregations

Aggregated views change grain. A raw order table might have one row per order version, while a customer summary view has one row per customer.

## Views Built With CTEs

CTEs can make a view definition easier to read. The CTEs become part of the saved view logic.

## Ordering In Views

Row order is not guaranteed unless the consuming query uses `ORDER BY`. Avoid relying on an `ORDER BY` inside a view definition. Platform support varies.

## Data Quality, Security, and Performance

A view can expose cleaned data, but it should not silently hide unresolved issues without documentation. A view may limit exposed columns, but permission behaviour varies by SQL platform. Shorter consumer SQL does not guarantee faster execution.

## Dependencies

Views depend on base tables, source columns, other views, and any functions used. Upstream schema changes can break a view or change its results.

## View Validation Workflow

1. Run the underlying `SELECT`.
2. Inspect row count.
3. Inspect grain.
4. Inspect keys.
5. Inspect nulls.
6. Inspect duplicates.
7. Reconcile totals.
8. Inspect derived columns.
9. Create or review the view definition.
10. Query the view.
11. Compare view output with the source query.
12. Document dependencies.

## Naming Guidance

Names such as `vw_active_customers`, `vw_order_details`, `vw_customer_sales_summary`, and `vw_campaign_daily_reporting` are clear. Prefixes are optional and team standards vary.

## Common Mistakes

Common mistakes include using `SELECT *`, unclear names, undocumented grain, duplicate column names, row multiplication, hidden null handling, relying on view row order, assuming views store data, assuming views improve performance, assuming views provide complete security, deep view chains, broken consumers after column renames, and creating views without validation.
