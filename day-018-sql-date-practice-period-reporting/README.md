# Day 018 — SQL Date Practice: Monthly Reporting, Date-Based Data Quality Checks, and Period Comparisons

## Learning Goal

By the end of Day 018, you should understand how to create monthly reporting summaries, group data by year and month, filter one month using date ranges, compare two fixed periods manually, and run beginner date-based quality checks on daily and monthly reporting tables.

This lesson is still `SELECT`-based. Exact date syntax varies across SQL tools such as BigQuery, PostgreSQL, SQL Server, MySQL, and SQLite. The examples use `EXTRACT` for year and month, but your SQL platform may use a different date function.

## Connection to Day 017

Day 017 introduced date filters, date parts, freshness checks, and daily reporting. Day 018 practises these ideas using monthly reporting, quality checks, and simple period comparisons.

## Why Monthly Reporting Matters

Many business reports are reviewed monthly. Examples include:

- monthly sales
- monthly orders
- monthly campaign cost
- monthly campaign revenue
- monthly website activity
- monthly failed payments
- monthly dashboard refresh checks
- monthly pipeline monitoring

Data engineers often create or validate monthly reporting tables before business users see dashboards.

## Daily Reporting vs Monthly Reporting

| Reporting Type | Simple Meaning | Example Question | Common Use |
| --- | --- | --- | --- |
| Daily reporting | Summarises activity per day | How many orders happened on June 15? | Operational checks |
| Monthly reporting | Summarises activity per month | How much sales happened in June? | Business review dashboards |

Daily reporting is more detailed. Monthly reporting is more summarised.

## Grouping by Year and Month

Monthly reporting usually groups dates by both year and month.

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

Grouping by month alone can mix June 2025 with June 2026. Grouping by year and month keeps periods clear.

## Monthly Sales Report

```sql
SELECT
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month,
    country,
    COUNT(*) AS total_orders,
    SUM(order_amount) AS total_sales
FROM orders
WHERE payment_status = 'Paid'
GROUP BY
    EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date),
    country
ORDER BY order_year, order_month, country;
```

Step by step:

1. `FROM orders` reads order data.
2. `WHERE payment_status = 'Paid'` keeps paid orders.
3. `EXTRACT(YEAR...)` and `EXTRACT(MONTH...)` create reporting periods.
4. `GROUP BY` creates one result per year, month, and country.
5. `COUNT(*)` counts orders.
6. `SUM(order_amount)` totals sales.

## Monthly Campaign Report

```sql
SELECT
    EXTRACT(YEAR FROM performance_date) AS performance_year,
    EXTRACT(MONTH FROM performance_date) AS performance_month,
    channel,
    SUM(impressions) AS total_impressions,
    SUM(clicks) AS total_clicks,
    SUM(cost) AS total_cost,
    SUM(conversions) AS total_conversions,
    SUM(revenue) AS total_revenue
FROM campaign_performance
GROUP BY
    EXTRACT(YEAR FROM performance_date),
    EXTRACT(MONTH FROM performance_date),
    channel
ORDER BY performance_year, performance_month, channel;
```

This supports monthly marketing reporting.

## Filtering One Month Using Date Range

```sql
SELECT *
FROM orders
WHERE order_date >= '2026-06-01'
AND order_date < '2026-07-01';
```

This captures June records using start-inclusive and end-exclusive logic.

## Why Use Start-Inclusive and End-Exclusive Month Filters?

For date and timestamp data, filtering with `date >= month_start` and `date < next_month_start` is often safer than trying to guess the last moment of the month.

## Simple Period Comparison

A period comparison compares metrics from one time period with another time period.

Examples:

- June sales vs July sales
- this month orders vs previous month orders
- this month campaign cost vs previous month campaign cost
- current week events vs previous week events

Day 018 keeps this simple using fixed date ranges.

## Example: June Sales vs July Sales

Query 1: June paid sales.

```sql
SELECT SUM(order_amount) AS june_paid_sales
FROM orders
WHERE payment_status = 'Paid'
AND order_date >= '2026-06-01'
AND order_date < '2026-07-01';
```

Query 2: July paid sales.

```sql
SELECT SUM(order_amount) AS july_paid_sales
FROM orders
WHERE payment_status = 'Paid'
AND order_date >= '2026-07-01'
AND order_date < '2026-08-01';
```

At this stage, compare the two outputs manually.

## Example: Campaign Cost for Two Months

```sql
SELECT SUM(cost) AS june_campaign_cost
FROM campaign_performance
WHERE performance_date >= '2026-06-01'
AND performance_date < '2026-07-01';
```

```sql
SELECT SUM(cost) AS july_campaign_cost
FROM campaign_performance
WHERE performance_date >= '2026-07-01'
AND performance_date < '2026-08-01';
```

Later lessons will teach more advanced period comparison techniques.

## Date-Based Data Quality Checks

Date quality checks include:

- latest order date
- latest campaign date
- missing order dates
- future dates
- zero-order summary rows
- duplicate monthly summary rows
- failed monthly pipelines
- monthly summary not refreshed
- unusually low monthly totals
- unusually high failed payments

## Checking Latest Dates

```sql
SELECT MAX(order_date) AS latest_order_date
FROM orders;
```

```sql
SELECT MAX(performance_date) AS latest_performance_date
FROM campaign_performance;
```

```sql
SELECT MAX(summary_date) AS latest_daily_summary_date
FROM daily_sales_summary;
```

Latest date checks help identify stale data.

## Checking Monthly Summary Freshness

```sql
SELECT
    MAX(summary_year) AS latest_summary_year,
    MAX(summary_month) AS latest_summary_month
FROM monthly_sales_summary;
```

