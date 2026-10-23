# Print vs Logging

`print` is useful for a deliberate result shown to a person. Logging describes execution events for diagnosis. The difference is not that one is always good and the other is always bad.

| Question | `print` | `logging` |
|---|---|---|
| Default stream | `stdout` | Usually `stderr` with basic console setup |
| Severity | None | DEBUG through CRITICAL |
| Filtering | Manual | Level threshold |
| Origin | Must add yourself | Logger name in formatter |
| Typical use | User-facing result | Start, summary, warning, failure |

```python
print("Accepted records: 6")  # Deliberate output
logger.info("run_id=%s stage=VALIDATE accepted_count=%s", run_id, 6)
```

The two streams can appear in surprising order when a terminal or test runner buffers `stdout`; that does not mean events happened out of order. Avoid replacing all `print` calls mechanically. Decide whether a line is a result, a diagnostic event, or neither. A large pipeline should not print or log every row.
