# Reusable File Processing Patterns

Reliable small pipelines repeat a visible sequence:

1. Build paths with `pathlib.Path`.
2. Read with `with` and UTF-8 encoding.
3. Parse with the format library (`csv` or `json`).
4. Validate structure and values.
5. Keep every source row with a status and reason.
6. Write generated data to `output/`.
7. Reopen and verify the generated result.

```python
def validate_amount(value):
    try:
        return float(value) >= 0, ""
    except ValueError:
        return False, "amount is not numeric"
```

Small functions such as this make a validation rule testable and reusable. Keep file reading, row validation, and file writing as separate steps so an error has one clear location.
