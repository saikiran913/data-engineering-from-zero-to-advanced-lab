# Logging Levels

The threshold is the minimum severity the logger emits. With `level=logging.INFO`, DEBUG is hidden while INFO, WARNING, ERROR, and CRITICAL remain visible.

| Level | Use when | Avoid |
|---|---|---|
| `DEBUG` | Investigating safe stage details | Dumping entire records |
| `INFO` | A normal run starts or completes | Logging every row |
| `WARNING` | A handled condition needs review | Treating every rejected row as an incident |
| `ERROR` | A stage cannot complete | Assuming a log handles the failure |
| `CRITICAL` | The whole application cannot operate | Calling ordinary validation failures critical |

```python
logger.debug("run_id=%s stage=NORMALISE input_count=%s", run_id, 7)
logger.info("run_id=%s stage=COMPLETE accepted_count=%s", run_id, 6)
logger.warning("run_id=%s stage=VALIDATE review_count=%s", run_id, 1)
```

Business validation status is another axis. A record with `validation_status=FAIL` may be an expected result of a functioning validator, so report it in a summary rather than automatically emitting ERROR. A crash during validation is an operational failure and merits ERROR. Choose the level by what the operator must do, not by the spelling of a business label.
