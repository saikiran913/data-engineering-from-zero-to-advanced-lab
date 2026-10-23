# Context-Rich Messages

An event such as `validation complete` is hard to investigate if several runs execute. Add small, safe context fields consistently.

| Field | Example | Why it helps |
|---|---|---|
| `run_id` | `RUN-001` | Connects stages of one run |
| `source` | `orders_batch` | Identifies a non-sensitive source category |
| `stage` | `VALIDATE` | Locates work in the pipeline |
| `record_count` | `7` | Supports count reconciliation |
| `validation_status` | `REVIEW` | Names the business outcome |

```python
logger.info(
    "run_id=%s source=%s stage=%s record_count=%s validation_status=%s",
    "RUN-001", "orders_batch", "VALIDATE", 7, "REVIEW",
)
```

The `%s` arguments are passed to logging for deferred formatting; a filtered-out DEBUG event need not build its final string. Keep keys stable and values short. These are ordinary key=value messages, not automatically parseable JSON structured logs. Never put a whole order, email address, token, or personal identifier in context. A fixed synthetic run ID is enough for this lesson.
