# Real-World Examples

| # | Business query | Unnecessary work | Safer habit | Correctness risk | Validation | Expected effect conceptually |
|---|---|---|---|---|---|---|
| 1 | Exact order lookup with `SELECT *` | Wide projection | Select only order fields needed | Removed column may be needed | Column contract | Clearer output |
| 2 | Monthly order report | Carries all dates first | Filter to month safely | Wrong date field | Min/max date | Fewer rows |
| 3 | Customer history | Carries unused order columns | Narrow order CTE | Missing output column | Column list | Narrower intermediate result |
| 4 | Customer join not needed | Join adds no column or filter | Remove join after review | Hidden eligibility rule | Count comparison | Less join work |
| 5 | Customer segment filter | Join is required | Keep join and narrow columns | Removing join changes rule | Segment counts | Correct filtered output |
| 6 | Order-item revenue | Raw item join | Define item grain | Row multiplication | Row count by order | Correct detail |
| 7 | Item pre-aggregation | Too many item rows in join | Aggregate items to order grain | Line detail lost | Order count and totals | Smaller join input |
| 8 | Customer-level pre-aggregation | Aggregates too early | Keep order grain | Order detail lost | Distinct order count | Avoid wrong rewrite |
| 9 | Country report | Sort not required | Remove sort if consumer does not need it | Report ordering may be expected | Consumer contract | Less sorting |
| 10 | Status dashboard | No date filter | Filter period | Wrong population | Dates and totals | Relevant rows |
| 11 | Accidental duplicate join | Duplicate keys ignored | Check key uniqueness | Inflated rows | HAVING duplicate check | Safer join |
| 12 | DISTINCT masking duplicates | Duplicate cause hidden | Fix join grain | Meaningful rows removed | Key count | Cleaner logic |
| 13 | Unnecessary final sort | Machine feed sorted | Remove `ORDER BY` | Consumer may rely on order | Contract check | Avoid sort |
| 14 | Required top-N sort | Sort is part of requirement | Keep `ORDER BY` with `LIMIT` | Removing sort changes top-N | Result review | Correct ranking |
| 15 | Repeated CASE | Same label logic repeated | Derive label once | Logic mismatch | Grouped label count | Clearer logic |
| 16 | Repeated aggregation | Same summary repeated | Reuse CTE | Platform may not reuse work | Totals | Clearer query |
| 17 | Wide CTE chain | All columns carried | Narrow each step | Later column missing | Column contract | Easier review |
| 18 | Outer join filter caution | `WHERE` on right table | Preserve unmatched rows if needed | Outer join becomes inner-like | Unmatched count | Correct optional logic |
| 19 | Date-range filter | Uses load date accidentally | Use business date | Wrong period | Min/max business date | Correct population |
| 20 | Small lookup already fine | No major issue | Leave it simple | Over-complex rewrite | Result check | No change needed |
| 21 | Large scan but query needs most rows | Scan overreported as bad | Review purpose first | Premature rewrite | Query-plan evidence | Better judgement |
| 22 | Rewrite changes total | Incorrect filter | Restore logic | Wrong metric | Control total | Catch regression |
| 23 | Counts match but key lost | Different rows retained | Compare keys | Missing business records | Key comparison | Catch hidden issue |
| 24 | No-change-needed scenario | Query is already simple | Do nothing | Unneeded complexity | Basic validation | Maintainable SQL |

