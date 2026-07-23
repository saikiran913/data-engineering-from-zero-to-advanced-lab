# Day 020 — SQL Duplicate Handling Fundamentals: DISTINCT, Duplicate Investigation, Business Keys, and Safe Deduplication Thinking

## Learning Goal

By the end of Day 020, you should understand what duplicate data means, the difference between exact duplicate rows and duplicate business keys, what `DISTINCT` does and does not do, how to investigate repeated values with `GROUP BY` and `HAVING`, and why safe deduplication requires business rules.

This lesson is investigation-only. All SQL is `SELECT`-based. Source data is not modified.

## Connection to Previous Lessons

- Day 008 introduced duplicates as a data quality issue.
- Day 011 introduced `COUNT`.
- Day 012 introduced `GROUP BY` and `HAVING` for grouped checks.
- Day 013 and Day 014 showed that joins can increase row counts and create duplicate-looking rows.
- Day 019 explained that `UNION` removes exact duplicate output rows but does not deduplicate by business key.
- Day 020 now focuses on investigating duplicates safely.

## Why Duplicate Handling Matters

Duplicates can affect dashboards, revenue totals, order counts, campaign metrics, customer counts, payment reporting, pipeline validation, and trust in data.

Removing duplicates blindly is also dangerous. A repeated value may be valid, updated, corrected, or part of a normal one-to-many relationship.

## What is a Duplicate?

A duplicate means a record or value appears more than expected. The phrase "more than expected" depends on business meaning.

Examples:

- same order row appears twice
- same `order_id` appears with different statuses
- same email appears for two customer records
- same `transaction_id` appears twice
- same campaign/date metric appears twice
- same `customer_id` appears in many orders, which is normal

## Exact Duplicate Row

An exact duplicate row means all selected values are identical.

| order_id | customer_id | amount | status |
| --- | --- | ---: | --- |
| 1001 | 501 | 120 | Paid |
| 1001 | 501 | 120 | Paid |

Exact duplicates may happen when the same file is loaded twice.

## Duplicate Business Key

A duplicate business key means the column or columns that should identify one business record appear more than once.

Examples:

- `order_id` appears more than once
- `transaction_id` appears more than once
- `event_id` appears more than once
- `campaign_id + performance_date + channel + country` appears more than once

This is different from exact duplicate rows.

## Repeated Values That Are Normal

| Repeated Value | Normal or Suspicious? | Reason |
| --- | --- | --- |
| `customer_id` in orders | Often normal | One customer can have many orders |
| `campaign_id` across dates | Normal | One campaign can run for many dates |
| `order_id` in payments | Sometimes normal | One order can have multiple payment attempts |
| `user_id` in events | Normal | One user can create many events |
| `transaction_id` in payments | Suspicious | Usually expected to identify one payment transaction |

## What is DISTINCT?

`DISTINCT` removes duplicate output rows from the selected columns.

```sql
SELECT DISTINCT country
FROM raw_orders_with_duplicates;
```

This returns each country once.

## DISTINCT on Multiple Columns

```sql
SELECT DISTINCT order_status, payment_status
FROM raw_orders_with_duplicates;
```

`DISTINCT` looks at the combination of selected columns.

## DISTINCT Does Not Deduplicate a Full Table by Business Key

```sql
SELECT DISTINCT order_id, order_amount
FROM raw_orders_with_duplicates;
```

If the same `order_id` appears with different `order_amount` values, both rows remain because the selected output rows are different. `DISTINCT` is useful for unique output combinations, not safe business deduplication by itself.

## DISTINCT vs GROUP BY

| Task | Better Tool | Why |
| --- | --- | --- |
| List unique countries | `DISTINCT` | You only need unique values |
| Find duplicate order IDs | `GROUP BY` + `HAVING` | You need counts by key |
| Count repeated emails | `GROUP BY` + `COUNT` | You need frequency |
| Investigate repeated transaction IDs | `GROUP BY` + `HAVING` | You need suspicious repeated keys |

## Finding Duplicate Business Keys

```sql
SELECT
    order_id,
    COUNT(*) AS row_count
FROM raw_orders_with_duplicates
GROUP BY order_id
HAVING COUNT(*) > 1;
```

This groups rows by `order_id`, counts rows per order, and returns only order IDs appearing more than once.

## Finding Repeated Emails

```sql
SELECT
    LOWER(TRIM(email)) AS clean_email,
    COUNT(*) AS row_count
FROM customer_contacts
WHERE email IS NOT NULL
GROUP BY LOWER(TRIM(email))
HAVING COUNT(*) > 1;
```

Cleaning email before grouping helps catch case and spacing differences.

## Finding Repeated Event IDs

