# Transformation Patterns

| Pattern | Question | Beginner form |
|---|---|---|
| Filter | Which records stay? | `[r for r in records if r['status'] == 'PASS']` |
| Map/transform | How does a value change? | `[s.strip().upper() for s in statuses]` |
| Project | Which fields stay? | `[{ 'id': r['id'] } for r in records]` |
| Normalize | Which labels become canonical? | `normalize_status(raw)` |
| Lookup mapping | What canonical value matches a code? | `country_map.get(raw_code)` |
| Deduplicate | Which repeated values collapse? | `set(source_names)` |
| Sort | What output order is required? | `sorted(records, key=sort_key)` |

```text
raw records → normalize → filter → project → sort → output
```

Order changes meaning. Normalize before deduplicating when `" UK "` and `"uk"` should be treated alike. Validate before filtering if excluded rows need an error record. Project after validation so required raw fields remain available. Sort only after the type and missing-value rules are clear. Compare input and output counts and inspect the output shape before passing it to the next stage.
