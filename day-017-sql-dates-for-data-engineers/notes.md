# Day 017 Notes

## Big Idea

Dates help data engineers understand when something happened, when data arrived, and whether reports are up to date.

## Beginner Date Terms

| Term | Meaning |
| --- | --- |
| Date | Calendar day only, such as `2026-06-15` |
| Time | Time of day only, such as `09:30:00` |
| Datetime | Date and time together |
| Timestamp | A precise point in time, sometimes with timezone detail |

Timezone rules are important, but this lesson stays at a beginner level.

## Common Date Questions

- Which orders happened on one date?
- Which orders happened during June?
- What was the latest order date?
- Did yesterday's file arrive?
- Did the pipeline run successfully?
- Did the daily summary table refresh?
- Are any dates missing, blank, or in the future?

## Date Filtering

Use `WHERE` to filter dates.

```sql
SELECT *
FROM orders
WHERE order_date = '2026-06-15';
```

Use `BETWEEN` for simple ranges.

```sql
SELECT *
FROM orders
WHERE order_date BETWEEN '2026-06-01' AND '2026-06-30';
```

Use `>=` and `<` for clean start-inclusive and end-exclusive ranges.

```sql
SELECT *
FROM orders
WHERE order_date >= '2026-06-01'
AND order_date < '2026-07-01';
```

## Sorting Dates

- `ORDER BY date_column ASC` shows oldest first.
- `ORDER BY date_column DESC` shows newest first.

## Grouping Dates

Daily reports often use `GROUP BY date_column`.

```sql
SELECT
    order_date,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_date
ORDER BY order_date;
```

## Date Parts

Date parts are pieces of a date:

- year
- month
- day
- week

Many SQL tools support `EXTRACT`, but syntax varies.

## Freshness Checks

Freshness means the data is up to date enough for its business purpose.

Use `MAX(date_column)` to find the latest available date.

```sql
SELECT MAX(summary_date) AS latest_summary_date
FROM daily_sales_summary;
```

If the latest date is older than expected, the data may be stale.

## Pipeline Checks

Pipeline tables often include:

- `run_date`
- `run_timestamp`
- `status`
- `records_processed`
- `source_file_date`
- `completed_at`

These columns help data engineers check whether a pipeline ran, succeeded, processed rows, and loaded the expected source date.

## Event Date vs Load Date

The event date is when the business activity happened. The load or run date is when data was processed. These are not always the same.

## Important Reminder

This lesson uses only beginner `SELECT` queries. It does not modify source data.
