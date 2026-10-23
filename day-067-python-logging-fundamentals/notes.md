# Revision Notes

## Why Log?

Logging records significant events during execution. It answers: which run, which stage, what happened, how many records, and was action needed? A `print` call can display a value, but a logger adds severity, a name, consistent formatting, and filtering. Neither makes the data correct; Day 060's exception handling and Day 066's documented contracts still matter.

```text
pipeline action → meaningful event → choose severity → attach safe context → log to console → diagnose or investigate
```

The `logging` module creates a `LogRecord` when a logger emits an event. The logger has a name and effective level. A handler chooses the destination (here, console), and a formatter chooses the text. A level threshold discards less severe messages. A child logger may pass an event to its ancestor's handler; this is propagation.

An **event** is the occurrence worth noting; **severity** says how urgently to treat it; **context** identifies the run and stage; the **message** combines these into readable text. A numeric metric or counter is kept separately so it can be calculated and checked. Merely writing `record_count=6` in a log does not create a reliable metrics system.

## Minimum Setup

```python
import logging

logger = logging.getLogger(__name__)

def main() -> None:
    logging.basicConfig(level=logging.INFO, format="%(asctime)s %(levelname)s %(name)s %(message)s")
    logger.info("run_id=%s stage=%s", "RUN-001", "START")

if __name__ == "__main__":
    main()
```

`%(asctime)s` is the log time; `%(levelname)s` is severity; `%(name)s` is logger name; `%(message)s` is formatted event text. By default the console handler uses `stderr`. `basicConfig()` may do nothing when handlers already exist, so configure once in the entry point and avoid adding a second handler to module loggers.

## Severity and Message Design

`DEBUG` describes targeted investigation details; `INFO` marks normal milestones; `WARNING` means attention may be needed while continuing; `ERROR` means an operation failed; `CRITICAL` means the whole service or pipeline cannot proceed. INFO typically filters DEBUG. Log levels describe operational severity, not business labels such as `PASS`, `REVIEW`, or `FAIL`.

Prefer `logger.info("run_id=%s stage=%s record_count=%s", run_id, stage, count)` over building the string eagerly. Log safe, stable fields: `run_id`, `source`, `stage`, `record_count`, `validation_status`. This is readable key=value text, **not** a JSON structured-log system. Never place raw rows or secrets in those fields.

## Pipeline Events

A small pipeline may log `START`, conceptual `READ`, `NORMALISE`, `VALIDATE`, `SUMMARISE`, and `COMPLETE`. These scripts keep rows in memory, so READ describes receiving an in-memory batch, not file I/O. Record input, accepted, review, and rejected counts; reconcile them. A source and run ID let an operator relate the messages. A stage summary is more useful than one log per record.

Expected bad values belong in validation results. An unexpected exception is different: catch a specific exception at the point that can handle or explain it. `logger.exception(...)` inside `except` logs at ERROR with a traceback. If the failure is re-raised, avoid another identical error log at the next layer. Logging an ERROR does not resolve it.

## Boundary

Logs support diagnosis, but validated output, numeric metrics, tests, and alerting have separate jobs. A missing log does not prove a successful run; a success log does not prove data quality. Keep console output concise, check counts, and use the lab to compare INFO and DEBUG.

> A log line should help diagnose an event, not expose confidential information. Never put passwords, tokens, or unnecessary personal or row-level data into logs.

> Choose log levels based on operational meaning. Expected validation failures are not automatically system errors, and an `ERROR` log does not fix or handle an exception.

> Avoid logging every record in a large pipeline. Prefer concise stage summaries, counts, bounded examples, and targeted debug information.

> Use one clear logging configuration in the application entry point. Reconfiguring loggers in helper modules or adding duplicate handlers can create confusing duplicate messages.
