# Day 016 - SQL Data Cleaning Practice: CASE Expressions, Derived Columns, and Business-Ready Outputs

## Learning Goal

By the end of Day 016, you should understand how `CASE` expressions help create clean values, derived columns, and business-ready outputs. You will practise standardising messy statuses, countries, channels, boolean-like values, amount bands, price bands, budget bands, performance labels, conversion labels, and order health labels using `SELECT`-based transformations only.

SQL syntax may vary slightly across BigQuery, PostgreSQL, SQL Server, MySQL, SQLite, and other tools. The examples are beginner-friendly and mostly ANSI-style.

## Connection to Day 015

Day 015 introduced `TRIM`, `LOWER`, `UPPER`, `COALESCE`, aliases, and simple `CASE`. Day 016 gives more practical cleaning examples using `CASE` and derived columns. The goal is to create business-ready `SELECT` outputs without changing raw source tables.

## What is a CASE Expression?

`CASE` allows SQL to create a new value based on conditions.

```sql
CASE
  WHEN condition THEN result
  WHEN another_condition THEN another_result
  ELSE fallback_result
END AS new_column_name
```

- `WHEN` checks a condition.
- `THEN` returns a result when the condition is true.
- `ELSE` returns a fallback value.
- `END` closes the `CASE` expression.
- `AS` gives the output column a readable name.

## Why CASE is Useful for Data Cleaning

`CASE` helps data engineers standardise messy statuses, country names, channel names, and yes/no values. It can also create readable categories, business labels, numeric bands, and dashboard-ready columns.

## CASE for Status Standardisation

```sql
SELECT
  customer_status,
  CASE
    WHEN LOWER(TRIM(customer_status)) = 'active' THEN 'Active'
    WHEN LOWER(TRIM(customer_status)) = 'inactive' THEN 'Inactive'
    WHEN LOWER(TRIM(customer_status)) = 'pending' THEN 'Pending'
    WHEN LOWER(TRIM(customer_status)) = 'blocked' THEN 'Blocked'
    ELSE 'Unknown'
  END AS clean_customer_status
FROM raw_customers;
```

This is better than grouping raw status values directly because `active`, `ACTIVE`, and `Active` become one clean label.

## CASE for Country Standardisation

```sql
SELECT
  country,
  CASE
    WHEN UPPER(TRIM(country)) IN ('UK', 'U.K.', 'UNITED KINGDOM') THEN 'UK'
    WHEN UPPER(TRIM(country)) IN ('USA', 'U.S.A', 'UNITED STATES') THEN 'USA'
    WHEN UPPER(TRIM(country)) = 'INDIA' THEN 'India'
    WHEN UPPER(TRIM(country)) = 'CANADA' THEN 'Canada'
    WHEN UPPER(TRIM(country)) = 'GERMANY' THEN 'Germany'
    WHEN UPPER(TRIM(country)) = 'AUSTRALIA' THEN 'Australia'
    ELSE 'Unknown'
  END AS clean_country
FROM raw_customers;
```

Business rules should define standard country values.

## CASE for Channel Standardisation

Map `Search`, `search`, and `SEARCH` to `Search`; `Email` and `EMAIL` to `Email`; and blanks to `Unknown`. This is useful for marketing reporting.

## CASE for Boolean-Like Values

```sql
SELECT
  marketing_opt_in,
  CASE
    WHEN LOWER(TRIM(marketing_opt_in)) IN ('true', 'yes', 'y') THEN 'true'
    WHEN LOWER(TRIM(marketing_opt_in)) IN ('false', 'no', 'n') THEN 'false'
    ELSE 'unknown'
  END AS clean_marketing_opt_in
FROM raw_customers;
```

## What is a Derived Column?

A derived column is a new column created from existing columns. Examples include `clean_country`, `order_value_band`, `campaign_profit_label`, `product_price_band`, and `is_high_value_order`.

## Derived Column Example: Order Value Band

```sql
SELECT
  order_id,
  order_amount,
  CASE
    WHEN order_amount IS NULL THEN 'Unknown'
    WHEN order_amount < 50 THEN 'Low'
    WHEN order_amount >= 50 AND order_amount < 200 THEN 'Medium'
    WHEN order_amount >= 200 AND order_amount < 500 THEN 'High'
    ELSE 'Premium'
  END AS order_value_band
FROM raw_orders;
```

## Derived Column Example: Product Price Band

Below 20 is `Low`, 20 to 99.99 is `Medium`, 100 to 299.99 is `High`, 300 and above is `Premium`, and missing price is `Unknown`.

## Derived Column Example: Campaign Budget Band

Below 1000 is `Small`, 1000 to 4999.99 is `Medium`, 5000 and above is `Large`, and missing budget is `Unknown`.

## Derived Column Example: Campaign Performance Label

