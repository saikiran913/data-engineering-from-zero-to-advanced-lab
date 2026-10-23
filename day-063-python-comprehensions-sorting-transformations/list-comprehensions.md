# List Comprehensions

Both forms below create a new list:

```python
clean_statuses = []
for status in statuses:
    clean_statuses.append(status.strip().upper())
```

```python
clean_statuses = [
    status.strip().upper()
    for status in statuses
]
```

Read the comprehension as: *for each `status` in the iterable `statuses`, put the expression `status.strip().upper()` in the output list*. The expression comes first, then the loop variable and iterable. The source list is not changed.

## Ten Small Examples

| # | Input | Expression | Output |
|---|---|---|---|
| 1 | `[' ready ']` | `[s.strip().upper() for s in statuses]` | `['READY']` |
| 2 | `['uk', 'in']` | `[c.upper() for c in countries]` | `['UK', 'IN']` |
| 3 | `[1, 2]` | `[n * 2 for n in counts]` | `[2, 4]` |
| 4 | `[10, 20]` | `[n / 100 for n in cents]` | `[0.1, 0.2]` |
| 5 | `['a', 'bb']` | `[len(s) for s in labels]` | `[1, 2]` |
| 6 | `['ORD-1']` | `[s.lower() for s in ids]` | `['ord-1']` |
| 7 | `[2, 3]` | `[n + 1 for n in numbers]` | `[3, 4]` |
| 8 | `['x', 'y']` | `[f'src:{s}' for s in sources]` | `['src:x', 'src:y']` |
| 9 | `[(1, 2)]` | `[a + b for a, b in pairs]` | `[3]` |
| 10 | `[{'id': 'A'}]` | `[r['id'] for r in records]` | `['A']` |

Use a named helper when the expression needs substantial parsing or multiple business rules. Clarity is the reason to use a comprehension, not brevity alone.
