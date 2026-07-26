# Notes - SQL Window Functions: Ranking

## What Is a Window Function?

A window function calculates a value for each row while keeping the original row detail visible. Ranking functions are window functions because they assign a position to each row.

## Window Function Versus GROUP BY

| Topic | Window Function | `GROUP BY` |
| --- | --- | --- |
| Output row count | Usually keeps original rows | Collapses rows into groups |
| Detail preservation | Keeps row detail visible | Removes row detail unless grouped |
| Common purpose | Ranking, row comparison, position | Summary totals and counts |
| Ranking support | Yes | Not directly |

## OVER

`OVER` defines the rows used for the ranking calculation.

## PARTITION BY

`PARTITION BY` divides data into logical groups. Ranking restarts inside each group, such as department, country, category, channel, region, or reporting period.

## Window ORDER BY

Window `ORDER BY` controls ranking. `DESC` usually puts highest values first. `ASC` usually puts lowest values first. The outer `ORDER BY` controls display order only.

## ROW_NUMBER

`ROW_NUMBER` gives unique sequence numbers. Tied values still receive different numbers. It is useful when exactly one row must be chosen, but tie-breakers should be documented.

## RANK

For values:

```text
100, 90, 90, 80
```

`RANK` returns:

```text
1, 2, 2, 4
```

The tied 90 values share rank 2, then rank 3 is skipped.

## DENSE_RANK

For the same values, `DENSE_RANK` returns:

```text
1, 2, 2, 3
```

Ties share the rank, but no rank number is skipped.

## Compare All Three

| Value | ROW_NUMBER | RANK | DENSE_RANK |
| ---: | ---: | ---: | ---: |
| 100 | 1 | 1 | 1 |
| 90 | 2 | 2 | 2 |
| 90 | 3 | 2 | 2 |
| 80 | 4 | 4 | 3 |

## Choosing the Function

| Requirement | Common Choice |
| --- | --- |
| Exactly one row | `ROW_NUMBER` |
| Tied rows share rank with gaps | `RANK` |
| Tied rows share rank without gaps | `DENSE_RANK` |

The correct choice depends on business requirements.

## Additional Concepts

Global ranking has no `PARTITION BY`. Group ranking uses `PARTITION BY`. Top-per-group returns rank 1 inside each group. Bottom-per-group uses ascending order. Ranking after aggregation is useful when the business entity must be summarised before ranking.

Input grain means what one input row represents. Output grain means what one output row represents. Ranking raw rows instead of aggregated entities can create misleading results.

Ties can be real business ties, duplicate data, or ties caused by rounding. Null ranking values should be reviewed before ranking.

## Validation Workflow

1. Confirm input grain.
2. Confirm partition columns.
3. Check null ranking values.
4. Check duplicate ranking values.
5. Confirm ordering direction.
6. Count partitions.
7. Compare ranked row count with source row count.
8. Review tied top rows.
9. Confirm output grain.

## Common Mistakes

- Confusing outer and window ordering.
- Forgetting `PARTITION BY`.
- Partitioning by the wrong key.
- Ranking raw rows instead of aggregated entities.
- Choosing the wrong function.
- Filtering ranking aliases in the same query level.
- Ignoring nulls.
- Ignoring duplicates.
- Using arbitrary tie-breakers.
- Assuming rank 1 is automatically business-approved.
- Assuming top three ranks means exactly three rows.

## Platform Note

Ranking functions are widely supported, but exact syntax and null ordering behaviour can vary slightly across SQL platforms.
