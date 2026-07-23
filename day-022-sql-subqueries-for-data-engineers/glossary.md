# Glossary

| Term | Simple Meaning | Beginner Example |
| --- | --- | --- |
| Aggregate | A calculated summary value | `AVG(order_amount)` |
| Alias | A temporary name for a table or column | `customers AS c` |
| Anti-match | Finding records with no match | Customers with no orders |
| Business key | Column used to identify a business record | `customer_id` |
| Correlated subquery | Inner query that refers to the outer row | `o.customer_id = c.customer_id` |
| Derived table | A table-like result created by a subquery | Subquery in `FROM` |
| Existence check | Checking whether a matching row exists | `EXISTS` |
| `EXISTS` | Returns true when a matching row exists | Customers with orders |
| `IN` | Checks whether a value is in a returned list | Customer IDs in orders |
| Inner query | Query inside another query | `SELECT AVG(...)` inside `WHERE` |
| Missing record | Record found in one dataset but not another | Source row missing in target |
| `NOT EXISTS` | Returns true when no matching row exists | Orders without payments |
| `NOT IN` | Checks whether a value is not in a returned list | Products not in sales |
| Null | Missing or unknown value | Blank `customer_id` |
| One-column result | Result with one selected column | `SELECT customer_id` |
| One-value result | Result with one row and one column | Average order amount |
| Outer query | Query that uses the inner query result | Orders filtered by average |
| Read-only query | Query that does not change data | `SELECT` |
| Reconciliation | Comparing source and target data | Missing target records |
| Row comparison | Comparing a row value with another result | Amount above average |
| Scalar subquery | Subquery returning one value | `SELECT MAX(order_amount)` |
| Source table | Dataset where records originate | Source rows |
| Subquery | Query inside another query | Query inside `WHERE` |
| Table subquery | Subquery used like a table in `FROM` | Grouped customer totals |
| Target table | Dataset where records should load | Target rows |
| Validation query | Query used to check data quality | Payments without orders |
