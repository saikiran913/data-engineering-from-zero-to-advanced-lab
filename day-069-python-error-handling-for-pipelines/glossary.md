# Glossary

| Term | Simple meaning | Beginner example |
|---|---|---|
| Attempt | One call to an operation | First source call |
| Backoff | Delay before another permitted attempt | Computed 2 seconds |
| Bounded retry | Retry with a fixed upper limit | At most three calls |
| Business-rule failure | Record does not satisfy a rule | Negative amount |
| Configuration failure | Run setting is missing or invalid | Blank source name |
| Exception | Python signal that an operation failed | `ValueError` |
| Exception propagation | Passing an unhandled exception upward | Bare `raise` |
| Fail fast | Stop before unsafe work begins | Reject missing config |
| Fatal error | Failure that prevents required work | Source stage cannot complete |
| Idempotency | Repetition does not create unintended extra effects | Recomputing a sum |
| Input validation | Checking incoming data against rules | Numeric amount check |
| Max attempts | Maximum total calls, including first | Three means at most two retries |
| Nonretryable error | Repeating does not help or is unsafe | Invalid amount |
| Partial success | Work finishes with some record issues | PASS plus REVIEW |
| Permanent failure | Condition needing correction rather than immediate retry | Invalid schema |
| Record-level handling | Decision for one row | Return REVIEW reason |
| Recoverable error | Work can continue under defined policy | Isolate a bad row |
| Retry | Another call after a failure | Second safe source attempt |
| Retryable error | Known transient failure safe to repeat | Synthetic temporary source fault |
| Run status | Overall pipeline outcome | SUCCESS/PARTIAL/FAILED |
| Stage failure | A pipeline phase cannot complete | Source stage exhausted |
| Stopping condition | Rule ending retry attempts | Success or attempt limit |
| Transient failure | Temporary fault that may clear | First simulated call fails |
| Validation outcome | Classification of a record | PASS/REVIEW/FAIL |

Recoverable and retryable are deliberately separate terms. A reviewed record may be recoverable without being retried.
