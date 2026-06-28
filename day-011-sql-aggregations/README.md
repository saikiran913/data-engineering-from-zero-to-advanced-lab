# Day 011 - SQL Aggregations for Data Engineers: COUNT, SUM, AVG, MIN, MAX, and GROUP BY

## Learning Goal

By the end of Day 011, you should understand how SQL can turn many rows into useful summary numbers. You will learn what aggregation means, why data engineers use it, how `COUNT`, `SUM`, `AVG`, `MIN`, and `MAX` work, and how `GROUP BY` creates separate summaries by country, status, category, channel, or date.

You will also see how filters from Day 010 can be combined with aggregation, how summary results can be sorted, and how aggregations support dashboards, reports, ETL/ELT transformations, and data quality validation.

SQL syntax may vary slightly across tools such as BigQuery, PostgreSQL, SQL Server, MySQL, and SQLite. The examples in this lesson use simple ANSI-style SQL so the main ideas are easy to transfer.

## Connection to Previous SQL Lessons

- Day 009 taught how to read data using `SELECT`, `FROM`, `WHERE`, `ORDER BY`, and `LIMIT`.
- Day 010 taught how to filter rows using `WHERE`, `AND`, `OR`, `IN`, `BETWEEN`, `LIKE`, and `IS NULL`.
- Day 011 now teaches how to summarise many rows into useful numbers.

## What is Aggregation?

Aggregation means combining many rows into a summary result.

For example, a table may contain thousands of individual order rows. Instead of reading every order one by one, a data engineer may ask:

- How many orders exist?
- What is the total sales amount?
- What is the average order amount?
- What is the highest order amount?
- What is the lowest product price?
- How many customers are in each country?
- How much revenue came from each channel?
- How many orders are in each status?

Aggregation is used heavily in dashboards, reports, data validation, and business metrics because businesses often need summary answers.

## Why Aggregations Matter in Data Engineering

Data engineers use aggregations to:

- Validate row counts.
- Check daily totals.
- Create reporting tables.
- Compare source and target data.
- Calculate business metrics.
- Build dashboard-ready outputs.
- Investigate unusual changes.
- Monitor pipeline output.
- Summarise large datasets.

## Simple Example Without GROUP BY

Some aggregations return one summary row.

```sql
SELECT COUNT(*) AS total_orders
FROM orders;
```

This query counts all rows in the `orders` table and returns one number called `total_orders`.

## COUNT

`COUNT` is used to count rows or values.

`COUNT(*)` counts all rows in the result.

```sql
SELECT COUNT(*) AS total_orders
FROM orders;
```

`COUNT(column_name)` counts rows where that column has a non-null value.

```sql
SELECT COUNT(email) AS customers_with_email
FROM customers;
```

The difference matters. If a customer row exists but the `email` value is missing, `COUNT(*)` still counts the row, but `COUNT(email)` does not count the missing email value.

## SUM

`SUM` adds numeric values together.

```sql
SELECT SUM(order_amount) AS total_order_amount
FROM orders;
```

```sql
SELECT SUM(cost) AS total_campaign_cost
FROM campaign_performance;
```

`SUM` is used for sales, cost, revenue, quantity, impressions, clicks, conversions, and other numeric metrics.

## AVG

`AVG` calculates the average of numeric values.

```sql
SELECT AVG(order_amount) AS average_order_amount
FROM orders;
```

```sql
SELECT AVG(cost) AS average_campaign_cost
FROM campaign_performance;
```

Average means total divided by count. For example, average order amount means total order amount divided by the number of order amounts included.

## MIN

`MIN` finds the smallest value.

```sql
SELECT MIN(order_amount) AS lowest_order_amount
FROM orders;
```

```sql
SELECT MIN(price) AS lowest_product_price
FROM products;
```

`MIN` can be used for numbers and dates. With dates, it can show the earliest date.

## MAX

`MAX` finds the largest value.

