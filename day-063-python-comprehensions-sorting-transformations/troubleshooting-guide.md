# Troubleshooting Guide

```text
1. inspect input collection
2. inspect item type
3. test one-item transformation
4. test filter separately
5. inspect sort key
6. check missing values
7. compare raw vs transformed
8. use a normal loop if unclear
```

| Symptom | Likely cause | Next check |
|---|---|---|
| Comprehension syntax error | Expression, `for`, or `if` misplaced | Start with a simple loop equivalent |
| `NameError` | Loop variable name differs | Compare expression and `for` clause |
| `.sort()` result is `None` | In-place method assigned to variable | Use `sorted()` or inspect mutated list |
| Mixed types fail sort | Values cannot be compared | Normalize types before sorting |
| Missing record key | `record['field']` absent | Validate schema or use a documented fallback |
| `None` breaks numeric sort | Missing-value policy absent | Use an explicit key helper |
| Numeric strings sort oddly | Character order used | Convert to numbers first |
| Raw order changed | `.sort()` used on input | Use `sorted()` or copy input |
| Set dedupe changes order | Sets have no business ordering | Sort distinct values for display |
| Dictionary key collision | Duplicate IDs overwrite | Check IDs before building lookup |
| Unexpected duplicates | Normalization happened too late | Normalize before deduplication |
| One-liner is hard to debug | Too much logic packed together | Split into named stages or a loop |
