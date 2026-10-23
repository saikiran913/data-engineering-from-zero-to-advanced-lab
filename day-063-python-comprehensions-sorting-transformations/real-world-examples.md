# Real-World Transformation Examples

Each row shows a small Data Engineering situation. Values are synthetic.

| # | Input | Transformation | Output | Pattern | Risk or consideration |
|---|---|---|---|---|---|
| 1 | `[' ready ']` | Trim and uppercase | `['READY']` | List comprehension | Guard `None` |
| 2 | `[None, 'paid']` | Keep strings | `['paid']` | Filtered comprehension | Count exclusions |
| 3 | `['uk', 'in']` | Uppercase | `['UK', 'IN']` | List comprehension | Country aliases may need mapping |
| 4 | `[-1, 5]` | Keep nonnegative | `[5]` | Filtered comprehension | Retain rejected-row evidence |
| 5 | `[{id: A}]` | Select IDs | `['A']` | Projection | Check required key |
| 6 | Two ID/status rows | Build ID lookup | ID-to-status dict | Dict comprehension | Duplicate IDs overwrite |
| 7 | `['east', 'east']` | Unique sources | `{'east'}` | Set comprehension | Order not guaranteed |
| 8 | `[9, 2]` | Ascending | `[2, 9]` | `sorted()` | Original preserved |
| 9 | ISO date rows | Sort date text | Earliest first | Record key | Dates must be ISO format |
| 10 | Numeric amount rows | Sort amount | Lowest first | Named key | Missing amount policy |
| 11 | Cost rows | Sort descending | Highest first | `reverse=True` | Numeric types required |
| 12 | Status and ID rows | Sort tuple | Status, then ID | Multi-field key | Tuple field order matters |
| 13 | Raw list | `sorted(raw)` | New ordered list | New list | Keep raw evidence |
| 14 | Working list | `.sort()` | Mutated working list | In-place sort | Method returns `None` |
| 15 | `[' ', 'A']` | Drop blank | `['A']` | Filter | Use `.strip()` |
| 16 | `['done']` | Lookup canonical status | `['COMPLETED']` | Mapping | Unknown codes need rule |
| 17 | PASS and REVIEW rows | Select PASS | PASS rows | Filter | Keep REVIEW separately |
| 18 | Status groups | Count groups | Count mapping | Dict comprehension | Group meaning matters |
| 19 | Raw dictionaries | Normalize copies | Clean dictionaries | Helper + list | Preserve raw records |
| 20 | Complex validation | Classify in loop | Status and reason | Loop | Make every branch explicit |
| 21 | `None` amount | Missing-last key | Valid first | Key function | Avoid mixed comparisons |
| 22 | `[1, 2]` | Sum values | `3` | Built-in `sum` | No comprehension needed |
| 23 | Duplicate record IDs | Investigate before lookup | Collision report | Loop | Do not overwrite silently |
| 24 | Repeated source labels | Normalize then dedupe | Canonical set | Multi-stage | Order of steps matters |
| 25 | Raw dates | Parse then sort | Correct chronology | Helper + key | Invalid dates need review |
| 26 | Campaign metric rows | Project channel/cost | Narrow records | List comprehension | Keep needed report fields |
| 27 | Website event types | Uppercase labels | Canonical types | List comprehension | Empty types need handling |
| 28 | Monthly file labels | Sort labels | Ordered months | `sorted()` | Lexical month names misorder |
| 29 | Order statuses | Count lengths | Length lookup | Dict comprehension | Repeated keys collapse |
| 30 | Region amounts | Keep above threshold | Selected amounts | Filtered comprehension | Threshold should be documented |
| 31 | IDs with spaces | Trim IDs | Clean IDs | List comprehension | Leading spaces might matter in rare IDs |
| 32 | Empty source list | Build unique sources | Empty set | Set comprehension | Downstream handles empty output |
