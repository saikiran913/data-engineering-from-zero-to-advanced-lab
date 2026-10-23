# Glossary

| Term | Simple meaning | Example |
|---|---|---|
| `basicConfig` | Small one-time application logging setup | Set INFO and format in `main` |
| Console handler | Handler that sends logs to a stream | Default basic console output |
| Context | Safe fields that locate an event | `run_id=RUN-001` |
| CRITICAL | Severe inability to continue | Entire pipeline unavailable |
| DEBUG | Investigative detail | Input count before a filter |
| Diagnostic event | Event recorded to help investigate execution | Stage finished |
| ERROR | Failed operation | Stage raised unexpectedly |
| Event | Something worth recording | Validation completed |
| Exception | Python signal of an abnormal condition | `RuntimeError` |
| Formatter | Rule for displaying a log | Level, name, message |
| Handler | Component that delivers a log record | `StreamHandler` |
| INFO | Normal milestone | Run started |
| Level | Severity threshold or event severity | INFO filters DEBUG |
| Log message | Text describing an event | `stage=VALIDATE pass_count=5` |
| Logger | Named source of log events | `logging.getLogger(__name__)` |
| Logger name | Label identifying event origin | `pipeline.validate` |
| Logging | Recording execution events | Stage summary |
| Module logger | Logger named after a Python module | `getLogger(__name__)` |
| Propagation | Child logger passing an event upward | Child event reaches root handler |
| Run ID | Safe label linking one run's events | `RUN-001` |
| Severity | Operational importance of an event | WARNING for review action |
| `stderr` | Standard error output stream | Default basic console logs |
| `stdout` | Standard output stream | Default `print` output |
| StreamHandler | Logging handler for a stream | Console handler |
| Traceback | Call path leading to an exception | Added by `logger.exception` |
| Validation outcome | Business classification | PASS, REVIEW, FAIL |
| Verbosity | Amount of detail shown | DEBUG shows more than INFO |
| WARNING | Handled condition needing attention | Review count above zero |

Level names are operational. A validation outcome is a separate business label.
