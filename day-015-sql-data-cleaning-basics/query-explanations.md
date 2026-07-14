# Query Explanations for Day 015

## Finding NULL Values

`IS NULL` finds database missing values. The purpose is to inspect fields where no value exists, such as missing email or status values.

## Finding Blank Values

Blank strings may look empty but still be text. `TRIM(column_name) = ''` helps find values that are empty or contain only spaces.

## Removing Extra Spaces with TRIM

`TRIM` removes leading and trailing spaces. This matters because `UK` and ` UK ` may behave like different values in filters or grouped summaries.

## Standardising Text Case with LOWER and UPPER

`LOWER` is useful for emails because email values are often easier to compare in lowercase. `UPPER` is useful for short codes such as country codes.

## Handling Missing Values with COALESCE

`COALESCE` returns the first non-`NULL` value. Replacement values such as `Unknown` depend on business rules and should not be used blindly.

## Creating Clean Column Names with AS

`AS` gives a readable name to a calculated output column. Example: `TRIM(customer_name) AS clean_customer_name`.

## Standardising Values with CASE

`CASE` maps known dirty values to clean values. It can standardise countries, statuses, categories, channels, and boolean-like values.

## Keeping Raw and Clean Values Together

During testing, show raw and clean values side by side. This helps data engineers debug and explain cleaning rules.

## Cleaning Before GROUP BY

Dirty values create messy groups. After standardising values like `UK`, `U.K.`, and `United Kingdom`, grouped summaries become easier to trust.

## Cleaning Before JOINs

Clean keys and reference values can reduce failed matches. Extra spaces or inconsistent case can cause relationship problems.

## SELECT-Based Cleaning vs Updating Source Data

This lesson creates cleaned outputs using `SELECT`. It does not update, delete, insert, or modify source tables.

## How Data Engineers Use These Queries

Data engineers use cleaning queries for staging clean data, preparing reporting tables, improving dashboard consistency, investigating dirty values, documenting cleaning rules, and supporting ETL/ELT pipelines.
