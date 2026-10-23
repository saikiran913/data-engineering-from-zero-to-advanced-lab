# Logging Exceptions

Validation rejection and an unexpected exception are different. A validator may intentionally classify an invalid amount as `FAIL` and continue. Summarise that outcome without a traceback. If a stage unexpectedly raises, catch a **specific** exception where you can respond or add context.

```python
try:
    amount = float("invalid")
except ValueError:
    logger.warning("run_id=%s stage=VALIDATE invalid_amount_count=%s", "RUN-001", 1)
```

This example reports a known data condition without logging the bad value. For an actual stage failure:

```python
try:
    raise RuntimeError("synthetic stage failure")
except RuntimeError:
    logger.exception("run_id=%s stage=SUMMARISE failed", "RUN-001")
```

`logger.exception` belongs inside an `except` block. It logs at ERROR level and includes the active exception's traceback. `logger.error` records an ERROR message but does not add the current traceback automatically. Log once at the layer responsible for diagnosis; if you re-raise, avoid logging the same failure at every layer. A log statement does not recover the pipeline or decide whether to stop.

Behind the scenes, `logger.exception(...)` requests exception information (`exc_info=True`) for the active exception. This is useful for a stage crash, but noisy for a known invalid row handled by normal validation.
