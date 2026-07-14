# Day 015 Practice Questions

## Section 1: Simple Questions

1. What does data cleaning mean?
2. What is raw data?
3. What is clean data?
4. What does `NULL` mean?
5. What is a blank string?
6. Why is `Unknown` different from `NULL`?
7. What does `TRIM` do?
8. What does `LOWER` do?
9. What does `UPPER` do?
10. What does `COALESCE` do?
11. Why are aliases useful?
12. What does beginner `CASE` help with?

## Section 2: Identify the Cleaning Function

Choose `TRIM`, `LOWER`, `UPPER`, `COALESCE`, `CASE`, or `IS NULL`.

1. Email has uppercase letters.
2. Name has spaces before and after.
3. Country needs to become `UK`.
4. Missing city should display as `Unknown`.
5. Status values appear as `active`, `ACTIVE`, and `Active`.
6. Product active flag appears as `Y` and `Yes`.
7. Blank field contains spaces.
8. Campaign channel appears as `social` and `SOCIAL`.
9. Email field is `NULL`.
10. Country code should be uppercase.
11. Customer name has trailing spaces.
12. Payment status is blank.
13. Category appears in different cases.
14. Raw and clean columns need different names.
15. Missing value must be detected.

## Section 3: Dirty Value to Clean Value

Describe the cleaning rule:

1. ` sai ` -> `sai`
2. `STUDENT@EMAIL.COM` -> `student@email.com`
3. ` U.K. ` -> `UK`
4. `United Kingdom` -> `UK`
5. ` active ` -> `Active`
6. `PAID` -> `Paid`
7. `yes` -> `true`
8. `N` -> `false`
9. blank city -> `Unknown`
10. ` electronics ` -> `Electronics`
11. `U.S.A` -> `USA`
12. `pending` -> `Pending`
13. ` EMAIL ` -> `Email`
14. `FALSE` -> `false`
15. spaces-only value -> blank after `TRIM`

## Section 4: Choose the Correct Query

1. Trim customer name: `TRIM(customer_name) AS clean_customer_name`
2. Lowercase email: `LOWER(TRIM(email)) AS clean_email`
3. Uppercase country code: `UPPER(TRIM(country)) AS upper_country`
4. Replace `NULL` city: `COALESCE(city, 'Unknown') AS clean_city`
5. Standardise country names: use `CASE`
6. Standardise customer statuses: use `CASE`
7. Detect blank emails: `WHERE TRIM(email) = ''`
8. Group dirty country values: `GROUP BY country`
9. Group cleaned country values: `GROUP BY` the cleaning expression
10. Clean product category: use `TRIM`, `LOWER`, and `CASE`
11. Clean boolean-like active flag: use `CASE`
12. Clean campaign channel: use `CASE`

## Section 5: Write Cleaning Queries

Write SQL queries to:

1. Trim customer names.
2. Lowercase customer emails.
3. Find `NULL` emails.
4. Find blank emails using `TRIM`.
5. Replace `NULL` city with `Unknown`.
6. Standardise UK country values.
7. Standardise USA country values.
8. Standardise customer status.
9. Standardise order status.
10. Standardise payment status.
11. Standardise product category.
12. Standardise product `is_active` values.
13. Standardise campaign channel.
14. Compare dirty country grouping.
15. Compare clean country grouping.

## Section 6: Spot the Mistake

1. `WHERE email = NULL`
2. Replacing every missing value with `Unknown` without asking.
3. Using `LOWER(email)` without `TRIM`.
4. Creating a clean expression without an alias.
5. Using `SELECT *` in a clean output.
6. Mapping `India` to `UK`.
7. Treating blank strings and `NULL`s as always identical.
8. Hiding bad data with `Unknown`.
9. Lowercasing status values that should display as title case.
10. Mapping `N` to `true`.
11. Dropping raw values during testing.
12. Writing `CASE` without `ELSE`.

## Section 7: Data Quality Thinking

Decide whether to clean, flag, or investigate:

1. Missing customer ID.
2. Blank city.
3. Uppercase email.
4. Country written as `U.K.`.
5. Unknown product ID.
6. Order amount missing.
7. Status written as `active`.
8. Duplicate-looking customer record.

## Section 8: Think Like a Data Engineer

1. What is dirty?
2. What function should be used?
3. Should the raw value be preserved?
4. What should the clean column name be?
5. Is business approval needed?
6. How does the cleaned output help reporting?

## Section 9: Mini Assignment

Imagine you are preparing a clean customer and order dataset for dashboard use. Write or describe cleaning steps to:

1. Trim customer names.
2. Lowercase emails.
3. Replace missing city with `Unknown`.
4. Standardise country names.
5. Standardise customer statuses.
6. Standardise order statuses.
7. Standardise payment statuses.
8. Detect blank important fields.
9. Compare country groups before and after cleaning.
10. Explain which raw values should still be preserved.

## Answer Key

### Section 1

1. Preparing messy data for use.
2. Original source data.
3. Standardised data.
4. Missing database value.
5. Empty text value.
6. `Unknown` is a chosen label.
7. Removes leading and trailing spaces.
8. Converts text to lowercase.
9. Converts text to uppercase.
10. Returns first non-`NULL` value.
11. They create readable output names.
12. It maps dirty values to clean values.

### Section 2

1. `LOWER`
2. `TRIM`
3. `CASE`
4. `COALESCE`
5. `CASE`
6. `CASE`
7. `TRIM`
8. `CASE`
9. `IS NULL`
10. `UPPER`
11. `TRIM`
12. `TRIM`
13. `CASE`
14. alias with `AS`
15. `IS NULL`

### Section 3

Use trim, lowercase, uppercase, `CASE`, and `COALESCE` rules based on the dirty value.

### Section 5

Use the matching examples from `data-cleaning-queries.sql`.

### Section 6

1. Use `IS NULL`.
2. Needs business context.
3. Trim first.
4. Add `AS clean_column`.
5. Select clean columns intentionally.
6. Incorrect mapping.
7. Tool behavior can differ.
8. Document issues.
9. Use display standardisation.
10. Wrong boolean mapping.
11. Keep raw values for debugging.
12. Add an `ELSE` fallback.
