# Data Freshness Checks for Data Engineers

## What is Data Freshness?

Data freshness means how up-to-date a dataset is compared with what the business expects.

If a daily dashboard should show yesterday's data, but the latest available date is last week, the data is stale.

## Why Freshness Matters

Freshness matters because people use reports to make decisions. A dashboard can look correct but still be old. Data engineers help protect trust by checking whether expected data arrived and whether pipelines ran successfully.

## Latest Date Check

The simplest freshness check uses `MAX(date_column)`.

```sql
SELECT MAX(summary_date) AS latest_summary_date
FROM daily_sales_summary;
```

This shows the latest date available in the table.

## Latest Date by Group

Sometimes one group is fresh and another group is stale.

```sql
SELECT
    country,
    MAX(summary_date) AS latest_summary_date
FROM daily_sales_summary
GROUP BY country;
```

You can check freshness per country, channel, event type, or pipeline.

## Pipeline Run Freshness

Pipeline freshness uses columns such as:

- `run_date`
- `run_timestamp`
- `completed_at`
- `status`

A successful run from today is usually better than a failed run from today or a successful run from last week.

## Source File Date

`source_file_date` describes the date represented by the source file. A pipeline might run today but only process an old source file. That is why source file dates matter.

## Records Processed Check

`records_processed` shows how many rows a pipeline handled. A successful pipeline with zero records may be fine for some sources, but it can also be a warning.

## Freshness Warning vs Failure

| Situation | Warning or Failure? | Reason |
| --- | --- | --- |
| Latest date one day behind | Warning or normal | Depends on expected refresh schedule |
| Latest date one week behind | Likely failure | Daily data is probably stale |
| Pipeline failed | Failure | New data may not have loaded |
| Pipeline success with zero rows | Warning | Could be normal or could mean missing source data |
| Dashboard showing old summary date | Failure or warning | Depends on reporting promise |

## Freshness Check Documentation

| Dataset | Date Column | Expected Refresh | Freshness Rule | Action if Stale | Owner |
| --- | --- | --- | --- | --- | --- |
| orders | order_date | Daily | Latest order date should be yesterday or today | Check source and pipeline | Data team |

## Common Freshness Problems

- source file did not arrive
- pipeline failed
- pipeline ran but processed zero rows
- data loaded to raw but not clean layer
- dashboard did not refresh
- wrong date column used
- late-arriving data
- timezone mismatch
- summary table not rebuilt

Timezone mismatch is listed here only as a light reminder. Detailed timezone handling comes later.

## Beginner Freshness Checklist

- check latest source date
- check latest target date
- check pipeline latest run
- check status of latest run
- check records processed
- check summary table latest date
- compare expected date with actual latest date
- document expected refresh time
- alert when freshness fails
- investigate source and pipeline logs later
