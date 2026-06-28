# Day 010 - SQL Filtering with WHERE, AND, OR, IN, BETWEEN, LIKE, and IS NULL

## Learning Goal

By the end of Day 010, you will understand how to filter rows using `WHERE`, combine filters with `AND` and `OR`, use `IN`, `BETWEEN`, `LIKE`, `IS NULL`, and `IS NOT NULL`, and apply filters for simple data investigations and ETL or ELT logic.

## Connection to Day 009

Day 009 introduced basic SQL:

- `SELECT`
- `FROM`
- `WHERE`
- `ORDER BY`
- `LIMIT`

Day 010 focuses more deeply on filtering rows using `WHERE` and common filtering operators.

SQL syntax can vary slightly across tools such as BigQuery, PostgreSQL, SQL Server, MySQL, and SQLite, but the ideas in this lesson are widely used.

## Why Filtering Matters in Data Engineering

Data engineers rarely look at full tables directly. They filter data to:

- Investigate failed records
- Check missing values
- Find records from a specific country
- Review orders in a date range
- Inspect high-value transactions
- Find active or inactive records
- Identify cancelled or refunded orders
- Validate allowed status values
- Check recent data
- Prepare transformation logic

## Quick Reminder: WHERE

`WHERE` returns only rows that match a condition.

```sql
SELECT *
FROM orders
WHERE payment_status = 'Failed';
```

This query reads the `orders` table and returns only rows where `payment_status` is `Failed`.

## Comparison Operators Review

| Operator | Meaning | Example |
| --- | --- | --- |
| `=` | Equals | `country = 'UK'` |
| `!=` | Not equal | `country != 'UK'` |
| `<>` | Not equal | `country <> 'UK'` |
| `>` | Greater than | `order_amount > 500` |
| `<` | Less than | `price < 50` |
| `>=` | Greater than or equal to | `order_date >= '2026-06-01'` |
| `<=` | Less than or equal to | `price <= 100` |

## Filtering with AND

`AND` means all conditions must be true.

```sql
SELECT *
FROM orders
WHERE payment_status = 'Paid'
AND order_amount > 500;
```

This returns orders where payment status is paid and order amount is greater than 500.

Examples:

- Active customers from UK
- Paid orders above 500
- Products in Electronics category and active
- Campaigns in UK and Active

## Filtering with OR

`OR` means at least one condition must be true.

```sql
SELECT *
FROM orders
WHERE payment_status = 'Failed'
OR payment_status = 'Refunded';
```

This returns rows where either condition is true.

Examples:

- Customers from UK or India
- Orders Cancelled or Returned
- Products Out of Stock or Low Stock
- Campaigns Paused or Cancelled

## AND vs OR

| Concept | Meaning | Example Result |
| --- | --- | --- |
| AND | All conditions must match | Electronics products that are active |
| OR | Any condition can match | Products that are Electronics or Books |

Shopping example:

- Electronics AND active means the product must be both Electronics and active.
- Electronics OR Books means the product can be in either category.

## Why Parentheses Matter

When `AND` and `OR` are used together, parentheses make logic clear.

Less clear:

```sql
SELECT *
FROM orders
WHERE country = 'UK'
AND payment_status = 'Failed'
OR payment_status = 'Refunded';
```

Clearer and safer:

```sql
SELECT *
FROM orders
WHERE country = 'UK'
AND (payment_status = 'Failed' OR payment_status = 'Refunded');
```

The second query clearly means UK orders where payment status is either Failed or Refunded.

## Filtering with IN

`IN` is used when a column can match one value from a list.

```sql
SELECT *
FROM customers
WHERE country IN ('UK', 'India', 'USA');
```

This is cleaner than writing many `OR` conditions.

Equivalent `OR` version:

```sql
WHERE country = 'UK'
OR country = 'India'
OR country = 'USA'
```

`IN` examples:

- Customers from multiple countries
- Orders with multiple statuses
- Products from selected categories
- Campaigns from selected channels

## Filtering with BETWEEN

`BETWEEN` filters values within a range.

```sql
SELECT *
FROM orders
WHERE order_amount BETWEEN 100 AND 500;
```

```sql
SELECT *
FROM orders
WHERE order_date BETWEEN '2026-06-01' AND '2026-06-30';
```

`BETWEEN` usually includes both boundary values. Date behavior can vary slightly depending on database and timestamp type, so be careful with date and time columns.

Examples:

- Orders between 100 and 500
- Customers who signed up within a date range
- Campaigns active in a date range
- Products priced between 20 and 100

## Filtering with LIKE

`LIKE` searches for patterns in text.

The percent symbol `%` means any number of characters.

```sql
SELECT *
FROM products
WHERE product_name LIKE '%Book%';
```

```sql
SELECT *
FROM campaigns
WHERE campaign_name LIKE '%Sale%';
```

| Pattern | Meaning |
| --- | --- |
| `'SQL%'` | Starts with SQL |
| `'%Book'` | Ends with Book |
| `'%Book%'` | Contains Book |

Case sensitivity may vary by database.

## Filtering NULL Values

`NULL` means missing, unknown, or not available.

`NULL` is not the same as zero and not the same as an empty string.

Do not check `NULL` using `= NULL`.

Correct:

```sql
WHERE email IS NULL
```

Incorrect:

```sql
WHERE email = NULL
```

Blank CSV fields may be loaded as `NULL` depending on tool configuration.

## IS NULL

`IS NULL` finds missing values.

