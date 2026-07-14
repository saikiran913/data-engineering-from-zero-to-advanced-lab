# Day 015 SQL Data Cleaning Cheatsheet

## TRIM

```sql
TRIM(column_name) AS clean_column_name
```

Removes leading and trailing spaces.

## LOWER

```sql
LOWER(column_name) AS lowercase_column
```

Converts text to lowercase.

## UPPER

```sql
UPPER(column_name) AS uppercase_column
```

Converts text to uppercase.

## COALESCE

```sql
COALESCE(column_name, 'Unknown') AS clean_column_name
```

Returns the first non-`NULL` value.

## IS NULL

```sql
WHERE column_name IS NULL
```

Finds missing database values.

## Blank String Check

```sql
WHERE TRIM(column_name) = ''
```

Finds values that are empty or contain only spaces.

## Basic CASE

```sql
CASE
  WHEN condition THEN clean_value
  ELSE fallback_value
END AS clean_column_name
```

Creates a cleaned value based on rules.

## Clean Email Pattern

```sql
LOWER(TRIM(email)) AS clean_email
```

## Clean Text Status Pattern

```sql
CASE
  WHEN LOWER(TRIM(status_column)) = 'active' THEN 'Active'
  WHEN LOWER(TRIM(status_column)) = 'inactive' THEN 'Inactive'
  ELSE 'Unknown'
END AS clean_status
```

## Clean Country Pattern

Use `CASE` to map values like `UK`, `U.K.`, and `United Kingdom` to `UK`.

## Clean Boolean-Like Pattern

Use `CASE` to map `Y`, `Yes`, `true`, and `TRUE` to `true`, and `N`, `No`, `false`, and `FALSE` to `false`.

## Beginner Best Practices

- Keep raw data.
- Create clean output columns.
- Use aliases clearly.
- Trim before comparing text.
- Document standardisation rules.
- Do not replace missing values blindly.
- Check grouped results before and after cleaning.
- Avoid `SELECT *` in clean outputs.
- Validate cleaned values with business users.
- Remember SQL syntax can vary by platform.
