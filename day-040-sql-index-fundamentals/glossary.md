# Day 040 Glossary

| Term | Simple meaning | Beginner example |
|---|---|---|
| Access path | How rows are found conceptually | scan or lookup |
| Analytical warehouse | System designed for analytics | large fact-table reporting |
| B-tree concept | Common ordered index idea | useful for many lookups conceptually |
| Candidate index | Possible index worth reviewing | `customer_id, order_date` |
| Candidate rating | Educational review label | strong candidate |
| Cardinality | Number of distinct values | 36 order IDs |
| Composite index | Index over multiple columns | customer plus order date |
| Filter column | Column used in `WHERE` | `order_status` |
| Full scan | Examine a large part of a table | scan many order rows |
| High selectivity | Many distinct values | `order_id` |
| Index | Additional access structure | conceptual lookup helper |
| Index lookup | Use index-like structure to narrow rows | find one order ID |
| Index maintenance | Work needed to keep indexes updated | extra write cost |
| Index overhead | Storage and maintenance cost | too many indexes |
| Index selectivity | Narrowness of indexed values | distinct values divided by rows |
| Join column | Column used to connect tables | `customer_id` |
| Leading column | First column in composite index | `customer_id` in customer-date |
| Lookup | Find specific rows | exact order search |
| Low selectivity | Few distinct values | active/inactive status |
| Operational database | System often serving transactions | order-entry database |
| Optimizer | Database component choosing access path | decides scan or lookup |
| Over-indexing | Too many indexes | indexes on every column |
| Overlapping index | Similar indexes covering same pattern | customer-date and customer-date-status |
| Platform-specific indexing | Index behaviour varies by database | warehouse versus row-store |
| Query pattern | Shape of query use | frequent date filter |
| Read-heavy workload | Many reads compared with writes | lookup dashboard |
| Sort column | Column used in `ORDER BY` | `order_date` |
| Storage overhead | Extra space used by indexes | index files or structures |
| Workload | Set of queries and writes | reporting and ingestion mix |
| Write-heavy workload | Many inserts, updates, or deletes | ingestion table |

