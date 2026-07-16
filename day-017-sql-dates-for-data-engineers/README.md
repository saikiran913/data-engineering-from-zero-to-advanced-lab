# Day 017 — SQL Dates for Data Engineers: Date Filters, Date Parts, Freshness Checks, and Daily Reporting

## Learning Goal

By the end of Day 017, you should understand why dates matter in data engineering, how to filter records by date, how to sort and group date-based data, how to build simple daily reports, how date parts support monthly reporting, and how `MAX(date_column)` helps check whether data is fresh.

This is your first SQL date-focused lesson. The SQL examples stay simple and `SELECT`-based. Exact date syntax varies across tools such as BigQuery, PostgreSQL, SQL Server, MySQL, and SQLite, so always check your platform's date functions.

## Connection to Previous Lessons

- Day 006 introduced batch processing and daily pipeline refreshes.
- Day 008 introduced freshness checks as part of data quality.
- Day 010 introduced filtering with `WHERE` and `BETWEEN`.
- Day 011 introduced aggregations like `COUNT` and `SUM`.
- Day 012 introduced grouped summary checks.
- Day 016 introduced business-ready outputs.
- Day 017 now focuses on dates because most data engineering pipelines and reports depend on time.

## Why Dates Matter in Data Engineering

Data engineers use dates to:

- load daily files
- filter yesterday's records
- build daily reports
- check dashboard freshness
- validate pipeline runs
- compare current and previous periods
- investigate missing data
- create monthly or weekly summaries
- monitor late-arriving data
- support business reporting cycles

## Date, Time, Datetime, and Timestamp

| Term | Simple Meaning | Example |
| --- | --- | --- |
| date | Calendar day only | `2026-06-15` |
| time | Time of day only | `14:30:00` |
| datetime | Date and time together | `2026-06-15 14:30:00` |
| timestamp | A point in time, often with precise time and sometimes timezone information | `2026-06-15 14:30:00` |

Timezone handling is important in real systems, but this lesson keeps timezone discussion light. Later lessons can go deeper.

## Common Date Columns in Data Engineering

| Column Name | Meaning | Example Use |
| --- | --- | --- |
| `order_date` | Date an order happened | Daily sales reporting |
| `order_datetime` | Exact order date and time | Order investigation |
| `signup_date` | Date a customer signed up | Customer growth trend |
| `performance_date` | Date marketing performance belongs to | Campaign daily report |
| `event_timestamp` | Exact event time | Website activity investigation |
| `run_timestamp` | Exact pipeline run time | Pipeline monitoring |
| `source_file_date` | Date represented by a source file | Source freshness check |
| `summary_date` | Date represented by a summary row | Dashboard freshness |
| `completed_at` | Pipeline completion time | Run completion check |

Date column names matter because each date can mean something different.

## Filtering a Specific Date

```sql
SELECT *
FROM orders
WHERE order_date = '2026-06-15';
```

This returns orders from one date. Exact date literal syntax may vary slightly by SQL platform.

## Filtering Between Two Dates

```sql
SELECT *
FROM orders
WHERE order_date BETWEEN '2026-06-01' AND '2026-06-30';
```

`BETWEEN` usually includes both boundary values. This means the example includes June 1 and June 30.

Date and timestamp filtering must be handled carefully in real systems.

## Filtering Dates Using >= and <

Many data engineers prefer start-inclusive and end-exclusive filters for date ranges.

```sql
SELECT *
FROM orders
WHERE order_date >= '2026-06-01'
AND order_date < '2026-07-01';
```

This means "start at June 1, but stop before July 1." This style is especially useful when working with timestamps.

## Filtering Recent Data Conceptually

Data engineers often filter:

- today's data
- yesterday's data
- last 7 days
- current month
- previous month

The exact syntax differs across SQL tools.

```sql
-- Example idea only:
-- filter records where order_date is in the last 7 days
```

Platform-specific examples will come later.

## Sorting by Date

```sql
SELECT *
FROM orders
ORDER BY order_date ASC;
```

`ASC` shows oldest records first.

```sql
SELECT *
FROM orders
ORDER BY order_date DESC;
```

`DESC` shows newest records first.

## Finding Latest Date with MAX

```sql
SELECT MAX(order_date) AS latest_order_date
FROM orders;
```

This helps check whether new data arrived.

## Finding Earliest Date with MIN

```sql
SELECT MIN(order_date) AS earliest_order_date
FROM orders;
```

