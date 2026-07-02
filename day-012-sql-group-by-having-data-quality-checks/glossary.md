# Day 012 Glossary

| Term | Simple Meaning | Beginner Example |
| --- | --- | --- |
| HAVING | Filters grouped results after aggregation | Countries with sales above 1000 |
| GROUP BY | Creates summaries by group | Orders by country |
| Aggregated Result | A calculated summary value | `SUM(order_amount)` |
| Grouped Result | One summary row per group | One row per status |
| Group-Level Filter | Filter applied to summary groups | `HAVING COUNT(*) > 5` |
| Row-Level Filter | Filter applied to source rows | `WHERE payment_status = 'Paid'` |
| WHERE | Filters rows before grouping | Keep only active customers |
| COUNT | Counts rows or values | Count orders |
| SUM | Adds numeric values | Total sales |
| AVG | Calculates an average | Average order amount |
| MIN | Finds smallest value | Lowest order amount |
| MAX | Finds largest value | Latest order date |
| Threshold | A limit used for checking | More than 5 failed payments |
| Duplicate Check | Check for repeated IDs | Same order ID appearing twice |
| Repeated Value | Same value appearing multiple times | Same email in two rows |
| Status Distribution | Counts by status | Orders by payment status |
| Daily Summary | Summary for a day | Orders on one date |
| Summary Check | Check based on grouped results | Sales by country |
| Technical Summary Check | Checks loading or structure | Duplicate ID count |
| Business Summary Check | Checks business numbers | Revenue by channel |
| Warning | Something unusual to review | Sales slightly low |
| Failure | Data should not be trusted yet | Required daily rows missing |
| Data Quality Rule | Rule for checking data | No duplicate order IDs |
| Validation Rule | Defined check for trust | Latest date must be current |
| Zero-Activity Group | Group with no activity | Country with zero orders |
| High-Value Group | Group above a threshold | Channel with high revenue |
| Low-Value Group | Group below a threshold | Date with low sales |
| Multiple Grouping Columns | Grouping by more than one column | Date and country |
| Alias | Readable output column name | `AS total_orders` |
| Query Logic | Order of how SQL is understood | `WHERE` before `HAVING` |
| Business Context | Reason a threshold matters | Holiday sales may be higher |
| Pipeline Validation | Checking pipeline output | Daily row count check |
| Dashboard Validation | Checking dashboard metrics | Sales total review |
