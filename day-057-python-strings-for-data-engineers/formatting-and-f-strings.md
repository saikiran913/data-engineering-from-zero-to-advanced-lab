# Formatting and F-Strings

F-strings make clear human-readable messages.

```python
source_name = "orders"
row_count = 120
completeness = 98.456
print(f"Source: {source_name}, row_count={row_count}")
print(f"Completeness: {completeness:.2f}%")
```

Formatting `98.456` as `98.46` for display does not change the underlying numeric value. F-strings are useful for summaries, diagnostics, and readable messages. Do not use ad-hoc formatted text as a substitute for a structured record.
