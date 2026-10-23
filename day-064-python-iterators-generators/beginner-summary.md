# Beginner Summary

An iterable can provide an iterator. Calling `iter(values)` on a list gives an iterator; `next(iterator)` requests one value and advances its position. A `for` loop requests values automatically. Once an iterator is exhausted, it does not restart. A new iterator can be obtained from the original list, while a generator is recreated by calling its generator function again.

A generator function uses `yield` to provide values one at a time. Its local state is preserved between yields. A generator expression looks like a comprehension with parentheses, such as `(value * 2 for value in values)`. It is lazy: the calculation happens when a consumer requests a value. A list comprehension uses brackets and eagerly builds a full list.

Generators can reduce intermediate materialisation when records flow through focused stages: normalize one record, validate it, and hand it to a consumer before requesting the next. They are not indexable lists. Sorting a generator generally consumes and materialises its items into a list. A source already held in a list still uses that list's memory. Use a list when the data is small, needs repeated passes, or must be accessed by index.

```text
Source → request next item → transform → validate → consume → repeat
```

> Generators are usually consumed once. After an iterator is exhausted, calling `next()` again does not restart it.

> Lazy processing reduces the need to hold every transformed record in memory, but it does not automatically make code faster or better. Use it when the data-flow semantics justify it.

> Generator pipelines can be harder to debug because values are produced only when requested. Keep each stage small and inspect intermediate outputs when troubleshooting.

> Do not convert a generator to `list(...)` unless you intentionally want to materialise all remaining values in memory.

Day 065 will cover Python logging for data pipelines: levels, structured messages, and debugging workflows.
