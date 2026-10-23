# Beginner Summary

Earlier Python lessons showed how to write reliable functions, organise pipeline components, and document their contracts. Those choices help code behave predictably, but they do not automatically tell an operator what happened during a particular run. Logging adds that visibility. Think of the workflow as **validate data → collect result → log meaningful summary → troubleshoot failures**. The validation result remains the actual result; the log is a short diagnostic account.

Python includes the `logging` module in its standard library. A logger emits an event with a severity. A handler sends the event somewhere; in this lesson it goes only to the console. A formatter makes the event readable. `logging.getLogger(__name__)` gives a useful module name, and `logging.basicConfig()` sets up a small application from its entry point. This configuration normally writes to `stderr`. `print` normally writes to `stdout` and is still fine for deliberate user-facing output, but it has no built-in severity or filtering.

There are five familiar levels. DEBUG is for targeted investigation. INFO marks normal milestones such as START and COMPLETE. WARNING calls attention to a handled condition. ERROR indicates that an operation failed. CRITICAL indicates that the whole application cannot continue. With an INFO threshold, DEBUG events are not displayed. Choose severity by operational impact, not by the spelling of a business label. A validator can successfully classify a row as `FAIL`; that does not mean the program itself raised an ERROR.

A helpful log says what happened and where. Use safe, stable context fields such as `run_id=RUN-001`, `source=orders_batch`, `stage=VALIDATE`, and `record_count=6`. Key=value text is easy to scan, though it is not automatically a JSON structured-log format. Use `logger.info("record_count=%s", count)` to let logging format arguments when the event is emitted. Keep names consistent across stages so one run can be followed from start to finish.

A small pipeline might describe START, READ, NORMALISE, VALIDATE, SUMMARISE, and COMPLETE. In today's scripts, READ means accepting synthetic data already in memory; no files are opened. At the validation stage, report counts for PASS, REVIEW, and FAIL. Check that those counts add up to the input count. Log a review summary when someone should inspect the result, but do not log each bad row. This keeps output useful when a future batch contains thousands or millions of records.

Expected invalid data and unexpected exceptions need different treatment. If an amount is not valid, the validator can classify it and continue, then log an aggregate count. If code unexpectedly raises and a specific exception is caught, `logger.exception()` inside the `except` block adds a traceback at ERROR level. It helps diagnosis but does not repair the failure. Decide whether to recover or stop. Logging the same exception in several layers can produce misleading duplicates.

Duplicate log lines can also come from configuration. A child logger usually passes events to its parent's handler. Adding handlers to both can print the same event twice even when the data was processed once. Configure console logging once in the application entry point; helper modules should obtain named loggers and leave configuration alone. When output seems missing, check the level and `stderr` before assuming the pipeline did not run.

> A log line should help diagnose an event, not expose confidential information. Never put passwords, tokens, or unnecessary personal or row-level data into logs.

> Choose log levels based on operational meaning. Expected validation failures are not automatically system errors, and an `ERROR` log does not fix or handle an exception.

> Avoid logging every record in a large pipeline. Prefer concise stage summaries, counts, bounded examples, and targeted debug information.

> Use one clear logging configuration in the application entry point. Reconfiguring loggers in helper modules or adding duplicate handlers can create confusing duplicate messages.

Logs are useful evidence, not a substitute for validation outputs, tests, metrics, or alerts. Before moving on, be able to pick a level, identify a safe context field, explain why a business FAIL differs from an operational ERROR, and reconcile stage counts. Day 068 — Python Testing Fundamentals: Assertions, unittest, and Pipeline Validation Checks will use explicit checks to establish correctness rather than relying on log text.
