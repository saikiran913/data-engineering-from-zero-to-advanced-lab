# Day 012 - SQL GROUP BY with HAVING and Data Quality Summary Checks

## Learning Goal

By the end of Day 012, you should understand how `HAVING` filters grouped results after aggregation. You will learn the difference between row-level filtering using `WHERE` and group-level filtering using `HAVING`, how to find groups with high counts, low counts, high totals, low totals, duplicate-looking values, suspicious status distributions, and summary patterns that may need investigation.

SQL syntax may vary slightly across BigQuery, PostgreSQL, SQL Server, MySQL, SQLite, and other tools. The examples here use simple ANSI-style SQL.

## Connection to Previous SQL Lessons

- Day 009 introduced reading data with `SELECT`, `FROM`, `WHERE`, `ORDER BY`, and `LIMIT`.
- Day 010 introduced filtering rows using `WHERE` and filtering operators.
- Day 011 introduced aggregations using `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`, and `GROUP BY`.
- Day 012 now explains how to filter aggregated and grouped results using `HAVING`.

## Quick Review: GROUP BY

`GROUP BY` creates a summary for each unique value or combination of values.

```sql
SELECT country, COUNT(*) AS total_orders
FROM orders
GROUP BY country;
```

This creates one row per country. Each country row has its own order count.

## What Problem Does HAVING Solve?

Sometimes we do not want all grouped results. We may want to show only:

- Countries with more than 5 orders.
- Channels with total revenue above 1000.
- Payment statuses with more than 10 records.
- Order IDs that appear more than once.
- Dates where total sales are below a threshold.
- Countries where failed payments are high.

`HAVING` filters grouped and aggregated results.

## What is HAVING?

`HAVING` is used to filter results after `GROUP BY` and aggregation.

```sql
SELECT country, COUNT(*) AS total_orders
FROM orders
GROUP BY country
HAVING COUNT(*) > 5;
```

Step by step:

1. Read rows from `orders`.
2. Group rows by `country`.
3. Count rows inside each country group.
4. Keep only country groups where the count is greater than 5.

## WHERE vs HAVING

`WHERE` filters individual rows before aggregation. `HAVING` filters grouped results after aggregation.

| Clause | Filters What? | Used Before or After GROUP BY? | Example |
| --- | --- | --- | --- |
| `WHERE` | Individual source rows | Before `GROUP BY` | Keep only `Paid` orders |
| `HAVING` | Grouped summary rows | After `GROUP BY` | Show countries where total sales are above 1000 |

Analogy: `WHERE` chooses which individual students are included before calculating class averages. `HAVING` chooses which classes are shown after averages are calculated.

## SQL Logical Order with HAVING

SQL is written in one order, but beginners can understand it using this logical order:

1. `FROM` chooses the table.
2. `WHERE` filters source rows.
3. `GROUP BY` creates groups.
4. `HAVING` filters grouped results.
5. `SELECT` displays columns and summary values.
6. `ORDER BY` sorts the final output.
7. `LIMIT` restricts the final output.

## Basic HAVING with COUNT

```sql
SELECT country, COUNT(*) AS total_orders
FROM orders
GROUP BY country
HAVING COUNT(*) > 5;
```

This returns only countries with more than 5 orders.

Other examples:

```sql
SELECT customer_status, COUNT(*) AS total_customers
FROM customers
GROUP BY customer_status
HAVING COUNT(*) > 3;
```

```sql
SELECT category, COUNT(*) AS total_products
FROM products
GROUP BY category
HAVING COUNT(*) > 2;
```

```sql
SELECT channel, COUNT(*) AS total_campaigns
FROM campaigns
GROUP BY channel
HAVING COUNT(*) > 2;
```

## HAVING with SUM

`HAVING` can filter grouped totals.

```sql
SELECT country, SUM(order_amount) AS total_sales
FROM orders
GROUP BY country
HAVING SUM(order_amount) > 1000;
```

This returns countries where total sales are above 1000.

You can also find channels with total revenue above 5000, countries with total campaign cost above 1000, or dates where total sales are below 100.

## HAVING with AVG

`HAVING` can filter grouped averages.

```sql
SELECT country, AVG(order_amount) AS average_order_amount
FROM orders
GROUP BY country
HAVING AVG(order_amount) > 250;
```

