# Day 036 Glossary

| Term | Simple Meaning | Beginner Example |
|---|---|---|
| Actual value | Value observed in data | clean amount |
| Affected entity | Thing needing review | order ID |
| Affected-record count | Unique affected entities | count of distinct orders |
| Audit context | Timestamps and lineage fields | `extracted_at` |
| Data-quality output | Review-friendly validation result | exception queue |
| Duplicate exception | Same issue listed more than once | repeated exception key |
| Entity key | Identifier for affected item | `ORD5001` |
| Evidence | Details supporting review | source file and amount |
| Exception | Item needing investigation | null customer ID |
| Exception category | High-level issue family | `REQUIRED_FIELD` |
| Exception grain | What one exception row means | one row per issue |
| Exception level | Record, metric, or stage | `RECORD` |
| Exception queue | Structured review list | combined queue |
| Exception report | Output of exceptions | SQL result set |
| Exception-row count | Number of issue rows | two issues for one order |
| Expected exception | Review item explained by rule | documented exclusion |
| Expected value | What rule expected | non-null customer |
| High review | Important review label | `HIGH_REVIEW` |
| Info severity | Observation label | `INFO` |
| Investigation context | Details for follow-up | file and timestamp |
| Issue category | Controlled issue group | `DUPLICATE_KEY` |
| Issue type | Specific issue | `DUPLICATE_ORDER_ID` |
| Metric-level exception | Metric issue | total mismatch |
| One row per issue | Queue design | same order can appear twice |
| Record-level exception | Row issue | null amount |
| Review message | Human-readable action | review lineage |
| Review queue | Exceptions for investigation | combined output |
| Review-required issue | Issue needing review | missing clean order |
| Rule catalog | Rule reference table | `exception_rule_catalog` |
| Severity | Priority label | `REVIEW` |
| Source lineage | Source origin context | source file |
| Stage-level exception | Stage issue | missing report group |
| Unexpected exception | Issue not explained by rule | clean-only order |
