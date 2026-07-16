# Day 019 - SQL UNION and UNION ALL for Data Engineers: Combining Similar Datasets

## Learning Goal

By the end of Day 019, you should understand what SQL set operations are at a beginner level, how `UNION ALL` and `UNION` combine similar datasets, why their behaviour is different, and how data engineers validate row counts, schema compatibility, duplicate behaviour, and source lineage before trusting combined data.

`UNION` and `UNION ALL` are widely supported across SQL platforms. Data type compatibility and automatic conversion behaviour can vary slightly by database.

## Connection to Previous Lessons

- Day 003 introduced structured data and consistent schemas.
- Day 005 introduced ETL and ELT pipelines.
- Day 006 introduced recurring batch files.
- Day 008 introduced duplicates and validation.
- Day 015 and Day 016 introduced data standardisation.
- Day 017 and Day 018 introduced daily and monthly datasets.
- Day 019 now teaches how to stack similar datasets vertically.

## What Problem Do UNION and UNION ALL Solve?

Companies often store similar data in separate tables or files:

- UK orders and India orders
- January orders and February orders
- Search campaign data and Social campaign data
- yesterday's file and today's file
- website event file part 1 and part 2
- historical data and new data

`UNION` and `UNION ALL` combine rows from these similar datasets into one result.

## Combining Rows Vertically

```text
UK Orders
order_id | order_date | amount
↓
India Orders
order_id | order_date | amount
↓
Combined Orders
```

`UNION` operations add rows below other rows. A `JOIN` combines related columns horizontally. `UNION` combines similar rows vertically.

## What is UNION ALL?

`UNION ALL` combines the results of multiple `SELECT` queries and keeps every row.

```sql
SELECT
    order_id,
    customer_id,
    order_date,
    order_amount,
    country
FROM uk_orders

UNION ALL

SELECT
    order_id,
    customer_id,
    order_date,
    order_amount,
    country
FROM india_orders;
```

Rows from both sources are returned. Exact duplicate rows are retained. No automatic duplicate removal occurs.

## Why Data Engineers Often Prefer UNION ALL

`UNION ALL` is commonly preferred when:

- every source record must be preserved
- data comes from separate regions
- data comes from separate files
- data comes from separate months
- duplicates need to be investigated later
- row counts must remain traceable
- performance matters

Removing rows automatically can hide source issues.

## What is UNION?

`UNION` combines query results and removes exact duplicate output rows.

```sql
SELECT
    order_id,
    customer_id,
    order_date,
    order_amount,
    country
FROM uk_orders

UNION

SELECT
    order_id,
    customer_id,
    order_date,
    order_amount,
    country
FROM india_orders;
```

SQL compares all selected output columns when deciding whether rows are identical.

## UNION Does Not Deduplicate by ID

If these rows exist:

| order_id | order_amount | country |
| --- | ---: | --- |
| 1001 | 100 | UK |
| 1001 | 120 | UK |

They share the same `order_id`, but they are not exact duplicate output rows because `order_amount` differs. `UNION` keeps both rows.

`UNION` removes exact duplicate selected rows. It does not automatically keep one row per business key. Key-based deduplication will be covered later.

## UNION vs UNION ALL

| Feature | UNION | UNION ALL |
| --- | --- | --- |
| Combines rows | Yes | Yes |
| Keeps all rows | No | Yes |
| Removes exact duplicate output rows | Yes | No |
| Usually faster | No | Yes |
| Useful for raw ingestion | Less common | Common |
| Useful for intentional distinct outputs | Yes | Sometimes |
| Risk of hiding duplicate source rows | Higher | Lower |
| Common data engineering choice | Sometimes | Often |

## Basic Requirements for UNION Operations

Each `SELECT` should return:

1. The same number of columns.
2. Columns in the same logical order.
3. Compatible data types in matching positions.

| Requirement | Correct Example | Incorrect Example |
| --- | --- | --- |
| Same number of columns | Both queries return `order_id`, `order_date`, `order_amount` | First query returns three columns, second returns four |
| Same logical order | `order_id`, `order_date`, `order_amount` in both queries | Second query returns `order_id`, `order_amount`, `order_date` |
| Compatible types | Date under date, amount under amount | Amount under date |

SQL combines columns by position, not by column name.

## Which Query Controls Column Names?

The final result normally uses output column names from the first `SELECT`.

```sql
SELECT
    order_id AS combined_order_id,
    order_date,
    order_amount
FROM january_orders

UNION ALL

SELECT
    order_id,
    order_date,
    order_amount
FROM february_orders;
```

The first output column is named `combined_order_id`.

## Adding a Source Label

Data engineers often add a constant source column.

```sql
SELECT order_id, order_date, order_amount, 'UK' AS source_region
FROM uk_orders

UNION ALL

SELECT order_id, order_date, order_amount, 'India' AS source_region
FROM india_orders;
```

Source labels help trace where each row came from. File labels such as `'january_orders.csv' AS source_file` also support troubleshooting.

## Combining Three or More Datasets

