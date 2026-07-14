# Glossary

| Term | Simple Meaning | Beginner Example |
| --- | --- | --- |
| Date | Calendar day only | `2026-06-15` |
| Time | Time of day only | `09:30:00` |
| Datetime | Date and time together | `2026-06-15 09:30:00` |
| Timestamp | A precise point in time | Event happened at `2026-06-15 09:30:05` |
| Date Column | A table column that stores a date | `order_date` |
| Event Date | Date an event happened | User clicked on June 15 |
| Order Date | Date an order happened | Order created on June 15 |
| Signup Date | Date a customer signed up | Customer joined on June 20 |
| Performance Date | Date marketing metrics belong to | Campaign results for June 15 |
| Run Date | Date a pipeline ran | Pipeline ran on June 16 |
| Run Timestamp | Exact time a pipeline ran | `2026-06-16 08:00:00` |
| Source File Date | Date represented by a source file | File contains June 15 data |
| Summary Date | Date represented by a summary row | Sales summary for June 15 |
| Completed At | Time a process finished | Pipeline completed at 08:10 |
| Date Filter | A condition that keeps specific dates | `WHERE order_date = '2026-06-15'` |
| Date Range | A start and end period | June 1 to June 30 |
| BETWEEN | SQL range filter that usually includes boundaries | `BETWEEN '2026-06-01' AND '2026-06-30'` |
| Start-Inclusive | The start date is included | Include June 1 |
| End-Exclusive | The end date is not included | Stop before July 1 |
| Latest Date | The newest date in a table | Latest order date |
| Earliest Date | The oldest date in a table | First signup date |
| MAX Date | Latest date found with `MAX` | `MAX(order_date)` |
| MIN Date | Earliest date found with `MIN` | `MIN(order_date)` |
| Data Freshness | How up-to-date data is | Dashboard has yesterday's data |
| Stale Data | Data older than expected | Latest summary is last week |
| Fresh Data | Data updated as expected | Latest summary is yesterday |
| Daily Reporting | Reporting one day at a time | Sales by order date |
| Daily Summary | One row or result per day | Total orders per day |
| Monthly Reporting | Reporting by month | Sales by year and month |
| Date Part | One piece of a date | Year, month, or day |
| Year | Four-digit year | `2026` |
| Month | Month number or name | `06` |
| Day | Day of month | `15` |
| Week | Week period in a year | Week 24 |
| Pipeline Run | One execution of a data pipeline | Orders load ran today |
| Records Processed | Rows handled by a pipeline | 20,000 rows loaded |
| Failed Run | Pipeline run that did not succeed | Status is `Failed` |
| Late-Arriving Data | Data that arrives after the event date | June 10 order loaded June 11 |
| Date Gap | Expected date is missing | June 3 missing from daily table |
| Future Date | Date later than expected | Order dated next year |
| Missing Date | Blank or null date | Order has no order date |
