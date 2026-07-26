# Common Mistakes

| Mistake | Why It Matters | Safer Approach |
| --- | --- | --- |
| Forgetting `ORDER BY` | Sequence is unclear | Always define order |
| Forgetting `PARTITION BY` | Groups mix together | Partition by entity |
| Wrong partition | Totals restart incorrectly | Match business question |
| Wrong ordering column | Running order is wrong | Use date plus tie-breaker |
| Relying on default frame | Meaning can be unclear | Use explicit `ROWS` |
| Confusing `ROWS` with `RANGE` | Equal dates may behave differently | Use `ROWS` for Day 026 |
| Three rows treated as three days | Missing dates break assumption | Validate calendar coverage |
| Ignoring duplicate dates | Rows may double count | Add tie-breaker and review |
| Wrong data grain | Metrics mislead | Confirm one row meaning |
| Calculating before deduplication | Duplicates inflate totals | Deduplicate if required |
| Replacing nulls with zero blindly | Unknown becomes real zero | Review null policy |
| Treating zero as missing | Zero may be valid | Keep zero unless rule says otherwise |
| Filtering rows without thought | Totals change | Document filter rule |
| Not reconciling final totals | Errors go unnoticed | Compare with grouped totals |
| Assuming moving average explains cause | It only summarises rows | Investigate separately |
| Comparing incomplete partitions | Groups may look unfair | Check row counts |
| Too wide a frame | Business meaning weakens | Choose justified frame |
| Moving average on too few rows | Early results are partial | Add frame count |
| Negative values reduce totals | Decrease may be valid | Review adjustments |
| One frame for every question | Wrong metric design | Select frame per requirement |