This returns countries where average order value is above 250.

## HAVING with MIN and MAX

`HAVING` can filter groups based on minimum or maximum values.

```sql
SELECT country, MAX(order_amount) AS highest_order
FROM orders
GROUP BY country
HAVING MAX(order_amount) > 700;
```

```sql
SELECT country, MIN(order_amount) AS lowest_order
FROM orders
GROUP BY country
HAVING MIN(order_amount) < 20;
```

These checks can help detect unusual high or low values.

## Combining WHERE, GROUP BY, and HAVING

`WHERE` filters rows first, `GROUP BY` summarises, and `HAVING` filters summary rows.

```sql
SELECT country, SUM(order_amount) AS paid_sales
FROM orders
WHERE payment_status = 'Paid'
GROUP BY country
HAVING SUM(order_amount) > 1000
ORDER BY paid_sales DESC;
```

Logic:

1. Read `orders`.
2. Keep only `Paid` rows.
3. Group paid orders by `country`.
4. Calculate total paid sales.
5. Keep only countries with paid sales above 1000.
6. Sort highest first.

## HAVING for Duplicate Checks

`GROUP BY` and `HAVING` can help find values that appear more than once.

```sql
SELECT order_id, COUNT(*) AS record_count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;
```

This may help find duplicate order IDs.

```sql
SELECT email, COUNT(*) AS email_count
FROM customers
WHERE email IS NOT NULL
GROUP BY email
HAVING COUNT(*) > 1;
```

This may help find repeated emails. Repeated values are not always wrong; business context matters.

## HAVING for Status Distribution Checks

Grouped status counts can reveal unusual patterns.

```sql
SELECT payment_status, COUNT(*) AS total_orders
FROM orders
GROUP BY payment_status
HAVING COUNT(*) > 5;
```

High failed, cancelled, or returned counts may point to source issues, business events, or pipeline concerns.

## HAVING for Daily Summary Checks

```sql
SELECT summary_date, country, SUM(total_orders) AS orders_count
FROM daily_order_summary
GROUP BY summary_date, country
HAVING SUM(total_orders) = 0;
```

This finds date and country groups with zero orders.

```sql
SELECT summary_date, country, SUM(failed_payments) AS failed_payment_count
FROM daily_order_summary
GROUP BY summary_date, country
HAVING SUM(failed_payments) > 5;
```

This finds potentially unusual failed payment counts.

## HAVING with Multiple Grouping Columns

`GROUP BY` can use more than one column.

```sql
SELECT order_date, country, COUNT(*) AS total_orders
FROM orders
GROUP BY order_date, country
HAVING COUNT(*) > 2;
```

This creates one summary per `order_date` and `country` combination.

## HAVING with ORDER BY and LIMIT

After filtering grouped results, we can sort and limit.

```sql
SELECT country, SUM(order_amount) AS total_sales
FROM orders
GROUP BY country
HAVING SUM(order_amount) > 500
ORDER BY total_sales DESC
LIMIT 5;
```

This returns top countries among those above the threshold.

## Data Quality Summary Checks

Data engineers use summary checks to quickly understand whether data looks normal:

- Row counts by date.
- Sales totals by date.
- Failed payment counts by country.
- Duplicate order ID checks.
- Repeated email checks.
- Latest date checks.
- Status distribution checks.
- Zero-record checks.
- Unusually high or low totals.

## Example: Source-to-Target Summary Thinking

If the source system says yesterday had 1,000 orders and the warehouse summary says 800 orders, something may be wrong. Future lessons will teach more advanced comparison methods. Today focuses on beginner grouped summary checks.

## Technical Summary Checks vs Business Summary Checks

| Check Type | Simple Meaning | Example |
| --- | --- | --- |
| Technical summary check | Checks whether data arrived and loaded correctly | Row count by date |
| Business summary check | Checks whether business numbers look reasonable | Total sales by country |

Technical examples include duplicate ID count and latest date checks. Business examples include failed payment count, cancelled order count, and revenue by channel.

## Common Data Quality Patterns Using HAVING

