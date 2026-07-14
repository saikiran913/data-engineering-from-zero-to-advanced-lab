# Day 014 - SQL JOIN Practice and Common Join Mistakes

## Learning Goal

By the end of Day 014, you should understand how to practise `INNER JOIN` and `LEFT JOIN`, choose the correct left table, debug unexpected join results, identify common mistakes, and use joins for data quality investigations. You will also learn why row counts can increase, why row counts can decrease, and why `NULL` values after a `LEFT JOIN` need business context.

SQL syntax may vary slightly across BigQuery, PostgreSQL, SQL Server, MySQL, SQLite, and other tools. The examples use beginner-friendly ANSI-style SQL.

## Connection to Day 013

Day 013 introduced primary keys, foreign keys, `INNER JOIN`, `LEFT JOIN`, and table relationships. Day 014 focuses on practising joins and understanding what can go wrong.

## Quick Review: INNER JOIN

`INNER JOIN` keeps only matching rows from both tables.

```sql
SELECT
  c.customer_id,
  c.customer_name,
  o.order_id
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id;
```

Customers without orders and orders with unknown customers will not appear.

## Quick Review: LEFT JOIN

`LEFT JOIN` keeps all rows from the left table and adds matching rows from the right table. If there is no match, right table columns become `NULL`.

```sql
SELECT
  c.customer_id,
  c.customer_name,
  o.order_id
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id;
```

This can show customers with and without orders.

## Why JOIN Practice Matters

Joins are powerful but easy to get wrong. Wrong joins can cause missing records, duplicated-looking rows, inflated revenue, incorrect customer counts, broken dashboards, incorrect ETL outputs, hidden data quality problems, and wrong business decisions.

## Mistake 1: Forgetting the ON Condition

`ON` tells SQL how tables are connected.

Incorrect:

```sql
SELECT *
FROM customers AS c
INNER JOIN orders AS o;
```

Correct:

```sql
SELECT *
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id;
```

A missing `ON` condition can create incorrect combinations or fail depending on the SQL system.

## Mistake 2: Joining on the Wrong Column

Same-looking columns are not always correct join keys.

Incorrect:

```sql
ON c.country = o.country
```

Correct:

```sql
ON c.customer_id = o.customer_id
```

Country is not the customer-order relationship key.

## Mistake 3: Using INNER JOIN When LEFT JOIN Is Needed

If the goal is to find missing relationships, `INNER JOIN` is not enough because it removes unmatched rows. To find customers without orders, use `LEFT JOIN` and `WHERE o.order_id IS NULL`.

## Mistake 4: Choosing the Wrong Left Table

`LEFT JOIN` depends on which table comes first. `customers LEFT JOIN orders` keeps all customers. `orders LEFT JOIN customers` keeps all orders. The correct left table depends on the business question.

## Mistake 5: Not Understanding Row Count Increase

One customer can have many orders. If one customer has three orders, joining customers to orders returns three rows for that customer.

```text
Customer C001
  -> Order O1001
  -> Order O1002
  -> Order O1003
```

This is not automatically duplicate data.

## Mistake 6: Not Checking Row Counts Before and After Joins

Data engineers often compare row counts. An `INNER JOIN` may remove unmatched rows. A `LEFT JOIN` preserves left table rows, but rows can still multiply if the right table has multiple matches.

## Mistake 7: Filtering Right Table Columns After LEFT JOIN

If you left join customers to orders and then write `WHERE o.payment_status = 'Paid'`, customers with no orders are removed because their order columns are `NULL`. `WHERE` filters after the join.

## Mistake 8: Ambiguous Column Names

Joined tables may share column names such as `customer_id`, `country`, or `campaign_id`. Use aliases and prefixes like `c.customer_id` and `o.customer_id`.

## Mistake 9: Using SELECT * Carelessly in Joins

`SELECT *` can produce many columns and repeated column names. It is better to select only needed columns.

## Mistake 10: Assuming NULL After LEFT JOIN Always Means Bad Data

A customer with no orders may be normal. A product never ordered may be normal. An order item with a missing product is more serious. A payment with a missing order is also serious. Context matters.

## JOIN Debugging Mindset

1. What is the business question?
2. Which tables are needed?
3. What is the relationship?
4. What are the keys?
5. Which table should be preserved?
6. Should unmatched records appear?
7. Is row count expected to increase?
8. Are missing matches expected or suspicious?
9. Did filters change the join result?
10. Does the result make business sense?

