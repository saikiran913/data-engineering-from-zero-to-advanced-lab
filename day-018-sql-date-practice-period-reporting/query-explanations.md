# Query Explanations

This file explains the Day 018 SQL files:

- `monthly-reporting-queries.sql`
- `date-quality-checks.sql`
- `period-comparison-queries.sql`
- `daily-vs-monthly-reporting.sql`

## Monthly Reporting

Purpose: summarise activity by month.

Table used: `orders`, `campaign_performance`, `website_events`, or summary tables.

Date or period column used: `order_date`, `performance_date`, `event_date`, `summary_year`, and `summary_month`.

Expected result: one row per month, or one row per month and group such as country or channel.

Why it matters in data engineering: many dashboards and business reviews use monthly totals.

## Why Year and Month Should Be Used Together

Purpose: avoid mixing the same month from different years.

Table used: any table with date values.

Date or period column used: `EXTRACT(YEAR FROM date_column)` and `EXTRACT(MONTH FROM date_column)`.

Expected result: clear periods such as June 2026.

Why it matters in data engineering: grouping by month only can combine data from different years.

## One-Month Date Filters

Purpose: return rows for one calendar month.

Table used: `orders`, `campaign_performance`, or `website_events`.

Date or period column used: the business date column, such as `order_date`.

Expected result: rows from the month start up to, but not including, the next month start.

Why it matters in data engineering: fixed month filters are useful for validation and manual comparisons.

## Daily vs Monthly Reporting

Purpose: understand reporting grain.

Table used: detailed tables and summary tables.

Date or period column used: daily dates for daily reports; year and month for monthly reports.

Expected result: daily reports have more rows, while monthly reports have fewer summarised rows.

Why it matters in data engineering: mixing grains can create confusing or incorrect reports.

## Simple Period Comparisons

Purpose: compare two fixed time windows manually.

Table used: `orders`, `campaign_performance`, `website_events`, or summary tables.

Date or period column used: date filters such as June and July.

Expected result: one output for period A and one output for period B.

Why it matters in data engineering: beginners can compare periods before learning advanced comparison patterns.

## Monthly Sales Reporting

Purpose: summarise orders, paid sales, failed payments, and cancelled orders by month.

Table used: `orders` and `monthly_sales_summary`.

Date or period column used: `order_date`, `summary_year`, and `summary_month`.

Expected result: monthly order and sales totals.

Why it matters in data engineering: sales dashboards often depend on monthly summaries.

## Monthly Campaign Reporting

Purpose: summarise impressions, clicks, cost, conversions, and revenue by month.

Table used: `campaign_performance` and `monthly_campaign_summary`.

Date or period column used: `performance_date`, `summary_year`, and `summary_month`.

Expected result: monthly marketing performance totals.

Why it matters in data engineering: campaign teams need consistent monthly performance data.

## Monthly Website Event Reporting

Purpose: summarise website activity by month and event type.

Table used: `website_events`.

Date or period column used: `event_date`.

Expected result: monthly event counts, purchase counts, and signup counts.

Why it matters in data engineering: product teams often review activity trends by month.

## Date-Based Quality Checks

Purpose: find reporting problems connected to dates and periods.

Table used: all Day 018 sample tables.

Date or period column used: latest dates, summary periods, and pipeline run dates.

Expected result: rows that may need investigation.

Why it matters in data engineering: date issues can make dashboards stale or misleading.

## Duplicate Summary Checks

Purpose: find duplicate-looking rows in summary tables.

Table used: `monthly_sales_summary` and `monthly_campaign_summary`.

Date or period column used: `summary_year`, `summary_month`, and grouping columns such as `country` or `channel`.

Expected result: groups with `row_count` greater than 1.

Why it matters in data engineering: duplicate summary rows can inflate totals.

## Pipeline Freshness for Monthly Reports

Purpose: confirm whether monthly summary pipelines ran recently.

Table used: `pipeline_runs`.

Date or period column used: `run_date`, `source_file_date`, and `completed_at`.

Expected result: latest monthly pipeline run dates and failed runs.

Why it matters in data engineering: a stale monthly pipeline often means stale dashboards.

## Raw Daily Data vs Monthly Summary Tables

Purpose: conceptually compare detailed records and summarised results.

Table used: `orders`, `daily_sales_summary`, and `monthly_sales_summary`.

Date or period column used: `order_date`, `summary_date`, `summary_year`, and `summary_month`.

Expected result: raw and summary totals should be explainable.

Why it matters in data engineering: mismatches need investigation before reports are trusted.

## Business Context in Period Comparisons

Purpose: avoid overreacting to numbers without context.

Table used: any reporting table.

Date or period column used: any period column.

Expected result: comparisons are interpreted with complete periods, known thresholds, and business rules.

Why it matters in data engineering: missing data can look like poor performance, and normal business patterns can look like issues.
