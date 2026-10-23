# Generator Exhaustion and Debugging

```python
generator = (value * 2 for value in [1, 2, 3])
print(list(generator))  # [2, 4, 6]
print(list(generator))  # []
```

The second result is empty because the first `list()` consumed the generator. `next()` and a `for` loop also consume values. Printing the generator object itself displays an object description, not its records.

Debugging can change state: `list(stage)` materialises and exhausts it, so the downstream stage later sees nothing. Test a small source, inspect one stage at a time, and recreate the source generator before rerunning the whole pipeline. An exception inside a generator may appear only when the consumer requests the problematic item, not when the generator object is created.

When results need several passes, a deliberate list may be clearer. Document where materialisation happens.