## Practice Scenarios

| Scenario | Recommended Pattern | Why |
| --- | --- | --- |
| Customers with orders | `INNER JOIN` | Matched rows only |
| Customers without orders | `LEFT JOIN` and `IS NULL` | Finds missing activity |
| Orders with missing customers | Orders as left table | Preserves all orders |
| Order items with missing products | Order items as left table | Finds broken product references |
| Products never ordered | Products as left table | Finds unused products |
| Payments without orders | Payments as left table | Finds orphan payments |
| Orders without payments | Orders as left table | Finds missing payment rows |
| Tickets with unknown customers | Tickets as left table | Finds invalid customer references |
| Campaigns without performance | Campaigns as left table | Finds no activity or missing tracking |
| Performance with unknown campaigns | Performance as left table | Finds unknown campaign IDs |

## JOINs and Data Quality Investigations

Joins help detect orphan orders, orphan order items, unknown products, unknown campaigns, payments without orders, tickets without customers, customers with no activity, campaigns with no performance, and products never sold.

| Question | Left Table | Right Table | Join Type | Missing Match Meaning |
| --- | --- | --- | --- | --- |
| Orders with unknown customers | orders | customers | `LEFT JOIN` | Broken customer reference |
| Products never ordered | products | order_items | `LEFT JOIN` | Possible business insight |
| Payments without orders | payments | orders | `LEFT JOIN` | Serious relationship issue |
| Tickets with unknown customers | support_tickets | customers | `LEFT JOIN` | Invalid customer reference |
| Campaigns without performance | campaigns | campaign_performance | `LEFT JOIN` | No activity or missing data |

## JOINs and ETL/ELT Enrichment

Data engineers join tables to add customer country to orders, product category to order items, campaign names to performance rows, payment details to orders, and ticket status to support reporting.

## JOINs and Aggregations

Joins are often followed by aggregation:

- Count orders by customer.
- Sum revenue by product category.
- Count tickets by customer.
- Sum payments by payment method.
- Campaign revenue by campaign name.

## Common Join Result Checks

| Check | Why It Matters |
| --- | --- |
| Count rows before join | Understand starting point |
| Count rows after join | Detect row increase or decrease |
| Check unmatched records | Find missing relationships |
| Check NULLs after LEFT JOIN | Understand missing matches |
| Check duplicate-looking keys | Avoid accidental row multiplication |
| Check one-to-many relationships | Explain expected extra rows |
| Check totals after joins | Avoid inflated metrics |
| Check unexpected row multiplication | Find wrong keys |
| Check filters after joins | Avoid removing needed rows |
| Check business meaning of join | Prevent technically valid but business-wrong logic |

## Beginner Analogy: Matching Receipts to Customers

The customer list is registered customers. Receipts are orders. `INNER JOIN` shows only customers with matching receipts. `LEFT JOIN` from customers shows all customers and receipts if they exist. `LEFT JOIN` from receipts shows all receipts and customer details if the customer exists.

## Beginner Analogy: Library Books and Borrowing Records

Books are all books in a library. Borrowing records are books borrowed. `INNER JOIN` shows only borrowed books. `LEFT JOIN` from books shows all books, including books never borrowed. `LEFT JOIN` from borrowing records can reveal records with unknown book IDs.

## Key Takeaways

- `INNER JOIN` keeps matched rows only.
- `LEFT JOIN` preserves left table rows.
- The left table matters.
- Join keys must represent the real relationship.
- Wrong keys can create wrong results.
- One-to-many joins can increase row counts.
- `INNER JOIN` can decrease row counts.
- `LEFT JOIN` can reveal missing matches.
- `NULL` after `LEFT JOIN` needs context.
- Use aliases and column prefixes.
- Avoid careless `SELECT *`.
- Check row counts before and after joins.
- Filters after joins can change results.
- Joins support ETL/ELT enrichment.
- Joins support data quality investigations.

## Next Day Preview

Day 015 will introduce SQL Data Cleaning Basics: handling `NULL`s, standardising text, and preparing clean columns.

## Navigation

- Previous: [Day 013 - SQL JOINs for Data Engineers](../day-013-sql-joins-basic-table-relationships/)
- Next: [Day 015 - SQL Data Cleaning Basics](../day-015-sql-data-cleaning-basics/)
- [Back to Main Learning Path](../README.md)
