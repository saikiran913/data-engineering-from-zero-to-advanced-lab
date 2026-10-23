# Day 069 — Python Error Handling for Pipelines: Clear Failures, Retries, and Recoverable Errors

## Learning Goal

Classify a failure before deciding what to do. By the end you can isolate invalid records, stop on invalid global settings, retry a known transient stage a bounded number of times, and report the actual run outcome. Day 060 introduced exceptions; Day 062 made stage responsibilities explicit; Day 067 added safe diagnostic logging; and Day 068 validated configuration before work begins.

## Four Different Outcomes

| Situation | Meaning | Typical decision |
|---|---|---|
| Validation failure | A record breaks a business rule | REVIEW or FAIL that record; continue if policy permits |
| Recoverable error | Work can proceed under a documented policy | Keep an explicit reason and partial outcome |
| Retryable error | A temporary operation failure may clear, and repetition is safe | Retry only that operation within a fixed limit |
| Fatal stage failure | A required stage cannot complete | Stop and report FAILED |

Recoverable does not mean retryable. A malformed amount can be reviewed without being retried. A simulated transient source fault may be retried if the operation is safe to repeat. A missing required source name should fail before record processing.

## Safety Rules

> Retry only failures that are reasonably transient and safe to repeat. Invalid data, missing required configuration, and code defects generally need correction—not repeated attempts.

> Every retry policy must have a clear maximum attempt count and a stopping condition. Never create unbounded retry loops.

> A retry can repeat side effects. Before retrying writes or external operations, verify that the operation is idempotent or protected against duplicate effects.

> Catch exceptions at the level where you can make a meaningful decision. Do not silently swallow failures or log an error and then claim the pipeline succeeded.

`max_attempts=3` means up to **three total calls**, including the first one, and at most two retries. The examples use fixed synthetic records and counters, never real connections, files, writes, random faults, or `sleep()`. They use only Python's standard library. Backoff is calculated for learning; nothing waits.

## Learning Map

| Resource | Focus |
|---|---|
| [Revision notes](notes.md) | Classify, decide, report |
| [Error taxonomy](pipeline-error-taxonomy.md) | Data, transient, permanent, config, code |
| [Clear errors](clear-errors-and-context.md) | Messages, types, retained cause |
| [Fail fast vs continue](fail-fast-vs-continue.md) | Stage policy and run status |
| [Recoverable records](recoverable-record-errors.md) | Explicit row outcomes |
| [Retry fundamentals](retry-fundamentals.md) | Total attempt count and stops |
| [Bounded retries and backoff](bounded-retries-and-backoff.md) | Delay calculations, no waiting |
| [Retry safety](retry-safety-and-idempotency.md) | Repeated side-effect risk |
| [Error ownership](error-propagation-and-ownership.md) | Handling at the right boundary |
| [Recovery patterns](pipeline-recovery-patterns.md) | Three practical policies |
| [Safe failure logging](logging-failures-safely.md) | Diagnostic context |
| [Cheatsheet](python-error-handling-cheatsheet.md) | Correct small patterns |
| [Common mistakes](common-mistakes.md) | Avoidable errors |
| [Real-world examples](real-world-examples.md) | Generic situations |
| [Beginner summary](beginner-summary.md) | Recap |
| [Glossary](glossary.md) | Terms |
| [Practice questions](practice-questions.md) | Exercises and complete answers |
| [Practice lab](practice-lab.md) | Guided script work |
| [Troubleshooting](troubleshooting-guide.md) | Diagnosis flow |
| [Scripts](scripts/) | Six standalone in-memory demonstrations |

Read the concept guides, run the scripts in order, then complete the lab and questions. From this folder:

```bash
python scripts/01_clear_errors_and_exceptions.py
python scripts/02_fail_fast_vs_continue.py
python scripts/03_recoverable_record_errors.py
python scripts/04_bounded_retry_simulation.py
python scripts/05_retry_safety_and_backoff.py
python scripts/06_data_engineering_recovery_workflow.py
```

Python 3.10+ is used for the type annotations in the examples. On Windows, `py` may replace `python` if appropriate.

## Navigation

- Previous Day: [Day 068 — Python Configuration Management](../day-068-python-configuration-management/)
- Next Day: [Day 070 — Python Testing Fundamentals with pytest: Assertions, Discovery, and Test Structure](../day-070-python-testing-with-pytest/)
- [Back to Main Learning Path](../README.md)