```sql
SELECT
    event_id,
    COUNT(*) AS row_count
FROM website_events_with_duplicates
GROUP BY event_id
HAVING COUNT(*) > 1;
```

Repeated event IDs need investigation.

## Finding Repeated Payment Transaction IDs

```sql
SELECT
    transaction_id,
    COUNT(*) AS row_count
FROM payment_transactions
GROUP BY transaction_id
HAVING COUNT(*) > 1;
```

Transaction ID is often expected to identify one payment transaction.

## Finding Duplicate Campaign-Date Records

```sql
SELECT
    performance_date,
    campaign_id,
    channel,
    country,
    COUNT(*) AS row_count
FROM campaign_performance_duplicates
GROUP BY performance_date, campaign_id, channel, country
HAVING COUNT(*) > 1;
```

This checks a composite business key.

## What is a Business Key?

A business key is a column or group of columns that identifies a business record. Business keys come from business logic, not only SQL syntax.

Single-column examples: `order_id`, `transaction_id`, `event_id`.

Composite examples: `performance_date + campaign_id + channel + country`.

## Why Business Keys Need Business Context

SQL can show repeated values, but business rules decide whether they are wrong.

- same `order_id` twice may be a duplicate or a correction
- same `order_id` with different status may represent updates
- same `order_id` from a retry file may mean duplicate ingestion
- same order with multiple payment attempts may be valid if transaction IDs differ

## Duplicate Investigation Workflow

1. Identify suspected key.
2. Count rows by the key.
3. Find keys with count greater than 1.
4. Inspect repeated records.
5. Compare values across repeated records.
6. Check `source_file` or load information.
7. Ask if repetition is expected.
8. Decide whether to keep, flag, quarantine, or deduplicate later.
9. Document the rule.
10. Never delete blindly.

## Inspecting Repeated Records

```sql
SELECT *
FROM raw_orders_with_duplicates
WHERE order_id = 'ORD1005'
ORDER BY source_file;
```

After finding repeated keys, inspect the actual records.

## Duplicates After UNION ALL

`UNION ALL` preserves every row, so if the same file or same row appears twice, duplicates remain visible. This is useful in raw ingestion because source issues are not hidden.

## Duplicates After UNION

`UNION` may remove exact duplicate output rows. This can make results look cleaner, but it may hide duplicate ingestion. It should not be used as a lazy deduplication method.

## Duplicate-Looking Rows After Joins

After joining customers to orders, one customer may appear many times because they have many orders. That is one-to-many data, not necessarily duplication.

## Safe Deduplication Thinking

Safe deduplication means understanding which records should be kept or removed based on business rules.

Possible rules:

- keep latest updated record
- keep earliest created record
- keep successful payment over failed payment
- keep highest priority status
- keep one record per business key
- quarantine duplicates for review

These rules are conceptual today. More advanced implementation patterns come later.

## Why We Are Not Removing Duplicates Yet

Removing duplicates safely often requires more advanced SQL and business-specific logic. Day 020 focuses on investigation and safe thinking.

## Common Beginner Mistakes

1. Thinking every repeated value is a duplicate.
2. Using `DISTINCT` to solve every duplicate problem.
3. Thinking `DISTINCT` deduplicates by ID automatically.
4. Removing records without business rules.
5. Confusing exact duplicate rows with duplicate business keys.
6. Forgetting one-to-many relationships can repeat rows.
7. Using `UNION` to hide duplicate ingestion.
8. Ignoring `source_file`.
9. Not cleaning emails before checking repeated emails.
10. Grouping by too many columns and missing business-key duplicates.
11. Grouping by too few columns and flagging valid rows.
12. Not documenting deduplication logic.

## Key Takeaways

- Duplicate handling starts with investigation.
- Exact duplicate rows and duplicate business keys are different.
- Repeated values may be normal depending on grain.
- `DISTINCT` returns unique output rows.
- `DISTINCT` is not a universal deduplication solution.
- `GROUP BY` and `HAVING` help find repeated keys.
- Business keys define what should be unique.
- Composite keys use multiple columns.
- `source_file` helps trace duplicate ingestion.
- Raw data should not be deleted blindly.
- Safe deduplication requires documented business rules.

## Next Day Preview

Day 021 introduces SQL safe deduplication practice: `ROW_NUMBER` concept, keeping latest records, and duplicate resolution patterns.

## Navigation

- Previous: [Day 019 - SQL UNION and UNION ALL for Data Engineers](../day-019-sql-union-and-union-all/)
- Next: [Day 021 - SQL Safe Deduplication Practice](../day-021-sql-safe-deduplication-practice/)
- [Back to Main Learning Path](../README.md)
