# Day 021 ROW_NUMBER Cheatsheet

## Basic Pattern

```sql
ROW_NUMBER() OVER (
    PARTITION BY business_key
    ORDER BY updated_at DESC
) AS row_num
```

## Latest Record Pattern

```sql
WITH ranked_records AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY business_key
            ORDER BY updated_at DESC, loaded_at DESC
        ) AS row_num
    FROM source_table
)
SELECT *
FROM ranked_records
WHERE row_num = 1;
```

## Earliest Record Pattern

```sql
ROW_NUMBER() OVER (
    PARTITION BY business_key
    ORDER BY created_at ASC, loaded_at ASC
) AS row_num
```

## Preferred Status Pattern

```sql
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
```

## Review Label Pattern

```sql
CASE
    WHEN row_num = 1 THEN 'KEEP'
    ELSE 'OLDER_VERSION'
END AS dedup_action
```

## Best Practices

- investigate duplicates first
- define the business key
- document the selection rule
- use a tie-breaker when possible
- preserve audit columns
- validate uniqueness after selection
- keep raw history available
