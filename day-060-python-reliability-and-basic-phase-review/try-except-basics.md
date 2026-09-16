# Try and Except Basics

```python
try:
    value = int(raw_value)
except ValueError:
    value = None
else:
    print("Conversion succeeded")
```

Keep `try` narrow. `finally` always runs and is often used for cleanup; context managers are usually clearer for file resources. Do not silently pass on expected data failures.
