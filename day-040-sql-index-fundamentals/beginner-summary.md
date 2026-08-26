# Beginner Summary

## What Learners Should Remember

An index is an additional access structure. It can help a database find rows more efficiently for some read patterns, but it is not free.

An index does not change the logical result of a query. The same query should return the same rows whether the database uses an index, scans the table, or chooses another access method.

Indexes cost storage. They can also make writes more expensive because inserts, updates, and deletes may require index maintenance. This is why more indexes do not automatically mean better performance.

Selectivity is one useful signal. A high-selectivity column has many distinct values compared with the total row count. `order_id` is usually high selectivity. A status column with only a few values is low selectivity. Low selectivity does not mean never index, but it needs stronger workload and platform evidence.

Frequent filters matter. Frequent joins matter. Sort patterns can matter. Composite index order matters because a multi-column index is designed around a particular column sequence. One composite index does not help every possible query pattern equally.

Workload matters. Table size matters. Read/write balance matters. A read-heavy lookup table may be more index-friendly than a write-heavy ingestion table. Small tables may not need extra access structures. Analytical warehouses may use partitioning, clustering, columnar storage, or pruning instead of traditional row-store index patterns.

Index behaviour varies by SQL platform. Real tuning should use platform-specific evidence, query plans, table size, data distribution, and workload testing.

Day 040 does not create indexes. All executable SQL remains read-only. Index DDL appears only as conceptual comments.

## Mental Model

Start with the workload, understand the table, profile candidate columns, balance read benefit against write cost, and only then consider an index.

## Final Warnings

> An index can improve some read patterns, but it adds storage and write-maintenance cost. More indexes do not automatically mean better performance.

> Index usefulness depends on the SQL platform, table size, data distribution, query pattern, and optimizer behaviour. Day 040 teaches general reasoning, not universal tuning rules.

> A column that appears in a `WHERE` or `JOIN` clause is not automatically a good index candidate. Selectivity, frequency, workload, and table design matter.

> Day 040 explains index concepts and selection thinking. It does not create, drop, rebuild, or deploy indexes.

## What Comes Next

Day 041 will introduce broader query-performance thinking: scans, filters, joins, aggregations, and reading query plans conceptually without turning the repository into vendor-specific tuning or production benchmarking.

