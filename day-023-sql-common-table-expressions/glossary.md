# Glossary

| Term | Simple Meaning | Beginner Example |
| --- | --- | --- |
| Alias | Temporary name for a table or column | `raw_orders AS o` |
| Audit column | Column that helps trace a record | `source_file` |
| Business rule | Documented decision rule | Keep positive completed orders |
| Clean layer | Business-ready data after checks | Clean current orders |
| Common Table Expression | Named query result used in one statement | `WITH valid_orders AS (...)` |
| CTE | Short name for Common Table Expression | `valid_orders` |
| Data grain | What one row represents | One row per order |
| Dependency | One step relying on an earlier step | `customer_totals` uses `valid_orders` |
| Exception queue | Review output for suspicious records | Orders with missing customer IDs |
| Final query | Last query that returns the output | `SELECT * FROM valid_orders` |
| Intermediate result | Result prepared before the final output | Filtered valid orders |
| Named query step | A CTE with a purpose-based name | `missing_target_records` |
| Non-recursive CTE | Normal CTE that does not call itself | Day 023 CTEs |
| Output grain | What one output row means | One row per customer |
| Permanent table | Stored table that remains available | Physical orders table |
| Query step | One logical part of SQL | Filter, aggregate, validate |
| Reconciliation | Comparing source and target data | Count and total checks |
| Reusable logic | Prepared result referenced in one statement | `valid_orders` used by totals |
| Row multiplication | Extra rows caused by joins | One order joins to many payments |
| Source table | Dataset where records originate | `source_records` |
| Target table | Dataset where records should appear | `target_records` |
| Temporary result | Result available only during one statement | A CTE result |
| Validation query | Query used to check data quality | Orders without customers |
| View | Saved reusable database object | Reporting view |
| `WITH` | Keyword that starts CTEs | `WITH active_customers AS (...)` |
