# Python Iterators and Generators Cheatsheet

| Need | Pattern | Remember |
|---|---|---|
| Iterator | `iterator = iter(values)` | Position advances as consumed |
| Next value | `next(iterator)` | May raise `StopIteration` |
| Generator function | `def generate_values(): yield 1; yield 2` | Body pauses at each `yield` |
| Generator expression | `(value * 2 for value in values)` | Lazy, one pass |
| Consume | `for value in generator: ...` | Loop exhausts values it reaches |
| Materialise | `values = list(generator)` | Collects all remaining values |

```text
source → generator stage → generator stage → consumer
```

Use a bounded source for learning. Recreate a generator function call to run it again. Use a list when sorting, indexing, or repeated passes are required.
