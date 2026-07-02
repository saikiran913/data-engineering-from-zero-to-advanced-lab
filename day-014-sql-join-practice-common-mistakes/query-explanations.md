# Query Explanations for Day 014

## INNER JOIN Practice

`INNER JOIN` returns matched rows only. The practice queries use it to enrich orders with customer names, order items with product details, payments with order details, tickets with customer details, and campaigns with performance rows.

## LEFT JOIN Practice

`LEFT JOIN` preserves the left table. It is used when the query needs all customers, all orders, all products, all campaigns, or all payments even when the related table has no match.

## Missing Relationship Checks

`LEFT JOIN` plus `IS NULL` finds missing matches. Examples include orders with unknown customers, order items with unknown products, payments with unknown orders, tickets with unknown customers, and campaign performance with unknown campaign IDs.

## JOINs with Filtering

`WHERE` filters the joined result. A filter like `WHERE o.payment_status = 'Paid'` keeps paid order rows. Be careful when filtering right-table columns after a `LEFT JOIN`, because it can remove unmatched rows.

## JOINs with Aggregation

Beginner aggregation after joins can count orders by customer, sum order amounts by customer, count tickets by customer, sum payments by method, and calculate campaign revenue by campaign name.

## Row Count Investigation

Row counts can increase after one-to-many joins, such as customers to orders or orders to order items. Row counts can decrease after `INNER JOIN` because unmatched rows are removed.

## Multi-Table JOIN Practice

Multi-table joins follow relationship chains. For example, customers connect to orders, orders connect to order items, and order items connect to products. Add one join at a time and check results.

## Common Mistake Explanations

- Missing `ON`: SQL does not know the intended relationship.
- Wrong key: technically valid output can be business-wrong.
- Wrong join type: `INNER JOIN` hides unmatched records.
- Wrong left table: `LEFT JOIN` preserves the table after `FROM`.
- Ambiguous columns: use aliases and prefixes.
- `SELECT *`: output can become noisy and confusing.
- Row multiplication: one-to-many relationships create multiple rows.
- Filtering after `LEFT JOIN`: `WHERE` can remove unmatched rows.
- `NULL` checks: use `IS NULL`, not `= NULL`.
- Undocumented logic: future readers may not know the business reason.
