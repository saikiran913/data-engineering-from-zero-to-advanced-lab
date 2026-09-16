# Dictionary Mutation

Dictionaries are mutable. Add or update a field with assignment.

```python
order["country"] = "UK"
order["status"] = "COMPLETED"
```

`.update()` can apply several named changes. `pop()` removes and returns a value, but deletion should be secondary in beginner data processing because it changes the source shape.

```python
order.update({"status": "COMPLETED", "reviewed": True})
```

Use `.copy()` when a simple independent top-level copy is needed. It is shallow: nested lists and dictionaries remain shared. Passing a dictionary to a function can also allow that function to mutate the original, so document mutation clearly.

```python
working_order = order.copy()
working_order["validation_status"] = "PASS"
```

Treat mutation as a deliberate state change, not an accidental side effect.
