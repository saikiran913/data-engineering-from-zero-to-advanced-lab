# Glossary

| Term | Simple meaning | Beginner example |
|---|---|---|
| Query Plan | Strategy chosen to produce a SQL result | Read orders, filter, then sort |
| Execution Plan | Plan used or expected during execution | A displayed plan for a report query |
| `EXPLAIN` | Command style for showing planning information | Commented `EXPLAIN SELECT ...` |
| `EXPLAIN ANALYZE` | Analyze-style plan that may execute on some platforms | Use caution before running |
| Optimizer | Database component that chooses a plan | Chooses scan or lookup |
| Plan Tree | Plan steps shown as a hierarchy | Scan below filter below result |
| Operator | One plan action | Filter, join, sort |
| Table Scan | Read a table or substantial portion | Read all orders for a monthly report |
| Index Lookup | Narrow row access using an access path | Find one order by ID |
| Access Path | How rows are found conceptually | Scan or lookup |
| Filter Operator | Applies `WHERE` logic | Keep only Paid orders |
| Join Operator | Combines related rows | Orders joined to customers |
| Sort Operator | Orders rows | Sort orders by amount |
| Aggregate Operator | Groups and summarises rows | Count orders by country |
| Estimated Rows | Expected row count | Plan expects 100 rows |
| Actual Rows | Rows observed during execution on some platforms | Actual result had 120 rows |
| Cost | Platform-specific estimate of work | Cost 50 in one system |
| Elapsed Time | Real time taken to run | Query ran in 2 seconds |
| Statistics | Metadata about data distribution | Status has few distinct values |
| Selectivity | How narrow a filter is | One order ID is selective |
| Cardinality | Number of distinct values | Many unique order IDs |
| Row Multiplication | Joined output grows from repeated matches | One customer has many orders |
| Intermediate Result | Rows produced before final output | Joined rows before grouping |
| Platform-Specific | Different across databases | Plan text differs by system |
| Plan Comparison | Reviewing two plans side by side | Early filter versus late filter |
| Workload Evidence | Real usage context | Frequent daily pipeline query |

