# Day 021 Notes

## What is Safe Deduplication?

Safe deduplication means finding duplicate groups, understanding why they exist, defining a business rule, ranking or sequencing records, selecting the intended record, reviewing exceptions, and documenting the logic.

## Why Duplicate Investigation Comes First

Duplicate records may represent accidental repeated rows, legitimate versions, status history, corrections, late-arriving data, snapshots, or multiple source files. Removing all repeated-looking rows may lose valid information.

## What is a Window Function?

A window function looks across related rows. It can calculate something for each row without collapsing rows into one summary row. `ROW_NUMBER` gives each row a sequence number inside a defined group.

## Basic ROW_NUMBER Pattern

```sql
SELECT
    column_1,
    column_2,
    ROW_NUMBER() OVER (
        PARTITION BY business_key
        ORDER BY updated_at DESC
    ) AS row_num
FROM source_table;
```

`PARTITION BY business_key` creates one group per key. `ORDER BY updated_at DESC` puts the newest row first. `row_num` is the sequence number assigned inside each group.

## What Does PARTITION BY Mean?

`PARTITION BY` divides rows into logical groups. Numbering restarts for each business key.

| order_id | updated_at | row_num with newest first |
| --- | --- | ---: |
| ORD-1001 | 2026-03-01 09:00:00 | 3 |
| ORD-1001 | 2026-03-02 10:00:00 | 2 |
| ORD-1001 | 2026-03-03 11:00:00 | 1 |
| ORD-1002 | 2026-03-01 08:00:00 | 1 |

## ORDER BY Inside ROW_NUMBER

The `ORDER BY` inside `OVER` decides which row gets number 1. `DESC` usually supports latest-record logic. `ASC` usually supports earliest-record logic. The outer query `ORDER BY` controls display order only.

## Keeping Row Number 1

```sql
WITH ranked_records AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY business_key
            ORDER BY updated_at DESC
        ) AS row_num
    FROM source_table
)
SELECT *
FROM ranked_records
WHERE row_num = 1;
```

This is safe because it only returns a result set.

## Keeping the Latest Record

Latest is suitable only when the timestamp is reliable, the newest version represents the desired truth, late or incorrect updates are understood, and ties are handled.

## Keeping the Earliest Record

Earliest can support first registration, first event occurrence, original created record, or earliest captured contact version. Earliest is not automatically best.

## Preferred-Status Ordering

```sql
ROW_NUMBER() OVER (
    PARTITION BY transaction_id
    ORDER BY
        CASE
            WHEN payment_status = 'SUCCESS' THEN 1
            WHEN payment_status = 'PENDING' THEN 2
            WHEN payment_status = 'FAILED' THEN 3
            ELSE 4
        END,
        updated_at DESC
) AS row_num
```

This implements a documented preference. The preference is not universal.

## Tie-Breakers

When two rows have the same timestamp, use a secondary column such as `loaded_at`, `source_file`, `record_version`, or `ingestion_id`. Without a reliable tie-breaker, the chosen row may not be deterministic.

## Records to Keep Versus Review

Rows can be labelled as `KEEP`, `OLDER_VERSION`, `PREFERRED_STATUS`, `REVIEW`, or `UNRESOLVED_TIE`.

## Why Raw Data Should Remain Available

The raw layer preserves source history. The clean layer applies documented rules. The business-ready layer exposes trusted outputs. Raw history supports auditing, debugging, replay, and changed business logic.

## Common Mistakes

- using `DISTINCT` when rows differ
- keeping latest without validating timestamps
- forgetting `PARTITION BY`
- partitioning by the wrong key
- ordering in the wrong direction
- filtering before ranking without understanding the impact
- using incomplete business keys
- ignoring ties
- treating all duplicates as bad data
- deleting source data too early
- not documenting the rule

## Platform Note

Exact SQL syntax can vary, but `ROW_NUMBER` with `PARTITION BY` and `ORDER BY` is widely supported in modern SQL platforms.