This helps understand the range of data available.

## Data Freshness

Data freshness means how up-to-date the data is.

Examples:

- a daily dashboard should show yesterday's data by 8 AM
- an hourly pipeline should show data from the last hour
- a campaign dashboard should not be stuck on last week
- website events should keep arriving throughout the day

Freshness expectations depend on business requirements.

## Freshness Check Using MAX Date

```sql
SELECT MAX(summary_date) AS latest_summary_date
FROM daily_sales_summary;
```

If today is 2026-07-14 and the latest summary date is 2026-07-10, the data may be stale. Avoid hardcoding current dates in many queries; compare conceptually first, then use your SQL platform's date functions.

## Pipeline Freshness Checks

```sql
SELECT
    pipeline_name,
    MAX(run_date) AS latest_run_date
FROM pipeline_runs
GROUP BY pipeline_name;
```

This shows the latest run date per pipeline.

## Pipeline Status Checks by Date

```sql
SELECT
    run_date,
    status,
    COUNT(*) AS total_runs
FROM pipeline_runs
GROUP BY run_date, status
ORDER BY run_date;
```

This helps monitor successful and failed pipeline runs.

## Grouping by Date

```sql
SELECT
    order_date,
    COUNT(*) AS total_orders,
    SUM(order_amount) AS total_sales
FROM orders
GROUP BY order_date
ORDER BY order_date;
```

This creates a daily order summary.

## Daily Reporting

Daily reporting summarises business activity for each day.

Examples:

- daily orders
- daily sales
- daily clicks
- daily conversions
- daily revenue
- daily failed payments
- daily website events
- daily pipeline run status

## Daily Sales Report Example

```sql
SELECT
    order_date,
    COUNT(*) AS total_orders,
    SUM(order_amount) AS total_sales
FROM orders
WHERE payment_status = 'Paid'
GROUP BY order_date
ORDER BY order_date;
```

Step by step:

1. `FROM orders` reads the orders table.
2. `WHERE payment_status = 'Paid'` keeps paid orders only.
3. `GROUP BY order_date` creates one group per order date.
4. `COUNT(*)` counts orders per date.
5. `SUM(order_amount)` totals sales per date.
6. `ORDER BY order_date` sorts the report by day.

## Daily Campaign Performance Example

```sql
SELECT
    performance_date,
    SUM(impressions) AS total_impressions,
    SUM(clicks) AS total_clicks,
    SUM(cost) AS total_cost,
    SUM(conversions) AS total_conversions,
    SUM(revenue) AS total_revenue
FROM campaign_performance
GROUP BY performance_date
ORDER BY performance_date;
```

This produces daily marketing performance.

## Daily Website Event Count Example

```sql
SELECT
    event_date,
    event_type,
    COUNT(*) AS total_events
FROM website_events
GROUP BY event_date, event_type
ORDER BY event_date, event_type;
```

This shows daily user activity by event type.

## Date Parts

Date parts are pieces of a date, such as year, month, day, or week.

From `2026-06-15`:

- year = `2026`
- month = `06`
- day = `15`

Date part syntax varies across SQL platforms.

## Year, Month, and Day in Reporting

Businesses use date parts for:

- monthly sales reports
- weekly campaign performance
- yearly customer growth
- day-level operations
- month-over-month comparison later

## Date Part Syntax Note

Different SQL platforms use different functions for extracting date parts.

- BigQuery often uses `EXTRACT(part FROM date_column)`
- PostgreSQL also supports `EXTRACT(part FROM date_column)`
- SQL Server often uses `DATEPART(part, date_column)`
- MySQL has functions like `YEAR(date_column)` and `MONTH(date_column)`
- SQLite uses `strftime` patterns

The main examples use `EXTRACT`, but your platform may need different syntax.

## Monthly Reporting Example

```sql
SELECT
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month,
    COUNT(*) AS total_orders,
    SUM(order_amount) AS total_sales
FROM orders
GROUP BY
    EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date)
ORDER BY order_year, order_month;
```

This groups orders by year and month. Exact syntax may vary by database.

## Data Quality Checks with Dates

Date-related data quality checks include:

- missing date values
- future dates
- stale latest date
- duplicate summary dates
- missing daily records
- failed pipeline runs
- zero records processed
- mismatched source file date and run date
- daily totals unexpectedly zero

These connect directly to Day 008 and Day 012.

