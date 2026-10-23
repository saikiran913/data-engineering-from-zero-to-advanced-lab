# `iter()` and `next()`

```python
values = ["a", "b", "c"]
iterator = iter(values)

print(next(iterator))  # a
print(next(iterator))  # b
print(next(iterator))  # c
```

One more `next(iterator)` raises `StopIteration`, which means there are no more values. A `for` loop handles that signal for you. Handle it explicitly when manually requesting values:

```python
try:
    value = next(iterator)
except StopIteration:
    print("No values remain")
```

Each call advances state. `next()` does not peek without consuming. To repeat the sequence, create `fresh = iter(values)` from the original list; the exhausted iterator itself does not reset. If the source is a one-pass generator, recreate the generator using its function.
