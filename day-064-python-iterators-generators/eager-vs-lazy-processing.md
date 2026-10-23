# Eager vs Lazy Processing

| Pattern | Produces | Memory behaviour concept |
|---|---|---|
| List comprehension | Full list | Materialises all output items |
| Generator expression | Iterator | Produces output on demand |
| Generator function | Iterator | Produces output on demand |

```python
values = [1, 2, 3]
eager = [value * 2 for value in values]
lazy = (value * 2 for value in values)
```

The lazy expression avoids a separate full output list until a consumer asks for values. It does not use zero memory: the source list already occupies memory, and the generator keeps its state. The largest benefit appears when the source and consumer can both work incrementally. Day 064 uses small, synthetic in-memory inputs so the behaviour is easy to inspect.

Lazy code is not automatically faster. Choose it when one-pass processing fits the workflow. A small list can be simpler when results need indexing, sorting, or repeated use.
