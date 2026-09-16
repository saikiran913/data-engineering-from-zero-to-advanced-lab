# Replace and Search

Use `replace()` only when a contract justifies it.

```python
raw_name = "daily-orders"
clean_name = raw_name.replace("-", "_")
```

Search a controlled value with membership, `startswith()`, or `endswith()`.

```python
file_name = "orders_2026_01.csv"
print(file_name.startswith("orders_"))
print(file_name.endswith(".csv"))
print("2026" in file_name)
```

`find()` returns the first position or `-1` if absent. Prefer `in` when existence is all you need. Typical uses include checking a filename prefix, extension, status token, or controlled separator. A broad replacement can damage business meaning, so test a small known value first.
