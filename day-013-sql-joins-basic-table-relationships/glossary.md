# Day 013 Glossary

| Term | Simple Meaning | Beginner Example |
| --- | --- | --- |
| JOIN | Combines related tables | Customers with orders |
| INNER JOIN | Keeps only matching rows | Customers who placed orders |
| LEFT JOIN | Keeps all left table rows | All customers, even without orders |
| Table Relationship | Connection between tables | Customers connect to orders |
| Primary Key | Unique row identifier | `customers.customer_id` |
| Foreign Key | Column pointing to another table key | `orders.customer_id` |
| Parent Table | Main entity table | `customers` |
| Child Table | Related detail table | `orders` |
| One-to-One Relationship | One row connects to one row | Employee and profile |
| One-to-Many Relationship | One row connects to many rows | One customer, many orders |
| Many-to-Many Relationship | Many rows connect to many rows | Orders and products |
| Bridge Table | Table connecting many-to-many data | `order_items` |
| Lookup Table | Table used to add descriptions | `products` adds product names |
| Reference Data | Descriptive data used for matching | Product category |
| Join Key | Column used to connect tables | `customer_id` |
| ON Condition | Rule explaining table connection | `ON c.customer_id = o.customer_id` |
| Table Alias | Short table name in a query | `customers AS c` |
| Column Prefix | Alias before column name | `c.customer_id` |
| Matching Row | Row that finds a related row | Order with valid customer |
| Unmatched Row | Row without a related row | Customer with no orders |
| NULL After LEFT JOIN | Missing right-side match | Order columns are `NULL` |
| Broken Relationship | Expected match is missing | Order points to unknown customer |
| Orphan Record | Child row without parent row | Order item without order |
| Data Enrichment | Adding details through joins | Add product name to order item |
| Data Validation | Checking data correctness | Missing product check |
| Row Multiplication | More rows after one-to-many join | One customer becomes many order rows |
| Relationship Map | Diagram of table connections | Customers -> orders |
| Business Entity | Thing represented in data | Customer or campaign |
| Transaction Table | Table storing events or activity | `orders` |
| Dimension-like Table | Table storing descriptive details | `products` |
| Fact-like Table | Table storing measurable activity | `campaign_performance` |
