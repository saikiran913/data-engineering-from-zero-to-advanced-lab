# Data Quality Cleaning Guide

## Cleaning Is Not the Same as Hiding Problems

Cleaning should make data more usable, not hide serious data issues. Some values can be standardised. Other issues should be flagged and investigated.

## Cleaning Extra Spaces

Extra spaces make values look different. Use `TRIM` to remove leading and trailing spaces.

## Cleaning Text Case

Different capitalization can split groups. Use `LOWER` for emails and `UPPER` for short codes.

## Cleaning Country Names

Country values such as `UK`, `U.K.`, `United Kingdom`, and `uk` should usually map to one standard value such as `UK`.

## Cleaning Status Values

Values like `active`, `ACTIVE`, and `Active` can become `Active`.

## Cleaning Boolean-Like Values

Values like `Y`, `Yes`, `true`, and `TRUE` can become `true`. Values like `N`, `No`, `false`, and `FALSE` can become `false`.

## Handling Missing Values

`Unknown` may be useful for readable reporting, but it can be dangerous if it hides an issue. Missing customer IDs or missing order amounts often need investigation instead of simple replacement.

## Cleaning Before Reporting

Dashboards should use clean standardised values so filters and charts are consistent.

## Cleaning Before GROUP BY

Dirty categories split metrics. `UK`, `U.K.`, and `United Kingdom` create three groups instead of one.

## Cleaning Before JOINs

Mismatched text or keys can cause missing joins. Clean key values carefully before using them for relationships.

## When Not to Auto-Clean

Flag or investigate missing customer ID, missing order amount, unknown product ID, invalid payment amount, broken relationship, and suspicious duplicate record.

## Cleaning Rule Documentation

| Column | Dirty Values | Clean Value | Rule | Business Owner | Notes |
| --- | --- | --- | --- | --- | --- |
| country | `U.K.`, `uk`, `United Kingdom` | `UK` | Trim and map known UK values | Data team | Validate with reporting users |

## Beginner Cleaning Checklist

- Identify dirty columns.
- Inspect raw values.
- Trim spaces.
- Standardise case.
- Check `NULL`s.
- Check blank strings.
- Map known values.
- Create `Unknown` only when appropriate.
- Keep raw and clean columns during testing.
- Compare grouped results before and after cleaning.
- Document rules.
- Validate with business users.
