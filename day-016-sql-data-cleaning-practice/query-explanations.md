# Query Explanations

These explanations describe the Day 016 SQL files in beginner language. SQL syntax can vary slightly between tools, but the ideas are portable.

## CASE Expression Basics

Purpose: `CASE` lets a query choose an output value based on conditions.

Table examples: `raw_customers`, `raw_orders`, `raw_campaign_performance`.

Expression pattern:

```sql
CASE
    WHEN condition THEN result
    ELSE fallback_result
END AS new_column_name
```

Expected result: each row receives one result, such as `Active`, `Unknown`, `Low`, or `Profitable`.

Why it matters: business users need clear labels instead of messy raw values.

## CASE for Cleaning

Purpose: turn inconsistent raw text into standard values.

Table example: `raw_customers`.

Expression used: `LOWER(TRIM(customer_status))` removes extra spaces and compares text in lowercase.

Expected result: values such as `active`, ` Active `, and `ACTIVE` can all become `Active`.

Why it matters: reports count categories correctly only when values are standardised.

## CASE for Business Labels

Purpose: create labels that explain business meaning.

Table example: `raw_orders`.

Expression used: `CASE WHEN order_amount >= 500 THEN 'Premium' ... END`.

Expected result: numeric amounts become readable bands such as `Low`, `Medium`, `High`, or `Premium`.

Why it matters: dashboards are easier to scan when important categories are already named.

## Derived Columns

Purpose: create a new output column from existing raw columns.

Table examples: `raw_orders`, `raw_products`, `raw_campaigns`.

Expression used: `CASE`, `TRIM`, `LOWER`, `UPPER`, `COALESCE`, and aliases.

Expected result: the query returns both original columns and helpful new columns such as `order_value_band`.

Why it matters: derived columns let analysts prepare useful outputs without changing the source table.

## Raw and Clean Columns Together

Purpose: compare messy input with the cleaned output.

Table example: `raw_customers`.

Expression used: select `country AS raw_country` and a `CASE` expression as `clean_country`.

Expected result: learners can see exactly how a rule changes a value.

Why it matters: side-by-side review helps catch mistakes before cleaned logic is reused.

## Business-Ready Outputs

Purpose: return columns that are ready for a report, dashboard, spreadsheet, or review.

Table examples: all Day 016 raw tables.

Expression used: clean names, clean statuses, grouped labels, and clear aliases.

Expected result: columns have readable names and consistent values.

Why it matters: business-ready data reduces confusion for non-technical readers.

## Grouped Inspection of Cleaned Values

Purpose: count cleaned categories to check whether cleaning rules make sense.

Table examples: `raw_customers`, `raw_orders`, `raw_campaigns`.

Expression used: the same `CASE` logic in `SELECT` and `GROUP BY`.

Expected result: one row per cleaned category with a count.

Why it matters: grouping makes unexpected `Unknown` values easier to notice.

## Cleaning Logic vs Business Logic

Purpose: understand the difference between fixing messy values and creating useful labels.

Cleaning example: map `U.K.`, `UK`, and `United Kingdom` to `UK`.

Business example: map `order_amount >= 500` to `Premium`.

Expected result: cleaning improves consistency; business logic improves interpretation.

Why it matters: both are useful, but they answer different questions.

## Documentation and Business Context

Purpose: explain why each rule exists.

Table examples: any raw table.

Expression used: comments in SQL files and notes in Markdown files.

Expected result: a future reader can understand why a value becomes `Unknown`, `Premium`, or `Needs Review`.

Why it matters: undocumented rules are hard to trust and harder to maintain.

## SELECT-Based Outputs

Purpose: practise transformations safely.

Table examples: all Day 016 raw tables.

Expression used: `SELECT ... FROM ...`.

Expected result: queries return transformed result sets but do not modify tables.

Why it matters: beginners can practise cleaning logic without changing source data.
