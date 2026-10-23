# Python Transformation Cheatsheet

| Pattern | Example | Result |
|---|---|---|
| List comprehension | `[s.upper() for s in statuses]` | New list |
| Filtered comprehension | `[a for a in amounts if a >= 0]` | New, possibly shorter list |
| Dictionary comprehension | `{r['id']: r['status'] for r in records}` | New mapping; duplicate keys overwrite |
| Set comprehension | `{r['source'] for r in records}` | Unique values; no promised order |
| New sorted list | `sorted(amounts)` | Original list unchanged |
| In-place sort | `amounts.sort()` | Original list changed; return is `None` |
| Reverse | `sorted(amounts, reverse=True)` | Descending list |
| Record key | `sorted(records, key=lambda r: r['amount'])` | Order by amount |

```text
source → normalize → filter → project → sort → verify
```

Use a normal loop when each record needs several conditions or a reason code. Validate input types and missing values before sorting; compare source and output counts after filtering.
