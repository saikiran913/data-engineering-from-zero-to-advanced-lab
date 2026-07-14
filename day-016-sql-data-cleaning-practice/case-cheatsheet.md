# Day 016 SQL CASE and Derived Columns Cheatsheet

## Basic CASE Pattern

```sql
CASE
  WHEN condition THEN result
  ELSE fallback_result
END AS new_column_name
```

## CASE with Text Cleaning

```sql
CASE
  WHEN LOWER(TRIM(status_column)) = 'active' THEN 'Active'
  ELSE 'Unknown'
END AS clean_status
```

## CASE with IN

```sql
CASE
  WHEN UPPER(TRIM(country)) IN ('UK', 'U.K.', 'UNITED KINGDOM') THEN 'UK'
  ELSE 'Unknown'
END AS clean_country
```

## CASE with Numeric Bands

```sql
CASE
  WHEN amount < 50 THEN 'Low'
  WHEN amount >= 50 AND amount < 200 THEN 'Medium'
  WHEN amount >= 200 AND amount < 500 THEN 'High'
  ELSE 'Premium'
END AS amount_band
```

## CASE with Boolean-Like Values

```sql
CASE
  WHEN LOWER(TRIM(flag_column)) IN ('true', 'yes', 'y') THEN 'true'
  WHEN LOWER(TRIM(flag_column)) IN ('false', 'no', 'n') THEN 'false'
  ELSE 'unknown'
END AS clean_flag
```

## CASE with Two Numeric Columns

```sql
CASE
  WHEN revenue > cost THEN 'Profitable'
  WHEN revenue = cost THEN 'Break Even'
  WHEN revenue < cost THEN 'Needs Review'
  ELSE 'Unknown'
END AS performance_label
```

## Derived Column

A derived column is created from existing columns.

## Business-Ready Output

A business-ready output uses clean columns, derived columns, readable names, and documented rules.

## Beginner Best Practices

- Always include `ELSE`.
- Always close with `END`.
- Use `AS` for clear column names.
- Clean text before comparing.
- Keep raw values during testing.
- Avoid hiding serious issues.
- Document mapping rules.
- Validate business labels with users.
- Avoid making `CASE` logic too complicated too early.
- Remember `SELECT`-based queries do not change source data.
