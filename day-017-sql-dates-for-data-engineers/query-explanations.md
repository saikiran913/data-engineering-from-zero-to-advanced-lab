# Query Explanations

This file explains the four Day 017 SQL practice files:

- `date-filtering-queries.sql`
- `date-parts-practice.sql`
- `freshness-checks.sql`
- `daily-reporting-queries.sql`

SQL date syntax varies by platform. The examples are beginner-friendly patterns, not platform-specific guarantees.

## Filtering Specific Dates

Purpose: return rows from one exact date.

Table used: `orders`, `customers`, `campaign_performance`, `website_events`, `pipeline_runs`, or `daily_sales_summary`.

Date column used: the date column that matches the business question, such as `order_date` or `event_date`.

Expected result: only rows for the selected date.

Why it matters in data engineering: daily files, daily dashboards, and daily checks often begin with one date.

## Filtering Date Ranges with BETWEEN

Purpose: return rows between two dates.

Table used: commonly `orders`, `campaign_performance`, and `website_events`.

Date column used: `order_date`, `performance_date`, or `event_date`.

Expected result: rows from the start date through the end date. `BETWEEN` usually includes both boundaries.

Why it matters in data engineering: date ranges are used for weekly reports, monthly reports, and backfills.

## Filtering Date Ranges with >= and <

Purpose: return rows from a period using a start-inclusive and end-exclusive pattern.

Table used: any date-based table.

Date column used: any reporting date column.

Expected result: rows on or after the start date and before the end date.

Why it matters in data engineering: this pattern is clear and often safer when timestamps are involved.

## Sorting by Date

Purpose: put records in time order.

Table used: `orders`, `campaign_performance`, `website_events`, or `pipeline_runs`.

Date column used: `order_date`, `performance_date`, `event_date`, or `run_date`.

Expected result: oldest-first with `ASC`, newest-first with `DESC`.

Why it matters in data engineering: sorting helps investigate recent records and understand data history.

## Grouping by Date

Purpose: create one summary result per date.

Table used: `orders`, `campaign_performance`, `website_events`, `pipeline_runs`, or `daily_sales_summary`.

Date column used: the daily reporting date, such as `order_date`.

Expected result: daily counts or daily totals.

Why it matters in data engineering: daily reporting is one of the most common pipeline outputs.

## Date Parts

Purpose: extract pieces of a date, such as year, month, or day.

Table used: any table with a date column.

Date column used: `order_date`, `signup_date`, `performance_date`, `event_date`, `run_date`, or `summary_date`.

Expected result: separate values such as `2026` for year or `6` for month.

Why it matters in data engineering: date parts support monthly, yearly, and period-based summaries.

Syntax note: BigQuery and PostgreSQL often support `EXTRACT`, SQL Server often uses `DATEPART`, MySQL has `YEAR` and `MONTH`, and SQLite uses `strftime`.

## Monthly Reporting

Purpose: group rows by year and month.

Table used: `orders`, `customers`, `campaign_performance`, `website_events`, or `daily_sales_summary`.

Date column used: the relevant reporting date.

Expected result: one result per year and month, such as total sales in June 2026.

Why it matters in data engineering: many business reports are monthly.

## Freshness Checks

Purpose: find the latest available date in a dataset.

Table used: `orders`, `campaign_performance`, `website_events`, `pipeline_runs`, or `daily_sales_summary`.

Date column used: often `MAX(order_date)`, `MAX(performance_date)`, `MAX(event_date)`, `MAX(run_date)`, or `MAX(summary_date)`.

Expected result: one latest date.

Why it matters in data engineering: the latest date helps show whether new data arrived.

## Pipeline Run Checks

Purpose: monitor pipeline health and refresh activity.

Table used: `pipeline_runs`.

Date column used: `run_date`, `run_timestamp`, `source_file_date`, and `completed_at`.

Expected result: latest run dates, failed runs, skipped runs, running runs, zero-record runs, and missing completion times.

Why it matters in data engineering: pipeline runs explain why data may be fresh or stale.

## Daily Reporting Outputs

Purpose: create simple daily summaries for business users.

Table used: `orders`, `campaign_performance`, `website_events`, `pipeline_runs`, and `daily_sales_summary`.

Date column used: `order_date`, `performance_date`, `event_date`, `run_date`, and `summary_date`.

Expected result: daily counts and totals such as total orders, total sales, total clicks, or total pipeline runs.

Why it matters in data engineering: daily outputs often feed dashboards and quality checks.

## Date-Related Data Quality Checks

Purpose: find date problems before users rely on reports.

Table used: any date-based table.

Date column used: the column being validated.

Expected result: rows with missing dates, future dates, stale dates, zero records, date gaps, or suspicious values.

Why it matters in data engineering: date errors can make reports incomplete or misleading.

## Event Date vs Load Date

Purpose: choose the correct date for the question.

Table used: `orders`, `website_events`, and `pipeline_runs`.

Date column used: an event date such as `order_date` or `event_date`, or a load/run date such as `run_date`.

Expected result: the query uses the date that matches the business question.

Why it matters in data engineering: using a load date for a sales report, or an event date for a pipeline monitoring question, can create wrong conclusions.
