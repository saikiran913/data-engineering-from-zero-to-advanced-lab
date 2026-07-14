# Day 015 Notes - SQL Data Cleaning Basics

## What Data Cleaning Means

Data cleaning means preparing messy data so it is easier to trust, join, group, filter, and report. In this lesson, cleaning is done with `SELECT` queries only. The source data is not modified.

## Why Raw Data Is Messy

Raw data can contain extra spaces, inconsistent capitalization, inconsistent labels, missing values, blank strings, old system formats, and values from different source systems.

## Raw Data vs Clean Data

Raw data is the original input. Clean data is a standardised output. Business-ready data is clean data shaped for reporting, dashboards, and analysis.

## Raw Layer, Clean Layer, Business Layer

- Raw layer: original data as received.
- Clean layer: standardised data.
- Business layer: reporting-ready data.

## NULL

`NULL` means a database value is missing or unknown. Use `IS NULL` to find it.

## Blank String

A blank string is text that looks empty, such as `''` or spaces. Use `TRIM(column_name) = ''` to find values that are empty after removing spaces.

## Unknown Value

`Unknown` is a readable label created by a cleaning rule. It is not the same as the original `NULL`. Use it only when business rules allow it.

## TRIM

`TRIM` removes leading and trailing spaces. It helps with names, emails, country values, statuses, product names, and campaign names.

## LOWER and UPPER

`LOWER` converts text to lowercase. It is useful for emails. `UPPER` converts text to uppercase. It is useful for short codes like country codes.

## COALESCE

`COALESCE` returns the first non-`NULL` value. It is useful for simple fallback values, but replacement values need business context.

## Aliases with AS

`AS` gives a readable name to an output column. Example: `TRIM(customer_name) AS clean_customer_name`.

## Clean Output Columns

Clean output columns are new columns created in a query. They do not change the source table.

## Basic CASE for Standardisation

`CASE` can map dirty values to clean values. Example: map `uk`, `U.K.`, and `United Kingdom` to `UK`.

## Common Standardisation Areas

- Country standardisation.
- Status standardisation.
- Email standardisation.
- Boolean-like value standardisation.
- Category and channel standardisation.

## Keep Raw and Clean Values

During testing, keep both raw and clean columns. This makes debugging easier and helps business users approve rules.

## Cleaning and Data Quality

Cleaning helps fix simple formatting and consistency issues. It does not automatically fix missing source records, broken relationships, fake values, or duplicate records without rules.

## Cleaning in ETL/ELT

In ETL, cleaning may happen before loading. In ELT, raw data is loaded first and SQL transformations create clean outputs.

## Cleaning Before Joins and GROUP BY

Cleaning join keys and reference values can improve matches. Cleaning grouping columns prevents values like `UK`, `uk`, and `U.K.` from becoming separate groups.

## Common Beginner Mistakes

- Updating raw data too early.
- Replacing missing values without business approval.
- Forgetting `TRIM`.
- Using `SELECT *` in clean outputs.
- Hiding quality problems with `Unknown`.
- Forgetting to document cleaning rules.
