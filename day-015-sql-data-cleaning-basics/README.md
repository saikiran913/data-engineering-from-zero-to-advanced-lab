# Day 015 - SQL Data Cleaning Basics: NULLs, Text Standardisation, and Clean Columns

## Learning Goal

By the end of Day 015, you should understand what data cleaning means, why raw data is often messy, how to identify `NULL` and blank values, and how to create clean output columns using `SELECT`. You will practise `TRIM`, `LOWER`, `UPPER`, `COALESCE`, aliases, and beginner `CASE` expressions for simple standardisation.

SQL syntax may vary slightly across BigQuery, PostgreSQL, SQL Server, MySQL, SQLite, and other tools. The examples in this lesson are mostly ANSI-style and beginner friendly.

## Connection to Previous Lessons

- Day 008 introduced data quality issues like missing values, duplicates, invalid formats, and inconsistent values.
- Day 010 showed how to filter records.
- Day 011 and Day 012 showed how to summarise data quality patterns.
- Day 013 and Day 014 showed how broken relationships can be found using joins.
- Day 015 now teaches how to create cleaner output columns using SQL.

## What is Data Cleaning?

Data cleaning means fixing, standardising, or preparing messy data so it becomes more useful and trustworthy.

Examples:

- Remove extra spaces from names.
- Make email addresses lowercase.
- Standardise country names.
- Replace missing status with `Unknown`.
- Convert inconsistent active flags into `true` or `false`.
- Create clear column aliases.
- Prepare clean data for dashboards.

## Why Raw Data Is Often Messy

Raw data can be messy because of manual typing mistakes, different source systems, different country naming styles, inconsistent capitalization, blank fields, old system formats, CSV export issues, API values changing over time, business teams using different labels, and optional fields being left empty.

## Raw Data vs Clean Data

| Raw Value | Problem | Clean Value |
| --- | --- | --- |
| ` sai ` | Extra spaces | `sai` |
| `SAI@EMAIL.COM` | Uppercase email | `sai@email.com` |
| `U.K.` | Inconsistent country | `UK` |
| ` active ` | Extra spaces and case | `Active` |
| blank status | Missing value | `Unknown` |

## Important Rule: Preserve Raw Data

Data engineers usually do not destroy raw data. They often keep:

- Raw layer: original data.
- Clean layer: cleaned and standardised data.
- Business layer: reporting-ready data.

```text
Raw Source Data
  |
  v
Cleaned Data
  |
  v
Business-Ready Data
  |
  v
Dashboard / Report
```

Keeping raw data helps auditing, debugging, and reprocessing.

## NULL, Blank, and Unknown

| Value Type | Meaning | Example |
| --- | --- | --- |
| `NULL` | Missing database value | email is `NULL` |
| Blank string | Text value that looks empty | `''` or spaces |
| Unknown | Label assigned by a cleaning rule | `Unknown` |

SQL tools may treat blank CSV fields differently depending on loading settings.

## Finding NULL Values

```sql
SELECT *
FROM dirty_customers
WHERE email IS NULL;
```

`IS NULL` is used for missing database values.

## Finding Blank Text Values

```sql
SELECT *
FROM dirty_customers
WHERE city = '';
```

```sql
SELECT *
FROM dirty_customers
WHERE TRIM(city) = '';
```

`TRIM` helps detect values that look blank but contain spaces.

## COALESCE for NULL Handling

`COALESCE` returns the first non-`NULL` value from a list.

```sql
SELECT
  customer_id,
  COALESCE(email, 'missing_email@example.com') AS clean_email
FROM dirty_customers;
```

This does not change the source table. It creates a cleaned output column. Replacement values should be chosen carefully based on business rules.

## TRIM for Removing Extra Spaces

```sql
SELECT
  customer_name,
  TRIM(customer_name) AS clean_customer_name
FROM dirty_customers;
```