This beginner check shows the latest year and latest month values. More advanced checks later will handle year and month combinations more carefully.

## Checking Pipeline Freshness for Monthly Reports

```sql
SELECT
    pipeline_name,
    MAX(run_date) AS latest_run_date
FROM pipeline_runs
WHERE pipeline_name IN ('monthly_sales_summary_build', 'monthly_campaign_summary_build')
GROUP BY pipeline_name;
```

This shows whether monthly summary pipelines ran recently.

## Checking Failed Monthly Pipeline Runs

```sql
SELECT *
FROM pipeline_runs
WHERE pipeline_name IN ('monthly_sales_summary_build', 'monthly_campaign_summary_build')
AND status = 'Failed';
```

Failed summary pipelines matter because dashboards may not refresh.

## Checking Zero-Activity Daily Summary Rows

```sql
SELECT *
FROM daily_sales_summary
WHERE total_orders = 0;
```

Zero activity may be normal or may indicate a load or reporting issue.

## Checking Zero-Activity Monthly Summary Rows

```sql
SELECT *
FROM monthly_sales_summary
WHERE total_orders = 0;
```

Zero monthly orders for a country might be normal or suspicious depending on business context.

## Checking High Failed Payments

```sql
SELECT *
FROM monthly_sales_summary
WHERE failed_payments > 10;
```

The threshold is only an example.

## Checking Low Monthly Sales

```sql
SELECT *
FROM monthly_sales_summary
WHERE total_sales < 100;
```

Thresholds need business context.

## Duplicate-Looking Monthly Summary Checks

Monthly summary tables often should have one row per year, month, and country.

```sql
SELECT
    summary_year,
    summary_month,
    country,
    COUNT(*) AS row_count
FROM monthly_sales_summary
GROUP BY summary_year, summary_month, country
HAVING COUNT(*) > 1;
```

`HAVING` was introduced on Day 012 and is used here only for duplicate summary checks. Duplicate summary rows can inflate reports.

## Duplicate-Looking Monthly Campaign Summary Checks

```sql
SELECT
    summary_year,
    summary_month,
    channel,
    country,
    COUNT(*) AS row_count
FROM monthly_campaign_summary
GROUP BY summary_year, summary_month, channel, country
HAVING COUNT(*) > 1;
```

This checks whether a channel and country has more than one row for the same month.

## Date Gaps and Missing Periods

A date gap means expected dates or months are missing.

Examples:

- daily summary missing one day
- monthly summary missing one month
- one country missing in one month
- one channel missing in one month

Calendar-table methods for stronger gap detection will come later.

## Comparing Raw Daily Data to Summary Tables

Data engineers often compare raw daily records to summary tables.

Example:

```text
Orders table says June UK paid sales = 10,000.
Monthly summary table says June UK sales = 8,000.
That mismatch needs investigation.
```

This lesson keeps the idea conceptual and focused on separate beginner checks.

## Daily to Monthly Rollup

Monthly summaries are often created by rolling up daily data.

```text
Daily Orders
↓
Daily Sales Summary
↓
Monthly Sales Summary
↓
Monthly Dashboard
```

This is common in batch reporting.

## Period Comparison and Business Context

Comparing periods needs context:

- July may have fewer days if the month is incomplete.
- Campaign launch month may have higher costs.
- Holiday periods can change sales.
- A low month may be expected due to seasonality.
- Missing data can look like poor performance.

## Common Beginner Mistakes

1. Grouping by month number only without year.
2. Comparing months without checking whether the latest month is complete.
3. Using the wrong date column for monthly reporting.
4. Forgetting that date function syntax varies by SQL platform.
5. Treating zero orders as always wrong.
6. Treating low sales as always wrong.
7. Ignoring failed monthly summary pipelines.
8. Not checking duplicate rows in summary tables.
9. Comparing raw data and summary tables without understanding definitions.
10. Forgetting business context when setting thresholds.
11. Using `BETWEEN` carelessly with timestamp columns.
12. Thinking a dashboard is fresh just because it loads.

## Role of a Data Engineer

| Date Practice Task | Data Engineering Use |
| --- | --- |
| Create monthly sales report | Support monthly business reviews |
| Create monthly campaign report | Track marketing performance |
| Filter one month | Validate one reporting period |
| Compare two fixed periods | Spot changes in activity |
| Check latest report date | Detect stale data |
| Check failed monthly pipeline runs | Find refresh failures |
| Find zero-activity days | Investigate daily issues |
| Find zero-activity months | Investigate monthly issues |
| Find duplicate summary rows | Prevent inflated totals |
| Validate summary freshness | Protect dashboard trust |
| Document period logic | Make reports easier to maintain |

## Key Takeaways

- Monthly reporting groups dates by year and month.
- Daily reporting is more detailed than monthly reporting.
- Use fixed date ranges to filter one month.
- Start-inclusive and end-exclusive filters are clear and practical.
- Simple period comparisons can be done with two separate queries.
- Latest date checks help detect stale tables.
- Summary tables need quality checks.
- Duplicate monthly rows can inflate dashboard totals.
- Failed monthly pipelines can explain stale reports.
- Period comparisons need complete periods and business context.

## Next Day Preview

Day 019 will introduce `UNION` and `UNION ALL` for combining similar datasets.

## Navigation

- Previous: [Day 017 - SQL Dates for Data Engineers](../day-017-sql-dates-for-data-engineers/)
- Next: Day 019 - SQL UNION and UNION ALL for Data Engineers - Coming Soon
- [Back to Main Learning Path](../README.md)
