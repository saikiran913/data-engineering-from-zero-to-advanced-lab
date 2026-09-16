# Set Basics

A set stores unique values. Use braces for a non-empty set and `set()` for an empty set.

```python
statuses = {"COMPLETED", "PENDING", "COMPLETED"}
empty_statuses = set()
print("COMPLETED" in statuses)
statuses.add("FAILED")
statuses.discard("PENDING")
```

`{}` creates an empty dictionary, not an empty set. Sets have no positional indexing and their display order is not a business order. `.discard()` does nothing when the value is absent; `.remove()` raises `KeyError` in that case, so learn it conceptually before using it in fragile workflows.