Use `cost` and `revenue` to create a simple label: `Profitable`, `Break Even`, `Needs Review`, `No Revenue`, `Check Cost Data`, or `Unknown`. Real marketing analytics can be more complex, but this beginner label is useful for practice.

## Derived Column Example: Conversion Label

Use conversions to create labels: `No Conversions`, `Low Conversions`, `Medium Conversions`, or `High Conversions`.

## Raw Columns and Clean Columns Together

During cleaning development, keep raw and clean columns side by side.

```sql
SELECT
  customer_id,
  country AS raw_country,
  CASE
    WHEN UPPER(TRIM(country)) IN ('UK', 'U.K.', 'UNITED KINGDOM') THEN 'UK'
    ELSE 'Unknown'
  END AS clean_country
FROM raw_customers;
```

This helps debugging and review.

## Business-Ready Output

Business-ready output is cleaned, standardised, labelled, and shaped so analysts or dashboards can use it more easily. It does not mean perfect data, but it should be more consistent and understandable than raw data.

## Business-Ready Examples

Day 016 includes business-ready customer, order, product, campaign, and campaign performance output examples in `business-ready-output.sql`.

## Cleaning Rules Need Documentation

| Raw Field | Clean Field | Cleaning Rule | Business Reason |
| --- | --- | --- | --- |
| country | clean_country | Map `U.K.` and `United Kingdom` to `UK` | Consistent country reporting |
| payment_status | clean_payment_status | Standardise status case | Reliable filters |
| order_amount | order_value_band | Convert amount ranges to labels | Dashboard grouping |
| cost/revenue | performance_label | Compare revenue and cost | Campaign review |

## Data Cleaning vs Business Logic

| Type | Simple Meaning | Example |
| --- | --- | --- |
| Data cleaning | Standardising messy values | `paid`, `PAID`, `Paid` -> `Paid` |
| Business logic | Creating business meaning | `Paid` + `Delivered` -> `Healthy Order` |

## Why Business Context Matters

`CASE` expressions can create wrong outputs if business rules are misunderstood. Cancelled orders are not always bad data, zero revenue may be normal for awareness campaigns, and high cost may be expected during launch campaigns.

## Common Beginner Mistakes

1. Forgetting `ELSE`.
2. Forgetting `END`.
3. Not using `AS`.
4. Comparing dirty text without `TRIM` or `LOWER`.
5. Creating labels without business understanding.
6. Mixing cleaning logic and business logic without documentation.
7. Replacing every missing value with `Unknown`.
8. Hiding serious data quality issues with labels.
9. Making `CASE` too complicated too early.
10. Forgetting `SELECT` outputs do not change source data.
11. Not keeping raw values during testing.
12. Creating inconsistent clean labels across tables.

## Role of a Data Engineer

| Task | Data Engineering Use |
| --- | --- |
| Standardise raw values | Improve consistency |
| Create clean columns | Prepare transformation outputs |
| Create derived columns | Add business meaning |
| Build business-ready outputs | Support dashboards |
| Document cleaning rules | Make logic reusable |
| Validate labels with business users | Avoid wrong assumptions |
| Prepare dashboard-ready data | Help analysts |
| Improve data trust | Reduce confusion |
| Avoid changing raw data directly | Preserve audit trail |
| Separate raw, clean, and business layers | Improve maintainability |

## Beginner Analogy: Organising Exam Results

Raw marks may have messy subject names. Cleaning maps `math`, `MATH`, and `Maths` to `Maths`. A derived column can label marks above 80 as `Excellent`, 50 to 80 as `Pass`, and below 50 as `Needs Improvement`.

## Beginner Analogy: Shop Order Labels

Cleaning maps `paid`, `PAID`, and `Paid` to `Paid`. A derived column can label `Paid` plus `Delivered` as `Healthy`, failed payment as `Payment Issue`, and returned orders as `Needs Review`.

## Key Takeaways

- `CASE` creates values from conditions.
- `WHEN`, `THEN`, `ELSE`, and `END` each have a role.
- `CASE` is useful for cleaning and labels.
- Clean text before comparing it.
- Derived columns are new columns from existing values.
- Amount bands make numeric values easier to group.
- Performance labels add business meaning.
- Raw and clean columns together help debugging.
- Business-ready output is cleaner and more readable.
- Cleaning rules and business rules are different.
- Business context matters.
- Always document rules.
- Use `SELECT`-based transformations for practice.
- Source tables are not changed.
- Keep logic simple at first.

## Next Day Preview

Day 017 introduces SQL Dates for Data Engineers: date filters, date parts, freshness checks, and daily reporting.

## Navigation

- Previous: [Day 015 - SQL Data Cleaning Basics](../day-015-sql-data-cleaning-basics/)
- Next: [Day 017 - SQL Dates for Data Engineers](../day-017-sql-dates-for-data-engineers/)
- [Back to Main Learning Path](../README.md)
