# Troubleshooting Guide

Start with the simplest question: was the event emitted, filtered, sent to another stream, or duplicated by configuration? Then check program control flow and counts.

| Symptom | Check | Next step |
|---|---|---|
| No log appears | Was `main()` called? Is the level high enough? | Confirm entry point and threshold |
| DEBUG missing | INFO normally filters DEBUG | Change threshold in the entry point for investigation |
| Duplicate lines | Child and ancestor handlers or repeated setup | Keep one console configuration |
| Output not captured | Logs usually use `stderr`, print uses `stdout` | Inspect both streams |
| Unexpected logger name | `getLogger(__name__)` reflects module | Check formatter's `%(name)s` |
| Formatting error | `%s` count differs from arguments | Match placeholders and values |
| Unexpected traceback | `logger.exception` was used inside a handler | Decide whether a traceback was warranted |
| No traceback for a failure | Was `logger.error` used instead of `logger.exception`? | Use exception logging inside a specific `except` |
| `logger.exception` outside `except` | No active exception | Move into the relevant handler |
| Failure seems swallowed | Error logged but function continued | Handle explicitly or propagate |
| Too many lines | Per-record logging or DEBUG enabled | Summarise counts, reset INFO |
| Sensitive value appears | Message or exception contains data | Remove it; use safe category and count |
| Missing run context | Inconsistent or absent `run_id`/`stage` | Standardise fields |
| No completion summary | Failure or missing final log | Check control flow; do not invent success |
| FAIL reported as system ERROR | Business and operational labels mixed | Summarise validation outcome at appropriate severity |
| Counts disagree | A stage dropped or double-counted rows | Reconcile input, PASS, REVIEW, FAIL |
| `basicConfig` seems ignored | Handlers may already exist | Inspect existing application setup; avoid adding duplicates |

## Diagnostic Flow

1. Identify the logger name and last completed stage for this run ID.
2. Inspect the effective level and whether the console capture includes `stderr`.
3. Inspect handlers and configuration for missing or duplicate delivery.
4. Check message format placeholders and argument count.
5. Check exception handling and locate the layer that owns recovery.
6. Verify safe, consistent context fields; remove any sensitive values.
7. Compare logged counts with actual validation results and tests. A log can describe an event incorrectly.

Keep troubleshooting safe: never add a raw-record dump or secret just to get more detail.
