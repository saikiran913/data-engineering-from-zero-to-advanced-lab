# Period Reporting Guide for Data Engineers

## What is a Reporting Period?

A reporting period is the time window used for a report.

Examples:

- day
- week
- month
- quarter
- year

## Daily Period

A daily period summarises activity for one date. Daily reporting is useful for operations, freshness checks, and short-term issue investigation.

## Monthly Period

A monthly period summarises activity for one month. Monthly reporting is useful for business reviews, campaign analysis, sales reporting, and dashboards.

## Why Period Definitions Matter

Different teams may define periods differently.

Examples:

- calendar month
- fiscal month
- campaign month
- rolling 30 days
- previous complete month

Day 018 uses simple calendar months.

## Calendar Month vs Rolling Period

| Period Type | Simple Meaning | Example |
| --- | --- | --- |
| Calendar month | A named month from first day to last day | June 1 to June 30 |
| Rolling period | A moving window from a chosen date | Last 30 days |

Rolling periods are useful, but this lesson does not create advanced SQL for them yet.

## Complete vs Incomplete Period

A complete month has finished. An incomplete month is still in progress.

Comparing a complete month with an incomplete month can be misleading because the incomplete month has fewer days of data.

## Period Comparison Questions

- Did sales increase from June to July?
- Did campaign cost decrease this month?
- Did conversions improve?
- Did failed payments increase?
- Did website purchases drop?
- Did one country perform worse than last month?

## Data Quality Before Period Comparison

Check:

- latest data available
- summary table refreshed
- failed pipeline runs
- missing dates
- duplicate summary rows
- zero-activity rows
- consistent definitions

## Period Reporting Documentation

| Metric | Date Column | Period Type | Filter Logic | Included Statuses | Excluded Statuses | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| Paid sales | `order_date` | Calendar month | `>= month_start` and `< next_month_start` | `Paid` | Failed, refunded | Example template |

## Beginner Period Reporting Checklist

- choose correct date column
- define period start and end
- check if period is complete
- filter data carefully
- group by correct period
- check latest date
- check pipeline status
- check summary duplicates
- compare only meaningful periods
- document assumptions
