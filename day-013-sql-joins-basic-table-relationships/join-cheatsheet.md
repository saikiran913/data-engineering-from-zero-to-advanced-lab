# Day 013 SQL JOIN Cheatsheet

## Basic INNER JOIN Pattern

```sql
SELECT
  a.column_name,
  b.column_name
FROM table_a AS a
INNER JOIN table_b AS b
ON a.key_column = b.key_column;
```

## Basic LEFT JOIN Pattern

```sql
SELECT
  a.column_name,
  b.column_name
FROM table_a AS a
LEFT JOIN table_b AS b
ON a.key_column = b.key_column;
```

## INNER JOIN Meaning

Only matching rows from both tables.

## LEFT JOIN Meaning

All rows from the left table, plus matching rows from the right table. Missing right-side values appear as `NULL`.

## Table Alias Pattern

```sql
table_name AS short_name
```

Examples:

- `customers AS c`
- `orders AS o`
- `products AS p`
- `order_items AS oi`
- `campaigns AS ca`
- `campaign_performance AS cp`

## ON Condition

`ON` tells SQL how two tables are connected.

## Common Relationship Examples

| Relationship | Join Condition |
| --- | --- |
| customers to orders | `c.customer_id = o.customer_id` |
| orders to order_items | `o.order_id = oi.order_id` |
| products to order_items | `p.product_id = oi.product_id` |
| campaigns to campaign_performance | `ca.campaign_id = cp.campaign_id` |

## Missing Match Pattern

```sql
SELECT
  left_table.key_column,
  right_table.key_column
FROM left_table
LEFT JOIN right_table
ON left_table.key_column = right_table.key_column
WHERE right_table.key_column IS NULL;
```

This finds left table rows with no matching right table row.

## Beginner Best Practices

- Understand table relationships before joining.
- Always write the `ON` condition carefully.
- Use table aliases.
- Prefix columns with table aliases.
- Check row counts before and after joins.
- Start with fewer columns.
- Use `LIMIT` while exploring.
- Use `LEFT JOIN` for missing relationship checks.
- Do not assume matching column names always mean correct relationship.
- Document important join logic.