Extra spaces cause problems in grouping, filtering, joins, and dashboards.

## LOWER for Standardising Emails

```sql
SELECT
  email,
  LOWER(TRIM(email)) AS clean_email
FROM dirty_customers;
```

Emails are often standardised to lowercase.

## UPPER for Standardising Codes

```sql
SELECT
  country,
  UPPER(TRIM(country)) AS upper_country
FROM dirty_customers;
```

Country codes and short codes are often stored uppercase.

## Aliases with AS

`AS` gives a clean name to an output column.

```sql
SELECT
  TRIM(customer_name) AS clean_customer_name
FROM dirty_customers;
```

Aliases make cleaned output easy to understand.

## Basic Text Standardisation

Text standardisation means mapping different raw values to one clean value:

- `active`, `ACTIVE`, `Active` -> `Active`
- `uk`, `U.K.`, `United Kingdom` -> `UK`
- `email`, `EMAIL`, `Email` -> `Email`
- `yes`, `Y`, `TRUE` -> `true`

## Basic CASE for Standardisation

`CASE` lets us create a new value based on conditions.

```sql
SELECT
  country,
  CASE
    WHEN UPPER(TRIM(country)) IN ('UK', 'U.K.', 'UNITED KINGDOM') THEN 'UK'
    WHEN UPPER(TRIM(country)) IN ('USA', 'U.S.A', 'UNITED STATES') THEN 'USA'
    WHEN UPPER(TRIM(country)) = 'INDIA' THEN 'India'
    ELSE TRIM(country)
  END AS clean_country
FROM dirty_customers;
```

Day 015 uses `CASE` only for simple cleaning. It will be explored more deeply later.

## Cleaning Customer Data Example

```sql
SELECT
  customer_id,
  customer_name AS raw_customer_name,
  TRIM(customer_name) AS clean_customer_name,
  country AS raw_country,
  CASE
    WHEN UPPER(TRIM(country)) IN ('UK', 'U.K.', 'UNITED KINGDOM') THEN 'UK'
    WHEN UPPER(TRIM(country)) IN ('USA', 'U.S.A', 'UNITED STATES') THEN 'USA'
    WHEN UPPER(TRIM(country)) = 'INDIA' THEN 'India'
    ELSE COALESCE(TRIM(country), 'Unknown')
  END AS clean_country,
  COALESCE(TRIM(city), 'Unknown') AS clean_city,
  LOWER(TRIM(email)) AS clean_email,
  CASE
    WHEN LOWER(TRIM(customer_status)) = 'active' THEN 'Active'
    WHEN LOWER(TRIM(customer_status)) = 'inactive' THEN 'Inactive'
    WHEN LOWER(TRIM(customer_status)) = 'pending' THEN 'Pending'
    WHEN LOWER(TRIM(customer_status)) = 'blocked' THEN 'Blocked'
    ELSE 'Unknown'
  END AS clean_customer_status
FROM dirty_customers;
```

## Cleaning Order Data Example

Create clean order status, payment status, and country values using `TRIM`, `LOWER`, `UPPER`, `COALESCE`, and simple `CASE`.

## Cleaning Product Data Example

Product cleaning can create `clean_product_name`, `clean_category`, and `clean_is_active`. Boolean-like values such as `Y`, `Yes`, `TRUE`, and `true` can become `true`; `N`, `No`, `FALSE`, and `false` can become `false`; blanks can become `unknown`.

## Cleaning Campaign Data Example

Campaign cleaning can create `clean_campaign_name`, `clean_channel`, `clean_country`, and `clean_campaign_status`.

## Clean Columns vs Source Columns

A cleaning query can keep both raw and clean values:

```sql
SELECT
  customer_id,
  country AS raw_country,
  CASE
    WHEN UPPER(TRIM(country)) IN ('UK', 'U.K.', 'UNITED KINGDOM') THEN 'UK'
    ELSE TRIM(country)
  END AS clean_country
FROM dirty_customers;
```