```sql
SELECT MAX(order_amount) AS highest_order_amount
FROM orders;
```

```sql
SELECT MAX(price) AS highest_product_price
FROM products;
```

`MAX` can also find the latest date in a column.

## Multiple Aggregations in One Query

```sql
SELECT
  COUNT(*) AS total_orders,
  SUM(order_amount) AS total_sales,
  AVG(order_amount) AS average_order_amount,
  MIN(order_amount) AS lowest_order_amount,
  MAX(order_amount) AS highest_order_amount
FROM orders;
```

This query returns one summary row:

- `total_orders` counts rows.
- `total_sales` adds order amounts.
- `average_order_amount` calculates the average order value.
- `lowest_order_amount` finds the smallest order.
- `highest_order_amount` finds the largest order.

## What is GROUP BY?

`GROUP BY` creates separate summaries for each unique value in a column.

```sql
SELECT country, COUNT(*) AS total_orders
FROM orders
GROUP BY country;
```

This counts orders separately for each country.

| country | total_orders |
| --- | --- |
| UK | 5 |
| India | 6 |
| USA | 4 |

`GROUP BY` changes one overall summary into multiple grouped summaries.

## GROUP BY Examples

### Orders by country

```sql
SELECT country, COUNT(*) AS total_orders
FROM orders
GROUP BY country;
```

This counts how many order rows exist for each country.

### Orders by order_status

```sql
SELECT order_status, COUNT(*) AS total_orders
FROM orders
GROUP BY order_status;
```

This counts orders separately for `Created`, `Shipped`, `Delivered`, `Cancelled`, and `Returned`.

### Total sales by country

```sql
SELECT country, SUM(order_amount) AS total_sales
FROM orders
GROUP BY country;
```

This adds order amounts separately for each country.

### Average order amount by country

```sql
SELECT country, AVG(order_amount) AS average_order_amount
FROM orders
GROUP BY country;
```

This calculates the average order value for each country.

### Products by category

```sql
SELECT category, COUNT(*) AS total_products
FROM products
GROUP BY category;
```

This counts products in each product category.

### Campaign cost by channel

```sql
SELECT channel, SUM(cost) AS total_cost
FROM campaign_performance
GROUP BY channel;
```

This adds campaign cost separately for channels such as Search, Social, Email, Display, and Affiliate.

## GROUP BY with ORDER BY

Grouped results can be sorted.

```sql
SELECT country, SUM(order_amount) AS total_sales
FROM orders
GROUP BY country
ORDER BY total_sales DESC;
```

This shows countries with the highest sales first.

## GROUP BY with WHERE

`WHERE` filters rows before aggregation.

```sql
SELECT country, SUM(order_amount) AS paid_sales
FROM orders
WHERE payment_status = 'Paid'
GROUP BY country
ORDER BY paid_sales DESC;
```

The logic is:

1. Read `orders`.
2. Keep only `Paid` rows.
3. Group by `country`.
4. Sum `order_amount`.
5. Sort results.

Business rules decide which rows should be included. For example, cancelled or refunded orders may need to be excluded from some totals.

## SQL Logical Order with Aggregation

For beginner aggregation queries, think about SQL in this logical order:

1. `FROM` chooses the table.
2. `WHERE` filters source rows.
3. `GROUP BY` creates groups.
4. `SELECT` chooses grouped columns and aggregation results.
5. `ORDER BY` sorts the final result.
6. `LIMIT` restricts how many final rows are returned.

Filtering aggregated results with `HAVING` will be covered later. Day 011 only uses `WHERE` to filter source rows before grouping.

## Aggregations and Dashboards

Dashboards often show aggregated numbers, such as:

- Total sales.
- Orders by country.
- Revenue by month.
- Clicks by channel.
- Average order value.
- Total campaign cost.
- Products by category.
- Active customers by country.

## Aggregations and Data Quality

Day 008 introduced data quality. Aggregations help validate data by checking:

