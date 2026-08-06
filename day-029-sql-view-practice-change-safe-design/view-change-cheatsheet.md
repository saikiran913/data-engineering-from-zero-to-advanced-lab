# Day 029 View Change Cheatsheet

## Before-Change Checklist

- view purpose
- source objects
- consumers
- output grain
- keys
- required columns
- totals
- nulls
- dates
- audit fields

## Change-Type Checklist

| Change | Main Check |
|---|---|
| Column add | fixed schema and `SELECT *` review |
| Column rename | required-column review |
| Column removal | consumer inventory |
| Type change | calculation and comparison review |
| Filter change | row count and excluded rows |
| Join change | duplicate keys and unmatched rows |
| Aggregation change | grain and total reconciliation |
| Grain change | key uniqueness and row count |
| Null-handling change | null counts and distributions |

## Old-Versus-New Template

```sql
WITH old_logic AS (
    SELECT column1, column2
    FROM source_table
),
new_logic AS (
    SELECT column1, column2
    FROM source_table
)
SELECT
    (SELECT COUNT(*) FROM old_logic) AS old_count,
    (SELECT COUNT(*) FROM new_logic) AS new_count;
```

## Duplicate-Key Check

```sql
SELECT
    business_key,
    COUNT(*) AS row_count
FROM proposed_output
GROUP BY business_key
HAVING COUNT(*) > 1;
```

## Total-Reconciliation Check

```sql
SELECT
    SUM(amount) AS total_amount
FROM proposed_output;
```

## Only-In-Old and Only-In-New

Use a `LEFT JOIN` between old and new logic to identify records that appear only on one side.

## Changed-Value Check

Compare the same key in old and new logic, then review rows where important metrics differ.

## Consumer-Impact Checklist

- Which consumers use this view?
- Which columns do they require?
- What grain do they expect?
- Which metrics are critical?
- How sensitive are they to change?

## Review-Summary Template

| check_name | old_value | new_value | difference | status | explanation |
|---|---:|---:|---:|---|---|
