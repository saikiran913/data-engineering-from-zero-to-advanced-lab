# Day 067 — Python Logging Fundamentals: Levels, Context, and Pipeline Diagnostics

## Learning Goal

Use Python's built-in `logging` module to describe meaningful pipeline events without exposing records or overwhelming the console. By the end, you can choose a severity, configure one console logger, add safe context, distinguish validation outcomes from operational failures, and investigate exceptions.

## Connection to Earlier Days

Day 060 introduced reliable scripts and exceptions; Day 062 separated pipeline stages into functions; Day 065 organised components; Day 066 made their contracts readable with type hints and docstrings. Logging now makes those stages observable while they run. A log is diagnostic evidence, not the validated result itself.

## The Mental Model

```text
pipeline action → meaningful event → choose severity → attach safe context → log to console → diagnose or investigate
```

For example, a batch can log that validation finished with six accepted rows and one rejected row. It does not need to print all seven rows.

```python
import logging

logger = logging.getLogger(__name__)

def main() -> None:
    logging.basicConfig(level=logging.INFO, format="%(levelname)s %(name)s %(message)s")
    logger.info("run_id=%s stage=%s record_count=%s", "RUN-001", "VALIDATE", 7)

if __name__ == "__main__":
    main()
```

Configure logging once in the application entry point. `getLogger(__name__)` gives a named logger; the handler sends the message to the console and the formatter controls its appearance. With `basicConfig`, console output normally goes to standard error (`stderr`), whereas `print` normally uses standard output (`stdout`).

## Five Levels

| Level | Operational meaning | Example |
|---|---|---|
| `DEBUG` | Detail useful while investigating | A stage's safe input count |
| `INFO` | Normal milestone | Run completed |
| `WARNING` | Attention needed, work can continue | Three records need review |
| `ERROR` | An operation failed | A stage could not complete |
| `CRITICAL` | Severe, system-wide failure | The whole pipeline cannot proceed |

An INFO threshold hides DEBUG messages. A business validation `FAIL` is not automatically a Python `ERROR`: the program may have handled that outcome as expected.

## Operational Guardrails

> A log line should help diagnose an event, not expose confidential information. Never put passwords, tokens, or unnecessary personal or row-level data into logs.

> Choose log levels based on operational meaning. Expected validation failures are not automatically system errors, and an `ERROR` log does not fix or handle an exception.

> Avoid logging every record in a large pipeline. Prefer concise stage summaries, counts, bounded examples, and targeted debug information.

> Use one clear logging configuration in the application entry point. Reconfiguring loggers in helper modules or adding duplicate handlers can create confusing duplicate messages.

Logs supplement validation results, metrics, tests, and alerting; they do not replace any of them. Today all data is synthetic and in memory. The scripts do not read files or connect to external services.

## Learning Order

Read the concept guides, then the diagnostics and safety guides. Run scripts `01` through `06`, complete the [lab](practice-lab.md), and check your reasoning with the [questions](practice-questions.md).

## Lesson Files

| Resource | Purpose |
|---|---|
| [Revision notes](notes.md) | The complete logging mental model |
| [Print vs logging](print-vs-logging.md) | Output channels and trade-offs |
| [Logging levels](logging-levels.md) | Severity and thresholds |
| [Configuring console logs](configuring-console-logs.md) | Entry-point setup |
| [Logger names and modules](logger-names-and-module-use.md) | Naming, reuse, propagation |
| [Context-rich messages](context-rich-messages.md) | Safe, searchable fields |
| [Logging exceptions](logging-exceptions.md) | Failures and tracebacks |
| [Pipeline diagnostics](pipeline-diagnostics.md) | Stage milestones |
| [Validation outcomes](logging-validation-outcomes.md) | PASS, REVIEW, FAIL |
| [Logging safety and noise](logging-safety-and-noise.md) | Privacy and volume |
| [Cheatsheet](python-logging-cheatsheet.md) | Core patterns |
| [Common mistakes](common-mistakes.md) | Pitfalls and fixes |
| [Real-world examples](real-world-examples.md) | Practical event choices |
| [Beginner summary](beginner-summary.md) | End-to-end recap |
| [Glossary](glossary.md) | Terminology |
| [Practice questions](practice-questions.md) | Exercises and answers |
| [Practice lab](practice-lab.md) | Guided script work |
| [Troubleshooting guide](troubleshooting-guide.md) | Diagnosis checklist |
| [Scripts](scripts/) | Six standalone console examples |

From this folder run `python scripts/01_logging_basics.py`, then proceed in numeric order. Python 3.9+ is sufficient; only the standard library is used.

## Navigation

- Previous Day: [Day 066 — Python Type Hints, Docstrings, and Maintainable Data Engineering Code](../day-066-python-type-hints-docstrings-maintainability/)
- Next Day: [Day 068 — Python Configuration Management: Environment Variables, Config Files, and Safe Defaults](../day-068-python-configuration-management/)
- [Back to Main Learning Path](../README.md)
