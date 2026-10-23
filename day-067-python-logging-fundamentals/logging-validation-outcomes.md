# Logging Validation Outcomes

`PASS`, `REVIEW`, and `FAIL` are **business outcomes**. `INFO`, `WARNING`, and `ERROR` describe **operational severity**. They are not interchangeable scales.

Suppose seven in-memory rows yield five PASS, one REVIEW, and one FAIL. The validator succeeded in classifying them all. A summary could be:

In memory, a function can return one label for each dictionary: `"PASS"` for a positive valid amount, `"REVIEW"` for a zero amount, and `"FAIL"` for an invalid value. Keep those labels in a result list or count dictionary; logging is only the later summary.

```python
logger.info(
    "run_id=%s stage=VALIDATE input_count=%s pass_count=%s review_count=%s fail_count=%s",
    "RUN-001", 7, 5, 1, 1,
)
```

Add a WARNING when the review count requires an operator's attention. Do not emit ERROR once per FAIL row merely because its status says FAIL. If the validator itself crashes, that is an operational ERROR. Keep the underlying results in data structures; a log message is not a replacement for them. Check counts and statuses in tests and downstream reporting.
