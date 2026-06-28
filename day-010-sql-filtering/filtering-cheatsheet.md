# Day 010 SQL Filtering Cheatsheet

## Basic WHERE

```sql
SELECT columns
FROM table
WHERE condition;
```

## AND

```sql
WHERE condition1
AND condition2;
```

All conditions must be true.

## OR

```sql
WHERE condition1
OR condition2;
```

At least one condition must be true.

## Parentheses

```sql
WHERE condition1
AND (condition2 OR condition3);
```

Parentheses make mixed `AND` and `OR` logic safer.

## IN

```sql
WHERE column_name IN ('value1', 'value2', 'value3');
```

## BETWEEN

```sql
WHERE numeric_column BETWEEN 100 AND 500;
```

```sql
WHERE date_column BETWEEN '2026-06-01' AND '2026-06-30';
```

## LIKE

```sql
WHERE text_column LIKE 'SQL%';
```

Starts with SQL.

```sql
WHERE text_column LIKE '%Book';
```

Ends with Book.

```sql
WHERE text_column LIKE '%Sale%';
```

Contains Sale.

## IS NULL

```sql
WHERE column_name IS NULL;
```

## IS NOT NULL

```sql
WHERE column_name IS NOT NULL;
```

## Common Filter Examples

| Business Question | SQL Filter Example |
| --- | --- |
| Active customers | `customer_status = 'Active'` |
| Failed payments | `payment_status = 'Failed'` |
| High-value orders | `order_amount > 500` |
| Orders in a date range | `order_date BETWEEN '2026-06-01' AND '2026-06-30'` |
| Products containing Book | `product_name LIKE '%Book%'` |
| Missing email | `email IS NULL` |
| Selected countries | `country IN ('UK', 'India', 'USA')` |
| Selected statuses | `order_status IN ('Cancelled', 'Returned')` |

## Beginner Best Practices

- Use `LIMIT` when exploring.
- Use parentheses when mixing `AND` and `OR`.
- Use `IN` instead of many `OR` conditions.
- Use `IS NULL` for missing values.
- Be careful with date ranges.
- Check exact column names.
- Use readable formatting.
- Test filters step by step.
- Do not assume every database treats text case the same.
- Document important business filters.

