# Validation-Friendly String Cleaning

Use a deliberate pipeline:

```text
raw
→ missing check
→ strip
→ blank check
→ normalise case
→ validate allowed value
```

```python
raw_status = " completed "
if raw_status is None:
    result = "REVIEW"
else:
    clean_status = raw_status.strip().upper()
    if clean_status == "":
        result = "REVIEW"
    elif clean_status in {"READY", "COMPLETED"}:
        result = "PASS"
    else:
        result = "FAIL"
```

`None`, blank text, canonical text, and unsupported text can have different meanings. IDs often need edge-whitespace handling but should keep meaningful internal characters and leading zeros. Controlled codes may use case normalisation. Free text usually needs minimal cleaning.

Idempotent cleaning gives the same result when repeated: `" completed " → "COMPLETED" → "COMPLETED"`.
