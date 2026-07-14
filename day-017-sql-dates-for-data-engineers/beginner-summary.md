# Beginner Summary

Dates are one of the most important parts of data engineering because most data pipelines and reports are tied to time. A business often wants to know what happened today, yesterday, last week, this month, or during a campaign period. A data engineer needs to know which date column answers the question and whether the data is fresh enough to trust.

A `date` usually means a calendar day only, such as `2026-06-15`. A `time` means the time of day only, such as `09:30:00`. A `datetime` combines date and time. A `timestamp` is also a point in time, often stored with more precision and sometimes with timezone information. Timezones are important, but Day 017 only introduces the idea lightly. The main beginner lesson is that a date column and a timestamp column should not be treated as exactly the same thing.

Date filtering starts with `WHERE`. To find orders from one day, you can write a filter such as `WHERE order_date = '2026-06-15'`. To filter a date range, beginners often use `BETWEEN`, such as `WHERE order_date BETWEEN '2026-06-01' AND '2026-06-30'`. `BETWEEN` usually includes both boundary dates, so June 1 and June 30 are included. Another common pattern is `WHERE order_date >= '2026-06-01' AND order_date < '2026-07-01'`. This start-inclusive and end-exclusive style is useful because it clearly stops before the next period and is especially helpful when timestamps are involved.

Sorting by date helps you see oldest or newest records. `ORDER BY order_date ASC` shows the oldest records first. `ORDER BY order_date DESC` shows the newest records first. This is useful when investigating recent activity or checking whether new data arrived.

Grouping by date creates daily reporting. For example, grouping orders by `order_date` and using `COUNT(*)` gives total orders per day. Adding `SUM(order_amount)` gives daily sales. The same idea works for campaign performance, website events, pipeline runs, and summary tables. Daily reporting is a core data engineering pattern because many dashboards need one row per day.

Date parts are pieces of a date, such as year, month, day, or week. If the date is `2026-06-15`, the year is `2026`, the month is `06`, and the day is `15`. Date parts help create monthly reports, yearly reports, weekly summaries, and later period comparisons. Many examples use `EXTRACT(YEAR FROM date_column)` and `EXTRACT(MONTH FROM date_column)`, but SQL date syntax varies across platforms. BigQuery and PostgreSQL often support `EXTRACT`, SQL Server often uses `DATEPART`, MySQL has functions like `YEAR`, and SQLite uses `strftime`.

Freshness checks answer a simple question: is the data up to date? The most common beginner freshness check is `MAX(date_column)`. For example, `SELECT MAX(summary_date) AS latest_summary_date FROM daily_sales_summary;` shows the latest summary date available. If the business expects yesterday's data but the latest date is last week, the data may be stale.

Pipeline run checks help explain why data is fresh or stale. A pipeline table may show `run_date`, `run_timestamp`, `status`, `records_processed`, `source_file_date`, and `completed_at`. These columns help data engineers check whether a pipeline ran, whether it succeeded, how many records it processed, and which source file date it loaded.

One important idea is event date versus load or run date. The event date is when the business activity happened. The load or run date is when the data was processed. An order might happen on June 10 but load on June 11. Choosing the wrong date column can create incorrect reports.

Before Day 018, remember this: always understand what each date column means, filter dates carefully, group by the correct date for daily reporting, check latest dates for freshness, and document date logic clearly. Clear date logic makes reports easier to explain, easier to validate, and much safer for business users to trust.
