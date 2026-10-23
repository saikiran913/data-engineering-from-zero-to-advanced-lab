# Iterable vs Iterator

An **iterable** is an object Python can loop over. Familiar iterables include lists, tuples, strings, dictionaries, and sets. Calling `iter(values)` asks the iterable for an **iterator**. The iterator keeps a position and returns one item per `next()` call.

```python
values = ["READY", "REVIEW"]
iterator = iter(values)
print(next(iterator))  # READY
print(next(iterator))  # REVIEW
```

A new `iter(values)` call starts a new pass over a list. Calling `iter()` on an already advanced iterator normally returns that same iterator, with its current position. A `for` loop manages these calls internally; you rarely need to call `next()` in ordinary pipeline code.

## Ten Small Checks

| # | Input or action | What to notice |
|---|---|---|
| 1 | `iter([1, 2])` | A list supplies a fresh iterator. |
| 2 | `iter((1, 2))` | A tuple is iterable. |
| 3 | `iter("AB")` | A string yields characters. |
| 4 | `iter({"a": 1})` | A dictionary iterates over keys by default. |
| 5 | `iter({"a", "b"})` | A set is iterable; do not depend on its order. |
| 6 | `next(iter([9]))` | One request returns `9`. |
| 7 | `for value in [1, 2]` | The loop requests items automatically. |
| 8 | `first = iter(values)` | The iterator has its own position. |
| 9 | `second = iter(values)` | A list can supply another fresh iterator. |
| 10 | `iter(first)` | An iterator does not restart merely because `iter()` was called. |

This lesson uses built-in iteration and generators. Implementing custom iterator classes is unnecessary here.