```sql
SELECT *
FROM customers
WHERE email IS NULL;
```

Examples:

- Customers with missing email
- Orders with missing delivery date
- Campaigns with missing end date

## IS NOT NULL

`IS NOT NULL` finds available values.

```sql
SELECT *
FROM customers
WHERE email IS NOT NULL;
```

Examples:

- Customers with available email
- Delivered orders with delivery date
- Campaigns with end date available

## Filtering Text, Numbers, Dates, and NULLs

| Data Type | Example Filter | Notes |
| --- | --- | --- |
| Text | `country = 'UK'` | Text usually uses single quotes |
| Number | `order_amount > 500` | Numbers usually do not need quotes |
| Date | `order_date >= '2026-06-01'` | Date syntax can vary by tool |
| Boolean | `marketing_opt_in = true` | Boolean syntax can vary by tool |
| NULL | `email IS NULL` | Use `IS NULL`, not `= NULL` |

## Combining Filters

### Active UK customers with email

```sql
SELECT customer_id, customer_name, country, email
FROM customers
WHERE country = 'UK'
AND customer_status = 'Active'
AND email IS NOT NULL;
```

### High-value paid orders

```sql
SELECT order_id, customer_id, order_amount, payment_status
FROM orders
WHERE payment_status = 'Paid'
AND order_amount > 500
ORDER BY order_amount DESC;
```

### Cancelled or returned orders in selected countries

```sql
SELECT order_id, country, order_status
FROM orders
WHERE country IN ('UK', 'India', 'USA')
AND order_status IN ('Cancelled', 'Returned');
```

### Products containing Book

```sql
SELECT product_id, product_name, category, price
FROM products
WHERE product_name LIKE '%Book%';
```

### Orders in a date range

```sql
SELECT order_id, order_date, order_amount
FROM orders
WHERE order_date BETWEEN '2026-06-01' AND '2026-06-30';
```

## SQL Filtering and Data Quality

Filtering helps find data quality issues such as:

- Missing email
- Missing delivery date
- Failed payments
- Cancelled orders
- Unexpected statuses
- Old or stale records
- Records from unknown countries

## SQL Filtering in ETL and ELT

Filters are used in transformation logic to:

- Keep only valid records
- Exclude cancelled orders from a revenue table
- Select only active products
- Process only new records for a date range
- Separate failed records for review
- Load only records from a specific source

## SQL Filtering in Batch Pipelines

A nightly batch pipeline may filter only yesterday's records.

```sql
SELECT *
FROM orders
WHERE order_date = '2026-06-15';
```

## SQL Filtering in Data Investigations

Common investigation tasks:

- Which payments failed?
- Which customers have missing emails?
- Which orders are high value?
- Which orders were cancelled?
- Which products are inactive?
- Which campaigns are active in a country?
- Which records belong to a specific date range?

## Common Beginner Mistakes

1. Using `= NULL` instead of `IS NULL`.
2. Forgetting quotes around text values.
3. Using quotes inconsistently for numbers.
4. Mixing `AND` and `OR` without parentheses.
5. Thinking `IN` and `BETWEEN` work the same way.
6. Forgetting that `BETWEEN` usually includes boundaries.
7. Assuming `LIKE` case sensitivity is the same in every database.
8. Using `LIKE` when exact match is better.
9. Forgetting that date formats can vary by database.
10. Writing too many `OR` conditions instead of using `IN`.
11. Filtering the wrong column.
12. Forgetting `LIMIT` while exploring large tables.

## Role of a Data Engineer

| Filtering Task | Data Engineering Use |
| --- | --- |
| Find failed payments | Investigate payment issues |
| Find missing emails | Check data quality |
| Find high-value orders | Review important transactions |
| Find records in a date range | Process batch windows |
| Find active customers | Prepare customer outputs |
| Find cancelled or returned orders | Exclude or review records |
| Find products by category | Prepare product feeds |
| Find inactive products | Investigate catalog issues |
| Find campaigns by channel | Review marketing data |
| Prepare clean data | Keep only valid records |
| Separate invalid data | Send bad records for review |
| Investigate dashboard issues | Check records behind reports |

## Beginner Analogy: Filtering an Online Shopping Website

When shopping online, users filter products by:

- Category
- Price range
- Brand
- Availability
- Rating
- Search keyword

SQL filtering is similar, but applied to data tables.

Examples:

```sql
category = 'Electronics'
price BETWEEN 100 AND 500
product_name LIKE '%Laptop%'
stock_status IN ('In Stock', 'Low Stock')
```

## Key Takeaways

- `WHERE` filters rows.
- `AND` means all conditions must be true.
- `OR` means at least one condition must be true.
- Parentheses make mixed logic safer.
- `IN` checks values against a list.
- `BETWEEN` checks values in a range.
- `LIKE` searches text patterns.
- `%` means any number of characters in a pattern.
- Use `IS NULL` to find missing values.
- Use `IS NOT NULL` to find available values.
- Text values usually need quotes.
- Numbers usually do not need quotes.
- Date syntax can vary by database.
- Filtering supports data quality and ETL/ELT logic.
- Data engineers use filters for investigations every day.

## Next Day Preview

Day 011 will introduce SQL Aggregations for Data Engineers: `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`, and `GROUP BY`.

## Navigation

- Previous: [Day 009 - Basic SQL for Data Engineers](../day-009-basic-sql-for-data-engineers/)
- Next: Day 011 - SQL Aggregations for Data Engineers - Coming Soon
- [Back to Main Learning Path](../README.md)

