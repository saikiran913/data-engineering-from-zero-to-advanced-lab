# Sample Tables for Day 040

Day 040 uses workload-style CSV files. The goal is to reason about index candidates from query patterns, not to create indexes.

| File | Purpose | Grain | Key | Workload role |
|---|---|---|---|---|
| `orders_workload.csv` | Order rows for profiling | One row per order | `order_id` | Demonstrates high, medium, and low selectivity |
| `customers_workload.csv` | Customer rows for profiling | One row per customer | `customer_id` | Demonstrates lookup and join columns |
| `query_workload_catalog.csv` | Query pattern catalog | One row per workload entry | `query_id` | Shows filters, joins, sorts, frequency, and importance |
| `column_profile_catalog.csv` | Column profile metadata | One row per profiled column | table and column | Shows cardinality and selectivity bands |
| `index_candidate_cases.csv` | Candidate review cases | One row per candidate | `case_id` | Classifies strong, possible, weak, and platform-review cases |
| `workload_tradeoff_cases.csv` | Read/write trade-off cases | One row per scenario | `case_id` | Shows write-heavy, read-heavy, small-table, and warehouse trade-offs |

## Profiling Questions

| Question | Useful file |
|---|---|
| How many rows are in the table? | `orders_workload.csv`, `customers_workload.csv` |
| How many distinct values does a column have? | `column_profile_catalog.csv` |
| Is the column frequently filtered? | `query_workload_catalog.csv` |
| Is the column often joined? | `query_workload_catalog.csv` |
| Is the workload read-heavy or write-heavy? | `query_workload_catalog.csv`, `workload_tradeoff_cases.csv` |
| Is this a strong, possible, weak, or platform-review candidate? | `index_candidate_cases.csv` |

## Important Learning Issues

- `order_id` is high-selectivity
- `order_status` is low-selectivity
- `customer_id` and `order_date` are medium or context-dependent
- query frequency varies
- workload patterns include read-heavy, write-heavy, and mixed
- warehouse scenarios require platform review