- Row counts in source and target.
- Revenue totals in source and target.
- Failed payment counts.
- Missing email counts.
- Maximum transaction date to check freshness.
- Minimum and maximum values to detect unusual ranges.

## Aggregations and ETL/ELT

Day 005 introduced ETL and ELT. Aggregation can be part of transformation logic, such as:

- Creating a daily sales table.
- Creating a campaign performance summary.
- Creating a country-level customer summary.
- Creating a product category summary.
- Creating dashboard-ready metrics.

## Aggregations and Batch Processing

Day 006 introduced batch processing. A nightly batch pipeline may aggregate yesterday's orders into a daily sales summary.

```sql
SELECT order_date, SUM(order_amount) AS daily_sales
FROM orders
GROUP BY order_date
ORDER BY order_date;
```

## Common Beginner Mistakes

1. Forgetting `GROUP BY` when selecting non-aggregated columns.
2. Trying to use `WHERE` to filter aggregated values.
3. Confusing `COUNT(*)` and `COUNT(column_name)`.
4. Using `SUM` on text columns.
5. Using `AVG` on values that are not meaningful to average.
6. Forgetting that null values can affect `COUNT(column_name)`.
7. Expecting `GROUP BY` to keep every original row.
8. Sorting by the wrong column.
9. Forgetting aliases for aggregated columns.
10. Thinking aggregation and filtering are the same thing.
11. Using `SELECT *` with `GROUP BY`.
12. Not checking whether cancelled or refunded orders should be included in totals.

## Role of a Data Engineer

| Aggregation Task | Data Engineering Use |
| --- | --- |
| Count total rows | Confirm data loaded |
| Calculate total sales | Build revenue metrics |
| Calculate average order value | Support dashboard KPIs |
| Find min/max dates | Check freshness and date range |
| Summarise by country | Prepare regional reporting |
| Summarise by status | Monitor operational states |
| Summarise by channel | Analyse marketing performance |
| Compare source and target totals | Validate pipeline output |
| Prepare dashboard tables | Make reporting faster and simpler |
| Monitor pipeline output | Detect unusual changes |
| Investigate unusual changes | Find where metrics shifted |
| Support reporting teams | Provide reliable summary data |

## Beginner Analogy: Classroom Marks Summary

Imagine a class has many student mark records. A teacher may not want to read every row one by one. Instead, the teacher may count the number of students, calculate total marks, calculate average marks, find the highest mark, find the lowest mark, or group average marks by class.

SQL aggregation works in a similar way. It takes many detailed rows and returns summary answers.

## Beginner Analogy: Shop Daily Sales

A shop has many individual orders. Aggregation answers questions like:

- How many orders happened today?
- How much total sales happened?
- What was the average order value?
- Which country had highest sales?
- How many orders were cancelled?

## Key Takeaways

- Aggregation summarises many rows.
- `COUNT(*)` counts all rows.
- `COUNT(column_name)` counts non-null values in that column.
- `SUM` adds numeric values.
- `AVG` calculates an average.
- `MIN` finds the smallest value.
- `MAX` finds the largest value.
- `GROUP BY` creates one summary per group.
- Grouping columns can include country, status, category, channel, and date.
- `WHERE` filters rows before grouping.
- `ORDER BY` sorts the final summary result.
- Aliases make aggregation results easier to read.
- Dashboards depend heavily on aggregated metrics.
- Data quality checks often use counts, totals, and min/max dates.
- Business rules decide which rows should be included in metrics.

## Next Day Preview

Day 012 will introduce SQL `GROUP BY` with `HAVING` and beginner-level data quality summary checks.

## Navigation

- Previous: [Day 010 - SQL Filtering](../day-010-sql-filtering/)
- Next: Day 012 - SQL GROUP BY with HAVING and Data Quality Summary Checks - Coming Soon
- [Back to Main Learning Path](../README.md)
