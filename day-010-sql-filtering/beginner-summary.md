# Day 010 Beginner Summary

Filtering is one of the most important SQL skills for data engineers. In real work, data engineers rarely look at an entire table without narrowing it down first. They filter rows to investigate failed records, check missing values, find orders in a date range, review high-value transactions, inspect active customers, and prepare transformation rules.

The main keyword for filtering is `WHERE`. A `WHERE` clause returns only rows that match a condition. For example, `WHERE payment_status = 'Failed'` returns only failed payment records. This is useful when a data engineer needs to focus on a specific problem instead of reading every row.

`AND` is used when all conditions must be true. For example, a query can find orders where `payment_status = 'Paid'` and `order_amount > 500`. Both conditions must match. This is useful for business rules where several requirements must be met at the same time.

`OR` is used when at least one condition can be true. For example, a query can find orders where status is `Cancelled` or `Returned`. Either status is acceptable. `OR` is useful when investigating related categories of records.

Parentheses are important when mixing `AND` and `OR`. Without parentheses, a query may return rows that the writer did not intend. Parentheses make the logic clear, especially when one condition must apply together with a choice between two other conditions.

`IN` is used when a column can match one value from a list. For example, `country IN ('UK', 'India', 'USA')` is cleaner than writing three separate `OR` conditions. Data engineers use `IN` often when checking selected statuses, countries, categories, or channels.

`BETWEEN` filters values inside a range. It can be used for numbers, such as orders between 100 and 500, or dates, such as orders between two dates. `BETWEEN` usually includes both boundary values, but date and timestamp behavior can vary slightly by database, so data engineers must be careful.

`LIKE` is used for pattern matching in text. The percent wildcard `%` means any number of characters. `LIKE 'SQL%'` means starts with SQL. `LIKE '%Book'` means ends with Book. `LIKE '%Book%'` means contains Book. Case sensitivity can vary by database.

`NULL` means missing, unknown, or not available. `NULL` is not the same as zero or an empty string. To find missing values, use `IS NULL`. To find available values, use `IS NOT NULL`. A common beginner mistake is writing `= NULL`, which is not the correct way to check missing values.

Filtering can apply to text, numbers, dates, booleans, and missing values. Text values usually need quotes, numbers usually do not, dates are commonly written in quotes, and boolean syntax may vary by SQL tool.

Filtering supports data quality work from Day 008. It can help find missing emails, missing delivery dates, failed payments, cancelled orders, unexpected statuses, stale records, and suspicious values. Filtering also supports ETL and ELT from Day 005 because transformation logic often keeps valid records, separates invalid records, processes only a date range, or excludes records that should not be used in reporting.

Data engineers also use filters during investigations. If a dashboard number looks wrong, they may filter the source table to a specific country, status, date range, or customer group. If a batch pipeline processed only yesterday's data, they may filter by that exact date. If a marketing report looks unusual, they may filter campaigns by channel, budget range, or campaign status. These small filters help narrow a large problem into a smaller set of rows that can be reviewed carefully.

The safest way to learn filtering is step by step. Start with one condition. Then add a second condition with `AND`. Use `IN` when you have a list. Use `BETWEEN` when you have a range. Use `LIKE` only when you need pattern matching. Use `IS NULL` and `IS NOT NULL` when checking missing or available values. Add `ORDER BY` and `LIMIT` when you want results to be easier and safer to inspect.

Before Day 011, remember this: filtering is about asking more precise questions. Start with simple filters, test them step by step, use `LIMIT` when exploring, and use parentheses when logic becomes mixed. Strong filtering skills make later SQL topics much easier.
