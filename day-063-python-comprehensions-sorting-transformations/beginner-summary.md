# Beginner Summary

A comprehension creates a new collection from an existing iterable. A list comprehension can clean a short list of statuses, a dictionary comprehension can build an ID-to-status lookup, and a set comprehension can collect distinct source labels. A filtered comprehension adds a condition at the end to decide which input items appear in the output. The result is compact, but a normal loop is better when each item needs several business decisions or a reason for rejection.

Sorting is a separate step. `sorted()` returns a new list and preserves the original list order. `.sort()` changes an existing list and returns `None`. Both can use `reverse=True`. Records represented by dictionaries need a `key=` function to choose an ordering value. A simple lambda is common; a named function is clearer when the key needs missing-value handling. For two fields, return a tuple key. Define what happens when a value is missing or `None` before sorting.

Transformation order matters. Normalize labels before deduplicating if different spellings mean the same thing. Validate before filtering if excluded records must be reviewed. Project fields only after earlier rules no longer need them. Deduplication changes counts and may discard meaningful repeated source records; document the intended key or value being deduplicated. Preserve raw inputs when tracing a delivery matters.

```text
Select → transform → order → verify
```

> Comprehensions are useful when the transformation is simple and readable. If the logic contains several conditions or business rules, a normal loop is usually clearer.

> `sorted()` returns a new list, while `.sort()` changes the existing list in place. Choose deliberately when raw input order must be preserved.

> Sorting records requires a clear contract for missing or `None` values. Do not rely on mixed incomparable types.

> Compact code is not automatically better code. Data Engineering transformations should prioritise correctness, clarity, and reviewability over clever one-liners.

Day 064 previews Python iterators and generators for memory-efficient processing and lazy data flows.
