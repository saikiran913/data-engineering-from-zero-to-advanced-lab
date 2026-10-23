# Pipeline Transformation Examples

These examples use small in-memory collections. Keep a source copy when raw order or exact source values matter.

| # | Task | Readable pattern | Check |
|---|---|---|---|
| 1 | Normalize statuses | `[s.strip().upper() for s in statuses]` | Source list unchanged |
| 2 | Remove `None` statuses | `[s for s in statuses if s is not None]` | Count removed values |
| 3 | Uppercase country codes | `[c.upper() for c in countries]` | No blank codes |
| 4 | Keep non-negative amounts | `[a for a in amounts if a >= 0]` | Investigate rejected values |
| 5 | Project order IDs | `[r['order_id'] for r in records]` | Required key exists |
| 6 | Build ID-to-status lookup | `{r['id']: r['status'] for r in records}` | No duplicate IDs |
| 7 | Deduplicate source names | `{r['source'] for r in records}` | Set order is not meaningful |
| 8 | Sort amounts | `sorted(amounts)` | Values are numeric |
| 9 | Sort ISO date strings | `sorted(records, key=lambda r: r['date'])` | Dates use `YYYY-MM-DD` |
| 10 | Sort by amount | `sorted(records, key=lambda r: r['amount'])` | Missing values handled |
| 11 | Descending cost | `sorted(rows, key=lambda r: r['cost'], reverse=True)` | Costs are numeric |
| 12 | Multi-field sort | `sorted(rows, key=lambda r: (r['status'], r['id']))` | Tuple order is intended |
| 13 | Preserve raw list | `ordered = sorted(raw)` | Original order remains |
| 14 | Mutate working list | `working.sort()` | No later step needs prior order |
| 15 | Filter blank strings | `[s for s in values if s and s.strip()]` | Whitespace-only removed |
| 16 | Canonical status lookup | `[status_map.get(s, 'REVIEW') for s in values]` | Unknown values visible |
| 17 | Select valid records | `[r for r in rows if r['result'] == 'PASS']` | REVIEW rows retained elsewhere |
| 18 | Validation summary mapping | `{name: len(rows) for name, rows in groups.items()}` | Group definitions match |
| 19 | Clean dictionary list | `[normalize_record(r) for r in rows]` | Helper returns a copy |
| 20 | Complex validation | Use a loop with `classify_record(r)` | Store reason per row |
| 21 | Missing sort value | `sorted(rows, key=amount_key)` | Helper states missing-last rule |
| 22 | No comprehension needed | `total = sum(amounts)` | Built-in is clearer |

## A Complete Sequence

```python
clean = [normalize_record(row) for row in raw_rows]
retained = [row for row in clean if row['order_id']]
selected = [{'order_id': row['order_id'], 'status': row['status']} for row in retained]
ordered = sorted(selected, key=lambda row: (row['status'], row['order_id']))
```

Check that discarded rows were intentionally excluded and that selected fields still support the next stage. When data quality decisions need explanation, use a loop that records a reason instead of dropping a row quietly.
