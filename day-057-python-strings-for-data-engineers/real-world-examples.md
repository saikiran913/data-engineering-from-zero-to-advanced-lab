# Real-World Examples

| # | Raw value | Rule | Output | Risk and safe note |
| --- | --- | --- | --- | --- |
| 1 | `" completed "` | Strip and upper controlled status | `COMPLETED` | Preserve raw for traceability |
| 2 | `"Completed"` | Canonical status case | `COMPLETED` | Apply only to statuses |
| 3 | `"uk"` | Upper country code | `UK` | Use approved country-code contract |
| 4 | `"00125"` | Preserve identifier text | `00125` | Do not convert to integer |
| 5 | `""` | Blank check | review | Different from `None` |
| 6 | `"   "` | Strip then blank check | review | Edge whitespace is not content |
| 7 | `None` | Missing check | review | Do not call methods first |
| 8 | `orders_01.csv` | Prefix check | valid | Prefix is controlled |
| 9 | `orders_01.csv` | Suffix check | valid | Consider case rule |
| 10 | `report.CSV` | Controlled extension case | `.csv` after normalisation | Keep source name too |
| 11 | `ORD-1|C-1|PASS` | Split pipe record | three parts | Count before indexing |
| 12 | `ORD-1|C-1` | Count fields | invalid | Do not assume status |
| 13 | `ORD-1|C-1|PASS|X` | Count fields | invalid | Extra field changes contract |
| 14 | `ORD-1||PASS` | Check each part | review | Customer ID is blank |
| 15 | `daily-orders` | Approved separator replace | `daily_orders` | Do not alter arbitrary text |
| 16 | `ERROR: retry` | Substring search | contains error | Clean case when needed |
| 17 | `orders_2026.csv` | Filename prefix | accepted | Exact prefix matters |
| 18 | ` archive.csv ` | Strip then extension check | accepted | Preserve raw name if needed |
| 19 | `done` | Lookup map | `COMPLETED` | Mapping must be approved |
| 20 | `complete` | Lookup map | `COMPLETED` | Test idempotency |
| 21 | `cancelled` | Unknown map result | review | Do not invent status |
| 22 | `North West` | Keep internal space | unchanged | Display text is not a code |
| 23 | `ORD-001` | Prefix search | contains `ORD-` | Do not remove hyphen |
| 24 | `A-B-C` | Limited replace | `A_B_C` | Only for known technical name |
| 25 | `a|b|c` | Join clean parts | `a|b|c` | Use agreed delimiter |
| 26 | `a| b |c` | Strip individual parts | `a|b|c` | Contract allows edge cleaning |
| 27 | `PASS` | Allowed set membership | pass | Validate after standardising |
| 28 | `pass` | Upper then allowed set | pass | Case rule is deterministic |
| 29 | `"  "` note | Optional blank note | blank optional | Do not call it missing automatically |
| 30 | `"Name, Inc."` | Minimal cleaning | unchanged | Simple split is unsuitable for complex data |
