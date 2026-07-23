# Practice Questions

## Section A: Concept Checks

1. What does `ROW_NUMBER` do?
2. What does `PARTITION BY` do?
3. What does `ORDER BY` inside `ROW_NUMBER` control?
4. When would `DESC` be useful?
5. When would `ASC` be useful?
6. Why is the business key important?
7. Why is latest not always correct?
8. Why should raw data be preserved?
9. What is a tie-breaker?
10. What is a review flag?
11. Why should selected outputs be validated?
12. Why does `ROW_NUMBER` not decide business truth?

## Section B: Read the SQL

For each snippet, decide which row receives `row_num = 1`.

```sql
ROW_NUMBER() OVER (
    PARTITION BY order_id
    ORDER BY updated_at DESC
)
```

```sql
ROW_NUMBER() OVER (
    PARTITION BY customer_id
    ORDER BY updated_date ASC
)
```

```sql
ROW_NUMBER() OVER (
    PARTITION BY transaction_id
    ORDER BY loaded_at DESC
)
```

```sql
ROW_NUMBER() OVER (
    PARTITION BY event_id
    ORDER BY event_timestamp ASC, received_at ASC
)
```

```sql
ROW_NUMBER() OVER (
    PARTITION BY campaign_id, performance_date, channel, country
    ORDER BY loaded_at DESC
)
```

```sql
ROW_NUMBER() OVER (
    PARTITION BY transaction_id
    ORDER BY
        CASE
            WHEN payment_status = 'SUCCESS' THEN 1
            ELSE 2
        END
)
```

## Section C: Write or Complete SQL

1. Rank latest order versions.
2. Rank earliest contact versions.
3. Use a composite campaign key.
4. Add `loaded_at` as a tie-breaker.
5. Label `row_num = 1` as `KEEP`.
6. Filter selected rows through a CTE.
7. Prefer `SUCCESS` payment status.
8. Find unresolved ties.

## Section D: Business-Rule Thinking

1. What is the business key for order versions?
2. Should a customer contact output keep latest or earliest?
3. Should payment status use latest timestamp or status preference?
4. What tie-breaker is available for campaign files?
5. What audit columns should be retained?
6. When should a group be reviewed manually?
7. Why might a history table keep all versions?
8. What validation should run after selection?

---

## Answer Key

1. `ROW_NUMBER` assigns a sequence number inside each partition.
2. `PARTITION BY` creates duplicate groups.
3. `ORDER BY` inside `OVER` decides which row is numbered first.
4. `DESC` supports newest-first selection.
5. `ASC` supports earliest-first selection.
6. The business key defines which rows belong together.
7. Latest may be wrong if the timestamp is unreliable or the latest value is a bad correction.
8. Raw data supports audit, replay, debugging, and future rule changes.
9. A tie-breaker is an extra ordering column.
10. A review flag marks rows needing attention.

Sample SQL answer:

```sql
WITH ranked_orders AS (
    SELECT
        order_id,
        customer_id,
        order_status,
        order_amount,
        updated_at,
        loaded_at,
        source_file,
        ROW_NUMBER() OVER (
            PARTITION BY order_id
            ORDER BY updated_at DESC, loaded_at DESC
        ) AS row_num
    FROM raw_orders_duplicate_versions
)
SELECT *
FROM ranked_orders
WHERE row_num = 1;
```

Preferred payment example:

```sql
WITH ranked_payments AS (
    SELECT
        transaction_id,
        order_id,
        payment_status,
        payment_amount,
        updated_at,
        loaded_at,
        source_file,
        ROW_NUMBER() OVER (
            PARTITION BY transaction_id
            ORDER BY
                CASE
                    WHEN payment_status = 'SUCCESS' THEN 1
                    WHEN payment_status = 'REFUNDED' THEN 2
                    WHEN payment_status = 'PENDING' THEN 3
                    WHEN payment_status = 'FAILED' THEN 4
                    ELSE 5
                END,
                updated_at DESC,
                loaded_at DESC
        ) AS row_num
    FROM payment_transaction_versions
)
SELECT *
FROM ranked_payments
WHERE row_num = 1;
```