```sql
SELECT order_id, order_date, order_amount, 'UK' AS source_region FROM uk_orders
UNION ALL
SELECT order_id, order_date, order_amount, 'India' AS source_region FROM india_orders
UNION ALL
SELECT order_id, order_date, order_amount, 'USA' AS source_region FROM usa_orders;
```

Every `SELECT` must follow the same schema order.

## Common Data Engineering Uses

- Combine monthly order files.
- Combine regional order tables.
- Combine campaign channel tables.
- Combine website event file parts.
- Combine archive and current datasets.
- Prepare one reporting dataset.

For monthly files, the file name or load month does not always equal the business event month. A February file can contain a late-arriving January order.

## UNION ALL with WHERE Filters

Filters apply to each `SELECT` separately.

```sql
SELECT order_id, order_date, order_amount, country
FROM uk_orders
WHERE payment_status = 'Paid'

UNION ALL

SELECT order_id, order_date, order_amount, country
FROM india_orders
WHERE payment_status = 'Paid';
```

## ORDER BY and LIMIT

The final `ORDER BY` usually belongs at the end of the complete combined query.

```sql
SELECT order_id, order_date, order_amount FROM january_orders
UNION ALL
SELECT order_id, order_date, order_amount FROM february_orders
ORDER BY order_date;
```

`LIMIT` at the end limits the final combined output.

## UNION and Data Quality

Data engineers validate:

- source row counts
- combined row count
- unexpected exact duplicates
- missing source labels
- schema differences
- date coverage
- regional coverage
- channel coverage

If UK has 15 rows and India has 15 rows, `UNION ALL` should normally return 30 rows. `UNION` may return fewer rows because exact duplicate output rows are removed.

## Schema Standardisation Before UNION

Sources may use different column names. Align them with aliases:

```sql
SELECT amount AS order_amount
FROM india_orders;
```

If one source is missing a column, a placeholder can create the same output shape:

```sql
SELECT campaign_id, cost, revenue
FROM search_campaign_performance
UNION ALL
SELECT campaign_id, cost, NULL AS revenue
FROM email_campaign_performance;
```

Values may also need standardisation before combining.

## UNION vs JOIN

| Concept | UNION / UNION ALL | JOIN |
| --- | --- | --- |
| Combines | Rows | Columns |
| Requires similar schemas | Yes | No |
| Uses relationship keys | No | Usually yes |
| Typical use case | Stack regional files | Connect orders to customers |
| Result shape | More rows | More columns |

## Role of a Data Engineer

| UNION Task | Data Engineering Use |
| --- | --- |
| Combine regional files | Build global datasets |
| Combine monthly files | Build history |
| Combine daily files | Support batch ingestion |
| Combine channel datasets | Build marketing reporting |
| Add source labels | Track lineage |
| Preserve all source rows | Avoid hiding issues |
| Remove intentional exact duplicates | Create distinct outputs |
| Align column names | Standardise schema |
| Align column order | Prevent wrong stacking |
| Validate row counts | Confirm completeness |
| Investigate duplicate rows | Improve data quality |
| Document source lineage | Support troubleshooting |

## Beginner Analogies

Stacking attendance sheets: one attendance sheet for Class 6A and one for Class 6B can be stacked if both have the same columns. `UNION ALL` keeps every student row.

Combining monthly shop ledgers: January and February sales ledgers can be stacked into one history. If the same transaction appears twice, `UNION ALL` keeps both so the issue is visible. `UNION` may hide an exact repeated row.

## Common Beginner Mistakes

1. Using a different number of columns.
2. Placing columns in a different order.
3. Combining incompatible data types.
4. Assuming SQL matches columns by name.
5. Using `UNION` when `UNION ALL` is needed.
6. Thinking `UNION` deduplicates by primary key.
7. Forgetting a source label.
8. Forgetting that final column names come from the first query.
9. Putting `ORDER BY` in the wrong place.
10. Comparing combined row counts without checking source filters.
11. Combining datasets before standardising schemas.
12. Using `SELECT *` across sources with changing schemas.
13. Hiding duplicate source records by using `UNION`.
14. Confusing `UNION` with `JOIN`.

## Key Takeaways

- `UNION ALL` stacks rows and keeps every row.
- `UNION` stacks rows and removes exact duplicate output rows.
- `UNION` is not key-based deduplication.
- Column count must match.
- Column order must match logically.
- Matching positions need compatible data types.
- SQL matches columns by position, not name.
- The first `SELECT` controls final column names.
- Source labels support lineage.
- `UNION ALL` is commonly preferred for raw ingestion.
- Validate source counts before combining.
- Avoid hiding data quality problems with `UNION`.

## Next Day Preview

Day 020 introduces SQL duplicate handling fundamentals: `DISTINCT`, duplicate investigation, business keys, and safe deduplication thinking.

## Navigation

- Previous: [Day 018 - SQL Date Practice and Period Reporting](../day-018-sql-date-practice-period-reporting/)
- Next: [Day 020 - SQL Duplicate Handling Fundamentals](../day-020-sql-duplicate-handling-fundamentals/)
- [Back to Main Learning Path](../README.md)
