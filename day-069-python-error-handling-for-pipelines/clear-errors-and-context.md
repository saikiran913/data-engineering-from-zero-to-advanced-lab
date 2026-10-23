# Clear Errors and Context

An error should tell the caller which rule failed without dumping a raw record or sensitive value. `raise ValueError("amount must be non-negative")` is more useful than `raise ValueError("bad")`. Add safe stage or field context where the caller needs it.

```python
def parse_amount(raw: object) -> float:
    try:
        amount = float(raw)
    except (TypeError, ValueError) as exc:
        raise ValueError("amount must be numeric") from exc
    if amount < 0:
        raise ValueError("amount must be non-negative")
    return amount
```

`raise ... from exc` preserves the conversion cause for diagnosis. A narrow `try` makes it clear which operation failed. A row processor may catch the resulting `ValueError` and return `{"status": "REVIEW", "reason": "amount must be numeric"}` rather than crashing the whole run. It may retain a synthetic record ID in that in-memory result, but a log should not indiscriminately include the raw value.

If the current layer cannot decide, bare `raise` **inside an `except` block** passes the same exception upward with its traceback. A tiny custom `TransientOperationError(Exception)` can distinguish a simulated temporary stage fault from malformed data; only a handler that knows how to retry safely should catch it. Do not classify arbitrary programming errors as transient.
