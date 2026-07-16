# Real-World Examples

## 1. List Unique Countries

Business situation: a report needs available countries.

Table used: `raw_orders_with_duplicates`

Suspected duplicate type: repeated values

SQL concept used: `DISTINCT`

```sql
SELECT DISTINCT country
FROM raw_orders_with_duplicates;
```

Expected result: one row per country.

Safe next step: use as a reference list.

Common mistake: treating this as order deduplication.

## 2. List Unique Payment Statuses

```sql
SELECT DISTINCT payment_status
FROM payment_transactions;
```

Use this to understand available status values before investigation.

## 3. Find Repeated Order IDs

```sql
SELECT order_id, COUNT(*) AS row_count
FROM raw_orders_with_duplicates
GROUP BY order_id
HAVING COUNT(*) > 1;
```

Expected result: order IDs needing review.

## 4. Inspect Repeated Order Records

```sql
SELECT *
FROM raw_orders_with_duplicates
WHERE order_id = 'ORD1005'
ORDER BY source_file;
```

Safe next step: compare values and source files.

## 5. Find Repeated Cleaned Emails

```sql
SELECT LOWER(TRIM(email)) AS clean_email, COUNT(*) AS row_count
FROM customer_contacts
WHERE email IS NOT NULL
GROUP BY LOWER(TRIM(email))
HAVING COUNT(*) > 1;
```

Cleaning helps catch case and spacing differences.

## 6. Find Repeated Website Event IDs

```sql
SELECT event_id, COUNT(*) AS row_count
FROM website_events_with_duplicates
GROUP BY event_id
HAVING COUNT(*) > 1;
```

Repeated event IDs should be inspected.

## 7. Find Repeated Payment Transaction IDs

```sql
SELECT transaction_id, COUNT(*) AS row_count
FROM payment_transactions
GROUP BY transaction_id
HAVING COUNT(*) > 1;
```

Repeated transaction IDs are usually suspicious.

## 8. Find Repeated Campaign Daily Keys

```sql
SELECT performance_date, campaign_id, channel, country, COUNT(*) AS row_count
FROM campaign_performance_duplicates
GROUP BY performance_date, campaign_id, channel, country
HAVING COUNT(*) > 1;
```

Composite keys are common in reporting data.

## 9. Exact Duplicate Rows vs Changed Duplicate Keys

Exact duplicate rows repeat all selected values. Changed duplicate keys repeat the key but contain different values. These need different decisions.

## 10. Retry Source File Investigation

```sql
SELECT *
FROM raw_orders_with_duplicates
WHERE source_file = 'orders_retry.csv';
```

Retry files often explain duplicate ingestion.

## 11. Customer ID Repeated in Orders is Normal

A customer can place many orders. Repeated `customer_id` alone does not prove a duplicate.

## 12. User ID Repeated in Events is Normal

A user can create many events. Repeated `user_id` often reflects activity.

## 13. UNION ALL Can Expose Duplicates

When raw files are stacked and all rows are preserved, duplicate source records remain visible for investigation.

## 14. UNION Can Hide Exact Duplicate Rows

Exact duplicate output rows may disappear when exact duplicate removal is used. This can hide repeated ingestion.

## 15. DISTINCT is Not Safe Full Deduplication

`DISTINCT` returns unique selected output rows. It does not know the business key or keep rule.

## 16. Raw Orders Duplicate Checklist

Check total rows, distinct order IDs, repeated order IDs, source files, changed statuses, changed payment statuses, and retry files. Then document the rule.
