# Python Error Handling Cheatsheet

**Specific exception and clear message:**

```python
try:
    amount = float("invalid")
except ValueError:
    amount_result = {"status": "REVIEW", "reason": "amount must be numeric"}
```

**Raise or preserve a failure:**

```python
def require_source(name: str) -> str:
    if not name.strip():
        raise ValueError("source_name is required")
    return name

def boundary(name: str) -> str:
    try:
        return require_source(name)
    except ValueError:
        raise  # Preserve the same exception for the caller.
```

**Bounded retry:**

```python
class TransientOperationError(Exception):
    pass

def retry(operation, max_attempts: int):
    if type(max_attempts) is not int or max_attempts < 1:
        raise ValueError("max_attempts must be positive")
    for attempt in range(1, max_attempts + 1):
        try:
            return operation(), attempt
        except TransientOperationError:
            if attempt == max_attempts:
                raise
    raise AssertionError("retry loop ended unexpectedly")
```

`max_attempts=3` includes the first call and permits at most two retries. After failed attempt 1 or 2 only, a conceptual capped delay can be `min(max_delay, base_delay * 2 ** (attempt - 1))`; no delay is computed after success or final failure. Never retry malformed data or missing required settings. Check idempotency before repeating side-effecting work. Report processed, PASS/REVIEW/FAIL, attempts/retries, and an honest run status.
