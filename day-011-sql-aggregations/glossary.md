# Day 011 Glossary

| Term | Simple Meaning | Beginner Example |
| --- | --- | --- |
| Aggregation | Combining many rows into a summary | Total sales from all orders |
| Summary | A shorter result created from detailed data | Orders by country |
| Metric | A number used to measure something | Total revenue |
| COUNT | Function that counts rows or values | Count orders |
| COUNT(*) | Counts all rows | Count every order row |
| COUNT(column_name) | Counts non-null values in a column | Count customers with email |
| Non-Null Count | Count of values that are not missing | Emails that exist |
| SUM | Adds numeric values | Total order amount |
| AVG | Calculates average value | Average product price |
| MIN | Finds smallest value | Lowest order amount |
| MAX | Finds largest value | Highest campaign revenue |
| GROUP BY | Creates summaries by group | Sales by country |
| Grouped Summary | One summary row per group | Orders per status |
| Alias | A readable output column name | `AS total_orders` |
| AS | Keyword used to name output columns | `COUNT(*) AS total_rows` |
| Total | Sum or full count | Total clicks |
| Average | Total divided by count | Average order amount |
| Minimum | Smallest value | Lowest product price |
| Maximum | Largest value | Latest order date |
| Row Count | Number of rows | Total rows in orders |
| Status Count | Count grouped by status | Orders by payment status |
| Sales Total | Sum of sales values | `SUM(order_amount)` |
| Average Order Value | Average order amount | `AVG(order_amount)` |
| Dashboard Metric | Number shown on a dashboard | Total customers |
| Business Metric | Number used by a business team | Revenue by channel |
| Data Quality Check | Test that data looks complete or correct | Count loaded rows |
| Source-to-Target Total | Total compared between systems | Source sales vs target sales |
| Latest Date | Most recent date | `MAX(order_date)` |
| Earliest Date | Oldest date | `MIN(order_date)` |
| Grouping Column | Column used in `GROUP BY` | `country` |
| Aggregated Column | Column used inside an aggregation function | `order_amount` in `SUM(order_amount)` |
| NULL in Aggregation | Missing values may affect some counts | `COUNT(email)` ignores null emails |
