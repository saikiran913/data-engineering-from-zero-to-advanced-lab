# Day 011 SQL Aggregation Cheatsheet

## COUNT(*)

```sql
SELECT COUNT(*) AS total_rows
FROM table_name;
```

Counts all rows returned by the query.

## COUNT(column_name)

```sql
SELECT COUNT(column_name) AS non_null_values
FROM table_name;
```

Counts rows where `column_name` has a non-null value. This is different from `COUNT(*)`, which counts every row.

## SUM

```sql
SELECT SUM(numeric_column) AS total_value
FROM table_name;
```

Adds numeric values together.

## AVG

```sql
SELECT AVG(numeric_column) AS average_value
FROM table_name;
```

Calculates the average of numeric values.

## MIN

```sql
SELECT MIN(column_name) AS lowest_value
FROM table_name;
```

Finds the smallest value. With dates, it can find the earliest date.

## MAX

```sql
SELECT MAX(column_name) AS highest_value
FROM table_name;
```

Finds the largest value. With dates, it can find the latest date.

## GROUP BY

```sql
SELECT group_column, COUNT(*) AS total_rows
FROM table_name
GROUP BY group_column;
```

Creates one count for each unique value in `group_column`.

## GROUP BY with SUM

```sql
SELECT group_column, SUM(numeric_column) AS total_value
FROM table_name
GROUP BY group_column;
```

Creates one total for each group.

## WHERE with GROUP BY

```sql
SELECT group_column, SUM(numeric_column) AS total_value
FROM table_name
WHERE condition
GROUP BY group_column;
```

Filters rows first, then groups the remaining rows.

## ORDER BY Aggregated Result

```sql
SELECT group_column, SUM(numeric_column) AS total_value
FROM table_name
GROUP BY group_column
ORDER BY total_value DESC;
```

Sorts summary results from highest to lowest.

## Beginner Best Practices

- Use clear aliases.
- Check whether null values matter.
- Do not use `SELECT *` with `GROUP BY`.
- Use `WHERE` before `GROUP BY` to filter source rows.
- Understand whether cancelled or refunded records should be included.
- Sort summaries to make results easier to read.
- Start with simple counts before complex metrics.
- Document business definitions.
- Compare source and target totals carefully.
- Validate aggregation logic with small samples.
