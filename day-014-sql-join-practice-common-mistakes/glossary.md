# Day 014 Glossary

| Term | Simple Meaning | Beginner Example |
| --- | --- | --- |
| JOIN Practice | Repeated work to understand joins | Joining customers to orders |
| Join Key | Column used to connect tables | `customer_id` |
| Correct Join Key | Key matching the real relationship | `orders.customer_id` to `customers.customer_id` |
| Wrong Join Key | Key that gives business-wrong results | Joining by country |
| ON Condition | SQL rule for the join | `ON c.customer_id = o.customer_id` |
| INNER JOIN | Keeps matched rows only | Orders with valid customers |
| LEFT JOIN | Keeps all left table rows | All customers and any orders |
| Left Table | Table after `FROM` | `customers` in `FROM customers AS c` |
| Right Table | Table after `JOIN` | `orders` in `LEFT JOIN orders AS o` |
| Preserved Rows | Rows kept by a left join | All customer rows |
| Matching Rows | Rows that find a related row | Order with known customer |
| Unmatched Rows | Rows without a related row | Customer with no orders |
| NULL After LEFT JOIN | Missing right table value | Order ID is `NULL` |
| Row Count Increase | More rows after a join | One customer has many orders |
| Row Count Decrease | Fewer rows after a join | `INNER JOIN` removes unmatched rows |
| Row Multiplication | One row becomes many result rows | One order has many items |
| One-to-Many Join | One parent row to many child rows | Customer to orders |
| Missing Relationship | Expected match not found | Payment without order |
| Broken Relationship | Invalid table connection | Order item with unknown product |
| Orphan Record | Child row without parent row | Order item without order |
| Ambiguous Column | Column name appears in more than one table | `customer_id` |
| Table Alias | Short table name | `customers AS c` |
| Column Prefix | Alias before column | `c.customer_id` |
| SELECT * | Select all columns | Risky in joins |
| Join Debugging | Checking join logic | Compare row counts |
| Join Validation | Confirming join result is correct | Check missing matches |
| Relationship Check | Checking parent-child match | Orders to customers |
| Enrichment | Adding details from another table | Add customer name to orders |
| Reference Data | Descriptive lookup data | Product names |
| Business Logic | Business meaning behind SQL | Which rows should count |
| Data Quality Investigation | Searching for data issues | Unknown campaign IDs |
| Expected Result | Result that matches the question | All customers preserved |
| Unexpected Result | Output needing review | Inflated revenue |
