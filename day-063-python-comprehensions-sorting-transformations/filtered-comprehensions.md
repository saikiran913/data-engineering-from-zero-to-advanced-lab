# Filtered Comprehensions

The `if` at the end decides whether an input item is included:

```python
valid_amounts = [
    amount
    for amount in amounts
    if amount >= 0
]

clean_statuses = [
    status.strip().upper()
    for status in statuses
    if status is not None
]
```

The first expression builds the output item; the trailing `if` filters the source item. To remove blank strings too, use `if status is not None and status.strip()`. This differs from `if status`, which keeps strings containing only spaces.

| # | Input | Filtered expression | Output |
|---|---|---|---|
| 1 | `[-1, 2]` | `[x for x in values if x >= 0]` | `[2]` |
| 2 | `[None, ' ready ']` | `[s.strip().upper() for s in values if s is not None]` | `['READY']` |
| 3 | `['', 'A']` | `[s for s in values if s]` | `['A']` |
| 4 | `['  ', 'A']` | `[s for s in values if s.strip()]` | `['A']` |
| 5 | `[0, 1, 2]` | `[x for x in values if x > 0]` | `[1, 2]` |
| 6 | `['UK', 'IN']` | `[c for c in values if c == 'UK']` | `['UK']` |
| 7 | `[{'ok': True}, {'ok': False}]` | `[r for r in rows if r['ok']]` | first row |
| 8 | `[{'id': ''}, {'id': 'A'}]` | `[r['id'] for r in rows if r['id']]` | `['A']` |
| 9 | `['paid', 'failed']` | `[s.upper() for s in values if s == 'paid']` | `['PAID']` |
| 10 | `[3, 4]` | `[x * 10 for x in values if x % 2 == 0]` | `[40]` |

For PASS/REVIEW/FAIL decisions, keep a normal loop and record a reason for each source row. Filtering can silently remove evidence when a row deserves review.
