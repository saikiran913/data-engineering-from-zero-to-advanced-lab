# Beginner Summary

Day 014 is a practice-focused lesson about SQL joins. In Day 013, you learned what `INNER JOIN` and `LEFT JOIN` do. `INNER JOIN` keeps only rows that match in both tables. `LEFT JOIN` keeps all rows from the left table and adds matching rows from the right table. If the right table has no match, the right-side columns become `NULL`.

Join practice matters because joins are one of the easiest SQL topics to get technically correct but business-wrong. A query can run successfully and still answer the wrong question if the join key is wrong, the wrong join type is chosen, or the wrong table is preserved. For example, joining customers to orders by country may produce rows, but it does not correctly connect each order to its actual customer. The correct customer-order key is usually `customer_id`.

The `ON` condition is the heart of a join. It tells SQL how two tables are related. A missing `ON` condition can fail in some SQL tools or create incorrect combinations in others. A wrong `ON` condition can inflate row counts, duplicate-looking results, and totals such as revenue or payment amount.

Row counts are a major debugging clue. Row counts can increase after a join when the relationship is one-to-many. If one customer has three orders, joining customers to orders can return three rows for that customer. This is expected row multiplication, not automatically duplicate data. Row counts can also decrease after an `INNER JOIN`, because unmatched records are removed. This is why `INNER JOIN` can hide data quality issues.

`LEFT JOIN` is especially useful for missing relationship checks. Starting from customers and left joining orders can find customers with no orders. Starting from orders and left joining customers can find orders with unknown customers. Starting from payments and left joining orders can find payments that do not match valid orders. The left table matters because it decides which records are preserved.

`NULL` after a `LEFT JOIN` needs business context. A customer with no orders may be normal. A product never ordered may be normal. A campaign with no performance may be normal if it has not started. But an order item with an unknown product, a payment with an unknown order, or campaign performance with an unknown campaign is usually more serious.

Common join mistakes include forgetting the `ON` condition, joining on the wrong column, using `INNER JOIN` when `LEFT JOIN` is needed, choosing the wrong left table, selecting ambiguous columns, using `SELECT *`, misunderstanding row multiplication, filtering right-table columns after a `LEFT JOIN`, checking `NULL` incorrectly, and failing to document join logic.

A good join debugging mindset starts with the business question. Ask which tables are needed, which keys connect them, which table should be preserved, whether unmatched rows should appear, and how the row count is expected to change. Then write the join with aliases, select a small number of columns, check row counts, review `NULL`s, and confirm the output makes business sense.

Data engineers use joins for ETL/ELT enrichment and data quality investigations. Joins add customer details to orders, product categories to order items, campaign names to performance rows, and payment details to orders. They also reveal broken relationships before those issues reach dashboards and reports. Before Day 015, remember that clean data starts with trustworthy relationships.

Also remember that joins should be explained, not only written. A clear join should say which tables are involved, which key connects them, why that key is correct, what row count behavior is expected, and what missing matches mean. This habit makes SQL easier to review, debug, and trust. Practice builds confidence.
