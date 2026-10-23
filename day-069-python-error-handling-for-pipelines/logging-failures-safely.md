# Logging Failures Safely

Day 067's levels still describe **operational impact**, not a record's business status. Use DEBUG for bounded investigation detail, INFO for stage completion, WARNING for an actionable handled irregularity, and ERROR for a stage that cannot complete. A record's FAIL outcome does not automatically require an ERROR log.

```python
logger.warning("run_id=%s stage=SOURCE transient_failure attempt=%s", run_id, attempt)
logger.info("run_id=%s stage=COMPLETE run_status=%s processed=%s", run_id, status, count)
```

Configure logging once in `main`, obtain a named logger with `logging.getLogger(__name__)`, and use stable run/stage fields. Do not log raw rows, credentials, or unbounded exception data. `logger.exception(...)` belongs **inside an active `except` block** for a meaningful unexpected failure; it includes a traceback. A handled row validation result usually needs only an aggregate count. Avoid duplicating the same exception log at every layer or producing a long line for each failed retry; report bounded attempts and final outcome. Logging an ERROR does not make the operation recover.
