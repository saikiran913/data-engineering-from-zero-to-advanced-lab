# Pipeline Error Taxonomy

| Category | Typical synthetic example | Common policy |
|---|---|---|
| Data validation | Invalid amount | Classify row; no retry |
| Transient technical | Simulated source temporarily unavailable | Safe bounded retry |
| Permanent input | Mandatory field or schema missing | REVIEW/FAIL row or stop stage, per contract |
| Configuration | Required source name missing | Fail fast |
| Programming | Unexpected type or logic bug | Surface failure and fix code |
| Stage/resource | Required input unavailable (conceptual) | Stop or apply a documented safe retry policy |

Classification is a decision supported by a contract, not a guess from the exception class alone. A missing field on one row may be isolated; a missing field in the global schema may invalidate the whole stage. A record put into an in-memory review list is **recoverable** but not **retryable**. A transient exception is retryable only when the operation is safe to repeat and a fixed attempt limit exists.

For a synthetic batch, count rows as PASS/REVIEW/FAIL and report SUCCESS only if the run completed under its contract with no partial outcome. A stage that cannot produce required input should report FAILED, not an empty successful batch by default.
