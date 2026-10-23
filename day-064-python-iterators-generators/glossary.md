# Glossary

| Term | Simple meaning | Example |
|---|---|---|
| Consumer | Code that requests and uses values | A `for` loop over records |
| Consumption | Advancing through iterator values | Calling `next()` |
| Eager collection | Collection already holding its items | A list |
| Eager evaluation | Producing results before later use | List comprehension |
| Exhausted iterator | Iterator with no remaining values | A finished generator |
| Generator | Iterator made by a generator function or expression | `generate_ids(3)` |
| Generator expression | Lazy expression in parentheses | `(x * 2 for x in values)` |
| Generator function | Function containing `yield` | `def ids(): yield 'A'` |
| Incremental processing | Handling values as they arrive | One record per loop step |
| Iterable | Object that can provide an iterator | List, tuple, string, dict, set |
| Iteration | Repeatedly requesting values | A `for` loop |
| Iterator | Object tracking position and yielding values | `iter(values)` result |
| Iterator exhaustion | State after all values were consumed | `next()` raises `StopIteration` |
| Lazy evaluation | Calculating a value when requested | Generator expression |
| Lazy pipeline | One-pass chain of on-demand stages | Normalize, filter, consume |
| Materialise | Collect remaining values into a collection | `list(generator)` |
| Memory-aware processing | Avoiding needless full intermediates | Yield records one at a time |
| Next | Function requesting one iterator value | `next(iterator)` |
| One-pass | Usually consumed only once | Generator iteration |
| Pipeline stage | Focused step in a flow | Normalization generator |
| Source | Origin of the values in a flow | Bounded record generator |
| State | Information kept between requests | Current iterator position |
| StopIteration | Signal that no next value exists | Raised after exhaustion |
| Yield | Pause a generator and provide one value | `yield record` |
