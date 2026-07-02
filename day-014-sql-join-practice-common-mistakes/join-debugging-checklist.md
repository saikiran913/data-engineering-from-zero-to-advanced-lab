# SQL JOIN Debugging Checklist for Beginners

## Before Writing the JOIN

- What business question am I answering?
- Which tables are needed?
- What is the primary key of each table?
- What is the foreign key?
- What is the relationship type?
- Which table should be preserved?
- Do I need matched rows only or all rows from one table?

## While Writing the JOIN

- Use table aliases.
- Prefix columns with aliases.
- Write the `ON` condition carefully.
- Join on IDs, not names, unless names are truly keys.
- Avoid `SELECT *` while debugging.
- Start with a small number of columns.
- Use `LIMIT` while exploring.
- Add one join at a time.

## After Running the JOIN

- Did row count increase?
- Did row count decrease?
- Are `NULL`s expected?
- Are unmatched records expected?
- Did one-to-many relationships multiply rows?
- Are totals inflated?
- Are important records missing?
- Did `WHERE` filters remove unmatched `LEFT JOIN` rows?
- Does the output answer the business question?
- Should the logic be documented?

## Row Count Debugging

Before the join, count rows in each source table. After an `INNER JOIN`, expect only matching records. After a `LEFT JOIN`, expect all left table records, but rows may multiply if the right table has many matches.

## Missing Match Debugging

Use `LEFT JOIN` and `WHERE right_table.key IS NULL` to find missing matches.

## Join Key Debugging

Confirm the right join key by checking the business relationship. IDs are usually safer than names or descriptive text.

## Business Logic Debugging

Technically valid joins can still be wrong if the business relationship is wrong.

## Documentation Template

| Business Question | Left Table | Right Table | Join Type | Join Key | Expected Result | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| Find orders with unknown customers | orders | customers | `LEFT JOIN` | `customer_id` | Orders where customer is missing | Investigate source load |
