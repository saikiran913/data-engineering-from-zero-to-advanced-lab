# Beginner Summary

Data is often stored in multiple related tables instead of one huge table. A business may have one table for customers, another table for orders, another table for products, and another table for order items. This keeps data organized and avoids repeating the same information many times. For example, a customer's country and email do not need to be repeated inside every order item row. Instead, the order can store a customer ID, and that ID can connect back to the customer table.

A table relationship means rows in one table connect to rows in another table using common key values. A primary key uniquely identifies a row in a table. For example, `customers.customer_id` identifies one customer, `orders.order_id` identifies one order, and `products.product_id` identifies one product. A foreign key is a column that points to a primary key in another table. For example, `orders.customer_id` points to `customers.customer_id`, and `order_items.product_id` points to `products.product_id`.

The table that stores the main entity is often called the parent table. The table that stores related detail is often called the child table. `customers` is a parent table and `orders` is a child table because one customer can have many orders. This is called a one-to-many relationship. Another one-to-many example is one order having many order item rows. Day 013 also introduces many-to-many awareness: one order can contain many products, and one product can appear in many orders. The `order_items` table connects orders and products, so it acts like a bridge table.

A SQL `JOIN` combines rows from two tables based on a related column. The `ON` condition tells SQL how the tables are connected. For example, `ON c.customer_id = o.customer_id` connects customers and orders. Table aliases such as `customers AS c` and `orders AS o` make join queries shorter and easier to read. They also help avoid confusion when both tables have columns with the same name.

`INNER JOIN` returns only matching rows from both tables. If a customer has orders, the customer appears with those orders. If a customer has no orders, that customer does not appear in the result. This is useful when you want only matched business data.

`LEFT JOIN` returns all rows from the left table and matching rows from the right table. If there is no match, right-side columns show as `NULL`. This is useful for data quality checks. For example, starting from `customers` and left joining `orders` can show customers with no orders. Starting from `orders` and left joining `customers` can show orders with missing customer records.

The difference between `INNER JOIN` and `LEFT JOIN` matters a lot. `INNER JOIN` can hide unmatched records because it keeps only matches. `LEFT JOIN` can expose missing relationships because it keeps the left table rows even when the right table does not match. Data engineers often use both: `INNER JOIN` for clean matched reporting datasets and `LEFT JOIN` for validation and investigation.

Joins also support ETL and ELT. A pipeline may enrich orders with customer country, enrich order items with product category, or enrich campaign performance rows with campaign names. These enriched datasets are easier for dashboards, analysts, and business teams to use.

Before Day 014, remember the basics: understand the relationship before joining, identify the primary and foreign keys, write the `ON` condition carefully, use aliases, and check row counts. Joins can increase row counts when one parent row connects to many child rows, so row count changes are not automatically wrong, but they should be understood.

A good beginner habit is to start every join by naming the business question. Then identify the tables, the keys, and the expected match behavior before writing SQL. This keeps join logic clear and easier to explain.
