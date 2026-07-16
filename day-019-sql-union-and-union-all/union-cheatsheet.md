# Day 019 SQL UNION and UNION ALL Cheatsheet

## UNION ALL Pattern

```sql
SELECT column1, column2
FROM table_a

UNION ALL

SELECT column1, column2
FROM table_b;
```

Meaning: combines results and keeps all rows.

## UNION Pattern

```sql
SELECT column1, column2
FROM table_a

UNION

SELECT column1, column2
FROM table_b;
```

Meaning: combines results and removes exact duplicate output rows.

## Requirements

| Requirement | Meaning |
| --- | --- |
| same column count | Every `SELECT` returns the same number of columns |
| same logical column order | Matching positions have the same meaning |
| compatible data types | Matching positions can be stacked safely |

## Source Label Pattern

```sql
SELECT order_id, order_amount, 'UK' AS source_region
FROM uk_orders

UNION ALL

SELECT order_id, order_amount, 'India' AS source_region
FROM india_orders;
```

## Final Column Names

Aliases from the first `SELECT` normally control the final output names.

## Final ORDER BY

```sql
SELECT column1, column2 FROM table_a
UNION ALL
SELECT column1, column2 FROM table_b
ORDER BY column1;
```

## UNION vs JOIN

`UNION` adds rows. `JOIN` adds related columns.

## Exact Duplicate Reminder

`UNION` compares all selected output values. It does not deduplicate by ID automatically.

## Beginner Best Practices

- prefer explicit column lists
- use `UNION ALL` when preserving source records
- add source labels
- validate source counts
- keep column order consistent
- check compatible data types
- standardise schemas before combining
- do not hide duplicate ingestion with `UNION`
- use `UNION` only when exact duplicate removal is intentional
- document source lineage