This helps debugging.

## Data Cleaning and Data Quality

Cleaning can help with extra spaces, inconsistent capitalization, inconsistent labels, missing readable values, blank fields, and simple text standardisation. It cannot automatically solve wrong business logic, missing source records, fake values, broken relationships, duplicate records without rules, or unknown real-world truth.

## Data Cleaning in ETL and ELT

In ETL, cleaning may happen before loading data into the target. In ELT, raw data may be loaded first, then cleaned inside the warehouse. SQL is commonly used for ELT transformations.

## Data Cleaning Before Joins

Messy keys or text values can cause joins to fail. Examples include customer IDs with spaces, country values written differently, product codes with inconsistent case, and campaign IDs with extra spaces.

## Data Cleaning Before GROUP BY

Without cleaning, `GROUP BY` may create separate groups for `UK`, `U.K.`, `United Kingdom`, and `uk`. After cleaning, they can all become `UK`.

## Common Beginner Mistakes

1. Thinking cleaning always means changing the original table.
2. Replacing `NULL` values without business approval.
3. Treating blank strings and `NULL`s as exactly the same in every system.
4. Forgetting to `TRIM` before comparing text.
5. Lowercasing values that should be uppercase codes.
6. Standardising values incorrectly.
7. Hiding data quality problems instead of documenting them.
8. Using `SELECT *` in cleaning outputs.
9. Not keeping raw values for debugging.
10. Cleaning data without understanding business meaning.
11. Assuming every missing value should become `Unknown`.
12. Forgetting SQL syntax can vary by database.

## Role of a Data Engineer

| Cleaning Task | Data Engineering Use |
| --- | --- |
| Remove extra spaces | Improve matching and grouping |
| Standardise email case | Support consistent contact data |
| Standardise country names | Improve reporting |
| Standardise status values | Make dashboard filters reliable |
| Handle NULLs carefully | Avoid confusing missing values |
| Create clean output columns | Prepare transformation outputs |
| Keep raw and clean values | Support debugging |
| Document cleaning rules | Make logic repeatable |
| Prepare data for joins | Reduce failed matches |
| Prepare data for GROUP BY | Improve summary accuracy |
| Support dashboards | Make labels consistent |
| Improve data trust | Help users rely on outputs |

## Beginner Analogy: Cleaning a Contact List

A contact list may contain names with extra spaces, emails in uppercase, missing phone numbers, city names written differently, and inconsistent status labels. Cleaning makes the list easier to search, group, and use.

## Beginner Analogy: School Attendance Sheet

If class names are written as `Class 6`, `class6`, `CLASS 6`, and `6th Class`, summaries become messy. Standardisation helps make reporting consistent.

## Key Takeaways

- Data cleaning prepares messy data for use.
- Raw data should usually be preserved.
- `NULL`, blank, and `Unknown` are different ideas.
- Use `IS NULL` for database missing values.
- Use `TRIM` to remove extra spaces.
- Use `LOWER` for email standardisation.
- Use `UPPER` for codes.
- Use `COALESCE` carefully for `NULL` handling.
- Use aliases for clean output names.
- Use simple `CASE` for beginner standardisation.
- Keep raw and clean values during testing.
- Cleaning before `GROUP BY` improves summaries.
- Cleaning before joins can improve matches.
- Cleaning rules need business context.
- `SELECT`-based cleaning does not modify source data.

## Next Day Preview

Day 016 will introduce SQL Data Cleaning Practice: `CASE` expressions, derived columns, and business-ready outputs.

## Navigation

- Previous: [Day 014 - SQL JOIN Practice and Common Join Mistakes](../day-014-sql-join-practice-common-mistakes/)
- Next: [Day 016 - SQL Data Cleaning Practice](../day-016-sql-data-cleaning-practice/)
- [Back to Main Learning Path](../README.md)