## Future Date Check

```sql
SELECT *
FROM orders
WHERE order_date > '2026-12-31';
```

The threshold is only an example. In real work, compare against the current date based on platform syntax and business rules.

## Missing Date Check

```sql
SELECT *
FROM orders
WHERE order_date IS NULL;
```

Missing dates are serious for daily reporting because the row may not land in the correct daily group.

## Zero Records Processed Check

```sql
SELECT *
FROM pipeline_runs
WHERE records_processed = 0;
```

Zero records may be normal or may indicate a problem, depending on the pipeline.

## Date Gaps Concept

A date gap means expected dates are missing from a table or summary.

Example: `daily_sales_summary` has rows for June 1, June 2, and June 4, but not June 3.

Future lessons will cover stronger date gap detection.

## Late-Arriving Data

Late-arriving data means an event or order happened on one date but arrived in the data platform later.

Example: an order happened on June 10 but was loaded on June 11.

Data engineers track both event date and processing or load date because each answers a different question.

## Event Date vs Load Date

| Date Type | Meaning | Example |
| --- | --- | --- |
| event date | Date the business event happened | Website signup date |
| order date | Date the order happened | `2026-06-15` |
| source file date | Date represented by the source file | File for `2026-06-15` |
| load date | Date data was loaded | Loaded on `2026-06-16` |
| run timestamp | Exact pipeline run time | `2026-06-16 08:00:00` |
| summary date | Date represented by a summary row | Daily sales for `2026-06-15` |

Confusing these dates can create reporting mistakes.

## Common Beginner Mistakes

1. Treating date and timestamp columns as exactly the same.
2. Filtering timestamps using date logic without care.
3. Forgetting that `BETWEEN` usually includes boundaries.
4. Forgetting to check latest available date.
5. Using the wrong date column for reporting.
6. Grouping by timestamp instead of date and creating too many groups.
7. Assuming data is fresh because the dashboard opened successfully.
8. Ignoring failed pipeline runs.
9. Treating zero records as always wrong.
10. Treating missing dates as always acceptable.
11. Forgetting SQL date functions vary by platform.
12. Confusing event date, load date, and summary date.

## Role of a Data Engineer

| Date Task | Data Engineering Use |
| --- | --- |
| Filter daily data | Load or review one business day |
| Build daily summaries | Prepare dashboard-ready tables |
| Check latest date | Confirm data arrived |
| Check pipeline run date | Monitor refresh activity |
| Monitor failed runs | Detect broken pipelines |
| Detect stale data | Protect dashboard trust |
| Investigate missing dates | Find incomplete reporting periods |
| Create monthly summaries | Support business reporting cycles |
| Support dashboard refreshes | Keep reports reliable |
| Validate source file dates | Confirm source delivery |
| Track late-arriving data | Separate business date from load date |
| Document reporting date logic | Help others understand the report |

## Beginner Analogy: Daily Attendance Register

A school attendance register needs one entry per day. If one date is missing, the report may be incomplete. If today's attendance still shows last week, the data is stale. If one student is marked for a future date, that date may be wrong.

Daily data pipelines work the same way: expected dates should arrive, be processed, and appear in reports.

## Beginner Analogy: Shop Daily Sales Book

A shop records sales every day. At the end of the day, the owner checks total sales, failed payments, and cancelled orders. If the sales book skips a day, the weekly report is incomplete. If today's report still shows last week's sales, the report is stale.

## Key Takeaways

- Dates are central to pipelines and reporting.
- A date is not the same as a timestamp.
- `WHERE` filters date values.
- `BETWEEN` usually includes both boundaries.
- `>=` and `<` are useful for clean ranges.
- `ORDER BY` sorts oldest or newest records.
- `GROUP BY date_column` creates daily summaries.
- Date parts help create monthly and yearly summaries.
- `MAX(date_column)` helps check freshness.
- Pipeline run dates help monitor data refreshes.
- Event date and load date answer different questions.
- Freshness expectations depend on business rules.
- SQL date functions vary by database.

## Next Day Preview

Day 018 practises monthly reporting, date-based data quality checks, and period comparisons.

## Navigation

- Previous: [Day 016 - SQL Data Cleaning Practice](../day-016-sql-data-cleaning-practice/)
- Next: [Day 018 - SQL Date Practice and Period Reporting](../day-018-sql-date-practice-period-reporting/)
- [Back to Main Learning Path](../README.md)