| Pattern | Query Idea | Why It Helps |
| --- | --- | --- |
| Duplicate IDs | Group by ID and keep counts above 1 | Finds repeated keys |
| Repeated emails | Group by email and keep counts above 1 | Finds repeated important values |
| Countries with zero orders | Group summaries and keep zero totals | Finds missing activity |
| Dates with low sales | Keep groups below a sales threshold | Finds possible data gaps |
| Channels with high cost | Keep channel cost above threshold | Flags expensive channels |
| Statuses with high failed count | Keep status counts above threshold | Supports incident checks |
| Categories with too many inactive products | Filter inactive products then group categories | Supports catalog checks |
| Campaigns with high cost but low revenue | Review cost and revenue summaries separately | Supports marketing investigation |

## HAVING in ETL and ELT Validation

After ETL/ELT runs, data engineers may run grouped checks such as number of records loaded by date, total sales by country, records by status, duplicate keys, latest event date, and summary totals by channel. These checks help decide whether pipeline output can be trusted.

## HAVING in Batch Processing

Batch pipelines often create daily summaries such as daily order count by country, daily revenue by channel, daily failed payment count, and daily campaign cost by channel. `HAVING` helps highlight groups that cross thresholds.

## Common Beginner Mistakes

1. Using `WHERE` to filter aggregated results.
2. Forgetting `GROUP BY` before `HAVING`.
3. Using `HAVING` when simple `WHERE` is enough.
4. Selecting non-grouped columns without grouping them.
5. Forgetting that `WHERE` happens before `GROUP BY`.
6. Forgetting that `HAVING` happens after `GROUP BY`.
7. Using `SELECT *` with `GROUP BY`.
8. Not giving aliases to aggregated columns.
9. Thinking repeated values are always wrong.
10. Setting arbitrary thresholds without business context.
11. Forgetting to filter cancelled or refunded records when calculating business metrics.
12. Confusing row-level filters and group-level filters.

## Role of a Data Engineer

| HAVING / Summary Task | Data Engineering Use |
| --- | --- |
| Find duplicate IDs | Investigate repeated keys |
| Find repeated emails | Review important repeated values |
| Find countries with high failed payments | Investigate payment issues |
| Find dates with zero orders | Check missing activity |
| Find channels with high cost | Support marketing checks |
| Find latest data groups | Validate freshness |
| Find unusual status counts | Monitor operational patterns |
| Validate batch output | Confirm daily refresh quality |
| Investigate dashboard anomalies | Explain metric changes |
| Check business metric summaries | Support reporting accuracy |
| Support analysts | Provide trusted summaries |
| Document validation logic | Make checks repeatable |

## Beginner Analogy: Classroom Group Checks

Imagine grouping students by class. `GROUP BY` calculates average marks per class. `HAVING` shows only classes where average marks are below 40. `WHERE` filters students before class summaries are calculated. `HAVING` filters class summaries after calculation.

## Beginner Analogy: Shop Sales Summary

A shop can summarise sales by branch. `HAVING` can show only branches where total sales are below the expected level. This helps managers investigate branches that may have missing data or real business problems.

## Key Takeaways

- `GROUP BY` creates grouped summaries.
- `HAVING` filters grouped summaries.
- `WHERE` filters rows before grouping.
- `HAVING` filters after aggregation.
- Use `HAVING COUNT(*) > 1` for duplicate-style checks.
- Repeated values are not automatically wrong.
- `HAVING` can work with `COUNT`, `SUM`, `AVG`, `MIN`, and `MAX`.
- Multiple grouping columns create combination-level summaries.
- Thresholds need business context.
- `ORDER BY` sorts filtered grouped results.
- `LIMIT` can restrict final rows.
- Summary checks support data quality.
- Technical checks focus on loading and structure.
- Business checks focus on reasonable business numbers.
- Data engineers use these checks during ETL/ELT and dashboard investigations.

## Next Day Preview

Day 013 will introduce SQL JOINs for Data Engineers: INNER JOIN, LEFT JOIN, and basic table relationships.

## Navigation

- Previous: [Day 011 - SQL Aggregations](../day-011-sql-aggregations/)
- Next: [Day 013 - SQL JOINs for Data Engineers](../day-013-sql-joins-basic-table-relationships/)
- [Back to Main Learning Path](../README.md)
