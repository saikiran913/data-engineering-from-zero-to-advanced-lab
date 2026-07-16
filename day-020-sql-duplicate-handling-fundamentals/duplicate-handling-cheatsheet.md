# Day 020 SQL Duplicate Handling Cheatsheet

## DISTINCT Pattern

```sql
SELECT DISTINCT column_name
FROM table_name;
```

## DISTINCT Combination Pattern

```sql
SELECT DISTINCT column1, column2
FROM table_name;
```

## Repeated Key Check

```sql
SELECT key_column, COUNT(*) AS row_count
FROM table_name
GROUP BY key_column
HAVING COUNT(*) > 1;
```

## Composite Key Check

```sql
SELECT key_column_1, key_column_2, COUNT(*) AS row_count
FROM table_name
GROUP BY key_column_1, key_column_2
HAVING COUNT(*) > 1;
```

## Cleaned Email Duplicate Check

```sql
SELECT LOWER(TRIM(email)) AS clean_email, COUNT(*) AS row_count
FROM customer_contacts
WHERE email IS NOT NULL
GROUP BY LOWER(TRIM(email))
HAVING COUNT(*) > 1;
```

## Inspect Repeated Records

```sql
SELECT *
FROM table_name
WHERE key_column = 'example_key'
ORDER BY source_file;
```

## Exact Duplicate-Style Check

Group by all important selected columns and count rows greater than 1.

## DISTINCT vs GROUP BY

| Task | Use |
| --- | --- |
| List unique values | `DISTINCT` |
| Find repeated keys | `GROUP BY` + `HAVING` |
| Count repeated values | `GROUP BY` + `COUNT` |
| Inspect duplicate details | Filter the repeated key |

## Safe Deduplication Checklist

- identify expected business key
- count repeated keys
- inspect repeated records
- compare source files
- compare statuses and dates
- ask whether repetition is expected
- document rule
- never delete raw data blindly
- do not use `DISTINCT` as a universal fix
- preserve raw layer

## Beginner Best Practices

- use `DISTINCT` for unique lists
- use `GROUP BY` and `HAVING` for duplicate investigation
- clean text before checking repeated emails
- distinguish exact duplicates from repeated business keys
- understand table grain
- consider `source_file`
- validate row counts
- document every deduplication assumption
