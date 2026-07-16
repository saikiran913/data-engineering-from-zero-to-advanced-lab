# Beginner Summary

Day 018 continues the SQL date practice from Day 017. Day 017 introduced date filters, date parts, freshness checks, and daily reporting. Day 018 uses those ideas for monthly reporting, date-based quality checks, and simple period comparisons. These are common data engineering tasks because many dashboards and business reviews are organised by month.

Monthly reporting matters because business teams often review activity in monthly cycles. Finance may ask for monthly sales. Marketing may ask for monthly campaign cost and revenue. Product teams may ask for monthly website purchases or signups. Data engineers often help create or validate the tables that feed these reports.

The first important idea is reporting grain. Grain means the level of detail in the data. A daily report might have one row per date. A monthly report might have one row per year and month. A country-month report might have one row per country per month. If you mix daily and monthly grain, totals can become confusing or incorrect.

When creating monthly reports from date columns, group by year and month together. Grouping by month alone is risky because month `6` could mean June in many different years. A safer beginner pattern is to use `EXTRACT(YEAR FROM order_date)` and `EXTRACT(MONTH FROM order_date)` together. The exact syntax varies by database. BigQuery and PostgreSQL often support `EXTRACT`, SQL Server often uses `DATEPART`, MySQL has functions such as `YEAR` and `MONTH`, and SQLite uses `strftime`.

Filtering one month is another key skill. Day 018 uses start-inclusive and end-exclusive logic. For example, June can be filtered with `order_date >= '2026-06-01' AND order_date < '2026-07-01'`. This means June 1 is included and July 1 is excluded. This style is clear and works well conceptually with both dates and timestamp-style values.

Period comparison means comparing one time window with another. Examples include June sales vs July sales, this month campaign cost vs previous month campaign cost, or monthly purchases by event type. In Day 018, comparisons stay simple. You run one query for the first period, run another query for the second period, and compare the two outputs manually. Later lessons can introduce more advanced comparison techniques.

Before comparing periods, check whether the periods are complete. Comparing a full month with a month that is still in progress can be misleading. If July has only ten days of data, it may look worse than June even if nothing is wrong. Business context matters.

Date-based quality checks are also important. A data engineer may check the latest order date, latest campaign performance date, latest daily summary date, or latest monthly summary period. These checks help detect stale data. A dashboard can load successfully while still showing old data.

Summary tables need their own checks. A daily summary row with zero orders might be normal, or it might mean data did not load. A monthly summary row with very low sales might be expected, or it might indicate a missing source. High failed payments might be a real business issue or a data issue. Thresholds should be documented and agreed with the business.

Duplicate summary rows are another common problem. A monthly sales summary might be expected to have one row per year, month, and country. If it has two rows for June 2026 and UK, totals may be inflated. Day 018 uses `GROUP BY` and `HAVING COUNT(*) > 1` only for these duplicate-looking summary checks.

Pipeline freshness connects reporting to data engineering operations. If a monthly summary pipeline failed or did not run for the latest month, the monthly dashboard may be stale. Checking `pipeline_runs` helps explain why a summary table is missing or old.

Before Day 019, remember this: monthly reports need clear periods, correct date columns, year and month grouped together, freshness checks, duplicate checks, and business context. Simple SQL can already reveal many reporting problems before users rely on a dashboard.
