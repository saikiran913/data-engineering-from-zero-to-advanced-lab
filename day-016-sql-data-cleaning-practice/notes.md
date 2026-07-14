# Day 016 Notes - CASE, Derived Columns, and Business-Ready Outputs

## CASE Expression

`CASE` creates a new value based on conditions. It is useful when raw values need to be mapped to clean labels or business-friendly categories.

## WHEN, THEN, ELSE, and END

- `WHEN` checks a condition.
- `THEN` returns the result for that condition.
- `ELSE` returns a fallback result.
- `END` closes the expression.

## Why CASE Helps Cleaning

`CASE` helps standardise statuses, countries, channels, boolean-like values, and other messy labels. It also helps create amount bands and business labels.

## Common Standardisation

- Status: `active`, `ACTIVE`, `Active` -> `Active`
- Country: `U.K.`, `UK`, `United Kingdom` -> `UK`
- Channel: `search`, `SEARCH` -> `Search`
- Boolean-like: `Y`, `Yes`, `TRUE` -> `true`

## Derived Columns

A derived column is created from existing columns. Examples include `order_value_band`, `product_price_band`, `campaign_budget_band`, `performance_label`, and `order_health_label`.

## Business-Ready Outputs

Business-ready outputs use clean column names, standardised values, derived labels, and only useful columns. They are easier for dashboards and analysts to use.

## Raw vs Clean vs Business-Ready Columns

Raw columns show original data. Clean columns standardise values. Business-ready columns add readable labels and business meaning.

## Bands and Labels

Amount bands, price bands, and budget bands turn numeric values into readable groups. Performance labels and health labels help business users scan outputs quickly.

## Data Cleaning vs Business Logic

Cleaning fixes messy values. Business logic creates business meaning. Both need documentation and review.

## Documentation and Business Context

Document the source column, output column, rule, reason, and known exceptions. Business context prevents wrong labels.

## Common CASE Mistakes

- Missing `ELSE`.
- Missing `END`.
- Forgetting `AS`.
- Comparing dirty text without `TRIM`.
- Creating overlapping numeric bands.
- Hiding serious issues with `Unknown`.

## ETL/ELT Use

Data engineers use derived columns in pipelines to prepare clean layers and business-ready layers while preserving raw data.
