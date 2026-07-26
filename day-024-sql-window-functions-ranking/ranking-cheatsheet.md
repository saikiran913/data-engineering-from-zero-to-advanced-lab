# Day 024 Ranking Cheatsheet

## Basic Ranking Syntax

```sql
RANK() OVER (
    PARTITION BY group_column
    ORDER BY ranking_measure DESC
) AS rank_value
```

## ROW_NUMBER

```sql
ROW_NUMBER() OVER (
    PARTITION BY country
    ORDER BY total_sales DESC, customer_id
) AS row_num
```

Use for exactly one row per group when the tie-breaker is documented.

## RANK

```sql
RANK() OVER (
    PARTITION BY category
    ORDER BY total_sales DESC
) AS rank_value
```

Ties share ranks and create gaps.

## DENSE_RANK

```sql
DENSE_RANK() OVER (
    PARTITION BY department
    ORDER BY performance_score DESC
) AS dense_rank_value
```

Ties share ranks without gaps.

## Top-Per-Group

```sql
WITH ranked_rows AS (
    SELECT *,
        RANK() OVER (
            PARTITION BY group_column
            ORDER BY measure_column DESC
        ) AS rank_value
    FROM table_name
)
SELECT *
FROM ranked_rows
WHERE rank_value = 1;
```

## Bottom-Per-Group

Use `ORDER BY measure_column ASC`.

## Ranking After Aggregation

Aggregate first, then rank the grouped result in a second CTE.

## Tie-Policy Checklist

- Should tied rows remain?
- Should exactly one row be selected?
- Are tie-breakers documented?
- Should rank gaps be visible?
- Can top three ranks return more than three rows?

## Validation Checklist

- Check null ranking values.
- Count partitions.
- Count rows per partition.
- Review tied top rows.
- Confirm ranking direction.
- Confirm output grain.
