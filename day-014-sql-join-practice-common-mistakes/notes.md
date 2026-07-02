# Day 014 Notes - JOIN Practice and Mistakes

## INNER JOIN Review

`INNER JOIN` returns rows where both tables match. It is useful for matched reporting data, but it hides unmatched records.

## LEFT JOIN Review

`LEFT JOIN` keeps all rows from the left table and adds matching rows from the right table. Missing right-side matches appear as `NULL`.

## Choosing the Correct Join Type

Use `INNER JOIN` when you need matched rows only. Use `LEFT JOIN` when you need all rows from one table or want to find missing matches.

## Choosing the Correct Left Table

The left table is the table after `FROM`. If you need all customers, start from `customers`. If you need all payments, start from `payments`.

## Join Keys and ON Condition

The join key is the column used to connect tables. The `ON` condition explains the relationship, such as `o.customer_id = c.customer_id`.

## Table Aliases

Aliases such as `c`, `o`, `p`, `oi`, `ca`, `cp`, `pay`, and `st` keep queries short. Prefix columns with aliases to avoid ambiguous names.

## Row Count Changes

Rows can increase after a one-to-many join. Rows can decrease after an `INNER JOIN` if unmatched rows are removed. A `LEFT JOIN` preserves left rows, but rows may still multiply when the right table has many matches.

## Unmatched Records and NULLs

`NULL` values after a `LEFT JOIN` mean no matching right-side row was found. This can be normal or suspicious depending on the business context.

## Filtering After LEFT JOIN

`WHERE` filters after the join. Filtering right-side columns can remove unmatched rows, which may surprise beginners.

## Common Mistakes

- Missing `ON`.
- Wrong join key.
- Wrong join type.
- Wrong left table.
- Ambiguous columns.
- Careless `SELECT *`.
- Misunderstanding one-to-many row multiplication.
- Not checking row counts.
- Not documenting join logic.

## Join Debugging Mindset

Start with the business question. Identify tables, keys, relationship type, expected row behavior, and whether missing matches are expected. Add one join at a time and check row counts.

## Joins for ETL/ELT and Data Quality

Joins enrich datasets and reveal broken relationships. Data engineers use them to prepare reports and validate customer, product, payment, campaign, and support ticket relationships.
