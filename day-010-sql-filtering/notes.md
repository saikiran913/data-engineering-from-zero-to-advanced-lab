# Day 010 Notes - SQL Filtering

## WHERE Review

`WHERE` filters rows from a table. It returns only records that match the condition.

```sql
SELECT *
FROM orders
WHERE payment_status = 'Failed';
```

## Comparison Operators

Comparison operators are used inside `WHERE`.

| Operator | Meaning | Example |
| --- | --- | --- |
| `=` | Equals | `country = 'UK'` |
| `!=` | Not equal | `country != 'UK'` |
| `<>` | Not equal | `country <> 'UK'` |
| `>` | Greater than | `order_amount > 500` |
| `<` | Less than | `price < 50` |
| `>=` | Greater than or equal to | `order_date >= '2026-06-01'` |
| `<=` | Less than or equal to | `price <= 100` |

## AND

`AND` means all conditions must be true.

```sql
SELECT *
FROM customers
WHERE country = 'UK'
AND customer_status = 'Active';
```

## OR

`OR` means at least one condition must be true.

```sql
SELECT *
FROM orders
WHERE order_status = 'Cancelled'
OR order_status = 'Returned';
```

## AND vs OR

Use `AND` when every rule must match. Use `OR` when any one rule can match.

## Parentheses with AND and OR

Parentheses make mixed logic clearer.

```sql
SELECT *
FROM orders
WHERE country = 'UK'
AND (payment_status = 'Failed' OR payment_status = 'Refunded');
```

## IN

`IN` checks whether a value appears in a list.

```sql
SELECT *
FROM customers
WHERE country IN ('UK', 'India', 'USA');
```

It is cleaner than many `OR` conditions.

## BETWEEN

`BETWEEN` filters a numeric or date range.

```sql
SELECT *
FROM orders
WHERE order_amount BETWEEN 100 AND 500;
```

`BETWEEN` usually includes the boundary values.

## LIKE

`LIKE` searches for a text pattern.

```sql
SELECT *
FROM products
WHERE product_name LIKE '%Book%';
```

`%` means any number of characters.

| Pattern | Meaning |
| --- | --- |
| `'SQL%'` | Starts with SQL |
| `'%Book'` | Ends with Book |
| `'%Sale%'` | Contains Sale |

Case sensitivity may vary by database.

## IS NULL

`IS NULL` finds missing values.

```sql
SELECT *
FROM customers
WHERE email IS NULL;
```

Do not use `= NULL`.

## IS NOT NULL

`IS NOT NULL` finds values that are available.

```sql
SELECT *
FROM customers
WHERE email IS NOT NULL;
```

## Filtering Text Values

Text values usually use single quotes.

```sql
WHERE customer_status = 'Active'
```

## Filtering Numeric Values

Numbers usually do not need quotes.

```sql
WHERE order_amount > 500
```

## Filtering Date Values

Dates are often written in quotes.

```sql
WHERE order_date BETWEEN '2026-06-01' AND '2026-06-30'
```

Date handling can vary by SQL tool.

## Filtering Boolean Values

Boolean values may use `true` and `false`, but exact syntax can vary.

```sql
WHERE marketing_opt_in = true
```

## Filtering Missing Values

Use `IS NULL` for missing values and `IS NOT NULL` for available values.

## Combining Filters

Filtering often combines multiple ideas.

```sql
SELECT order_id, country, order_amount
FROM orders
WHERE country IN ('UK', 'India', 'USA')
AND payment_status = 'Paid'
AND order_amount > 500
ORDER BY order_amount DESC;
```

## Filtering in Data Quality Checks

Filters help find missing emails, missing delivery dates, failed payments, unexpected statuses, and suspicious ranges.

## Filtering in ETL/ELT

Filters help keep valid records, separate invalid records, process only a date range, and prepare clean outputs.

## Filtering in Batch Pipelines

Batch pipelines often filter by date.

```sql
SELECT *
FROM orders
WHERE order_date = '2026-06-15';
```

## Common Mistakes

- Using `= NULL`
- Forgetting quotes around text
- Mixing `AND` and `OR` without parentheses
- Using `IN` without parentheses
- Forgetting the upper value in `BETWEEN`
- Forgetting `%` with `LIKE`
- Filtering the wrong column
- Assuming all databases handle text case the same way

## Daily Data Engineering Use

Data engineers use filters to investigate issues, validate pipeline outputs, prepare transformation logic, review recent records, and support dashboard troubleshooting.

