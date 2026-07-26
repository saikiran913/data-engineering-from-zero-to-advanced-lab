# Window Frame Cheatsheet

## Running Sum

```sql
SUM(value_column) OVER (
    PARTITION BY group_column
    ORDER BY date_column
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) AS running_sum
```

## Cumulative Count and Average

Use `COUNT(*) OVER (...)` for row count so far and `AVG(value_column) OVER (...)` for average so far.

## Cumulative Minimum and Maximum

Use `MIN(value_column)` or `MAX(value_column)` with the cumulative frame.

## Two-Row and Three-Row Moving Windows

```sql
ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
```

## Frame Row Count

```sql
COUNT(*) OVER (
    PARTITION BY group_column
    ORDER BY date_column
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
) AS frame_row_count
```

## Checklist

- Confirm grain.
- Confirm partition.
- Confirm ordering and tie-breaker.
- Use explicit frame.
- Review nulls, missing dates, and duplicates.
- Reconcile final cumulative totals.
- Inspect boundary rows.
