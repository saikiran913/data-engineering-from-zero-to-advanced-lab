# Troubleshooting Guide

```text
1. inspect source type
2. inspect whether value is iterable/iterator
3. test one next()
4. check whether generator was already consumed
5. recreate generator
6. test each stage separately
7. materialise only a small sample if debugging
8. switch to list if repeated/random access is required
```

| Symptom | Likely cause | Response |
|---|---|---|
| `TypeError: 'generator' object is not subscriptable` | Generator has no index access | Use a list if indexing is required |
| `TypeError` from `len(generator)` | Length is not known without consumption | Count during a pass or materialise intentionally |
| `StopIteration` | No next item remains | Handle it or use a `for` loop |
| Generator produces no values | Filter rejects all, or source is empty | Test source and each stage separately |
| Generator already exhausted | Earlier loop, `next()`, or `list()` consumed it | Recreate the generator |
| Second loop is empty | Same one-pass iterator reused | Call generator function again |
| Debugging changed results | Inspection consumed values | Recreate before full run |
| Exception appears during iteration | Lazy body ran only on request | Test the item and stage that raised it |
| Sorting consumes values | `sorted()` materialises all items | Use a list when full order is required |
| Need multiple passes | One-pass flow is unsuitable | Deliberately materialise or recreate source |
| Need random access | Iterator cannot index | Use a list |
| Infinite-loop risk | Source lacks a bound | Add a limit and a clear stopping rule |
