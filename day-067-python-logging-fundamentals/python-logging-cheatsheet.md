# Python Logging Cheatsheet

| Need | Pattern |
|---|---|
| Module logger | `logger = logging.getLogger(__name__)` |
| One entry-point setup | `logging.basicConfig(level=logging.INFO, format="%(levelname)s %(name)s %(message)s")` |
| Normal milestone | `logger.info("run_id=%s stage=START", run_id)` |
| Investigative count | `logger.debug("stage=NORMALISE input_count=%s", count)` |
| Actionable but handled condition | `logger.warning("stage=VALIDATE review_count=%s", count)` |
| Unexpected failure inside `except` | `logger.exception("run_id=%s stage=SUMMARISE failed", run_id)` |
| Change threshold | `logging.getLogger().setLevel(logging.DEBUG)` after setup |

`DEBUG < INFO < WARNING < ERROR < CRITICAL`; INFO hides DEBUG. `%(asctime)s` is time, `%(levelname)s` severity, `%(name)s` logger name, and `%(message)s` the event. Basic console logs normally use `stderr`; `print` normally uses `stdout`.

Use stable key=value context: `run_id`, `source`, `stage`, `record_count`, `validation_status`. These are text messages, not JSON logs. PASS/REVIEW/FAIL describes validation; log severity describes operational impact. Log stage totals, not raw records or secrets. Configure once in `main`; do not add repeated handlers in helpers. Logs support, but do not replace, validation, metrics, tests, or alerting.
