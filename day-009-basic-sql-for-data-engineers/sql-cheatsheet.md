# Day 009 SQL Cheatsheet

## Basic SELECT

```sql
SELECT column_name
FROM table_name;
```

## Select All Columns

```sql
SELECT *
FROM table_name;
```

Use carefully on large tables.

## Select Multiple Columns

```sql
SELECT column1, column2
FROM table_name;
```

## Preview Rows

```sql
SELECT *
FROM table_name
LIMIT 10;
```

## Filter Rows

```sql
SELECT *
FROM table_name
WHERE column_name = 'value';
```

## Filter Numbers

```sql
SELECT *
FROM table_name
WHERE numeric_column > 100;
```

## Filter Dates

```sql
SELECT *
FROM table_name
WHERE date_column >= '2026-01-01';
```

## Sort Results

```sql
SELECT *
FROM table_name
ORDER BY column_name ASC;
```

```sql
SELECT *
FROM table_name
ORDER BY column_name DESC;
```

## Combine Clauses

```sql
SELECT column1, column2
FROM table_name
WHERE condition
ORDER BY column_name DESC
LIMIT 10;
```

## Comparison Operators

| Operator | Meaning | Example |
| --- | --- | --- |
| `=` | Equals | `country = 'UK'` |
| `!=` | Not equal | `country != 'UK'` |
| `<>` | Not equal | `country <> 'UK'` |
| `>` | Greater than | `order_amount > 100` |
| `<` | Less than | `price < 50` |
| `>=` | Greater than or equal to | `order_date >= '2026-06-01'` |
| `<=` | Less than or equal to | `price <= 100` |

## Best Practices for Beginners

- Start with `LIMIT`.
- Select only needed columns.
- Use clear formatting.
- Read error messages carefully.
- Check column names.
- Check table names.
- Use comments.
- Do not run large queries carelessly.

