# Glossary

| Term | Simple Meaning | Beginner Example |
| --- | --- | --- |
| Reporting Period | Time window used for a report | June 2026 |
| Daily Reporting | Reporting by day | Sales by `order_date` |
| Monthly Reporting | Reporting by month | Sales by year and month |
| Period Comparison | Comparing one time window with another | June sales vs July sales |
| Calendar Month | First day to last day of a month | June 1 to June 30 |
| Rolling Period | Moving time window | Last 30 days |
| Complete Period | A period that has finished | Full month of June |
| Incomplete Period | A period still in progress | July on July 10 |
| Year | Year part of a date | `2026` |
| Month | Month part of a date | `6` for June |
| Date Part | Piece of a date | Year or month |
| EXTRACT | SQL function pattern for date parts | `EXTRACT(MONTH FROM order_date)` |
| Monthly Summary | Aggregated monthly result | Orders by month |
| Daily Summary | Aggregated daily result | Orders by date |
| Rollup | Summarising detailed data | Daily to monthly totals |
| Daily-to-Monthly Rollup | Monthly total made from daily rows | June total from June days |
| Start-Inclusive Filter | Start date is included | `>= '2026-06-01'` |
| End-Exclusive Filter | End date is not included | `< '2026-07-01'` |
| Latest Date | Newest date in data | `MAX(order_date)` |
| Freshness Check | Check whether data is up to date | Latest summary period |
| Stale Monthly Report | Monthly report older than expected | June shown when July expected |
| Zero-Activity Period | Period with zero activity | Zero monthly orders |
| Low Sales Period | Period with unusually low sales | Sales below 100 |
| High Failed Payments | More failed payments than expected | Failed payments above 10 |
| Duplicate Summary Row | More than one row for same summary grain | Two June UK rows |
| Summary Grain | Level of detail in summary | Year-month-country |
| Grain | Level of detail in data | Daily or monthly |
| Monthly Pipeline | Pipeline that builds monthly data | `monthly_sales_summary_build` |
| Failed Monthly Run | Monthly pipeline run that failed | Status is `Failed` |
| Period Definition | Rule for the reporting window | Calendar month |
| Business Context | Business meaning behind a threshold | Holiday sales may be high |
| Threshold | Example cutoff for review | Sales below 100 |
