# Retry Fundamentals

A retry is another call to the **same operation** after a failure. It is not a second chance for bad business data. Define `max_attempts` as a positive integer including the first call: `max_attempts=3` means at most three calls and two retries.

```python
class TransientOperationError(Exception):
    pass

def retry_operation(operation, max_attempts: int):
    if type(max_attempts) is not int or max_attempts < 1:
        raise ValueError("max_attempts must be a positive integer")
    for attempt in range(1, max_attempts + 1):
        try:
            return operation(), attempt
        except TransientOperationError:
            if attempt == max_attempts:
                raise
    raise AssertionError("bounded loop ended unexpectedly")
```

A deterministic simulator can fail its first call and return `"ready"` on its second. The loop stops immediately on success. A `ValueError` is not caught here, so it propagates after one call. If the known transient error continues through the final call, bare `raise` reports exhaustion. Avoid a `while True` loop or retrying a whole job when only one small, side-effect-safe stage needs another attempt.

> Retry only failures that are reasonably transient and safe to repeat. Invalid data, missing required configuration, and code defects generally need correction—not repeated attempts.

> Every retry policy must have a clear maximum attempt count and a stopping condition. Never create unbounded retry loops.
