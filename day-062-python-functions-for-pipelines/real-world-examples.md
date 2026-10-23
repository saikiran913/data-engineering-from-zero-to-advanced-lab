# Real-World Function Design Examples

| # | Example | Focus |
|---|---|---|
| 1 | Normalize ` ready ` | Status normalization |
| 2 | Convert `UK` to `GB` | Country normalization |
| 3 | Parse `"12.50"` | Amount conversion |
| 4 | Parse ISO date text | Date conversion |
| 5 | Check order ID exists | Required-field validation |
| 6 | Check allowed status | Status validation |
| 7 | Check amount minimum | Amount validation |
| 8 | Classify record | PASS/REVIEW/FAIL result |
| 9 | Format record message | Presentation only |
| 10 | Format totals | Summary presentation |
| 11 | Pass minimum amount | Threshold configuration |
| 12 | Pass allowed statuses | Allowed-status configuration |
| 13 | Use fallback `None` | Optional value contract |
| 14 | Copy a raw record | Raw preservation |
| 15 | Return upper-case string | Pure function |
| 16 | Write inside helper | Impure function to avoid |
| 17 | Read global threshold | Hidden-global anti-pattern |
| 18 | Use `errors=[]` | Mutable-default anti-pattern |
| 19 | Return a parsed float | Scalar return |
| 20 | Return `amount >= 0` | Boolean return |
| 21 | Return `(status, reason)` | Tuple return |
| 22 | Return status/reason dict | Dictionary return |
| 23 | Same keys every branch | Consistent contract |
| 24 | String on pass, dict on fail | Inconsistent contract to avoid |
| 25 | Parse then validate | Composition |
| 26 | App calls helpers | Orchestration |
| 27 | Clean one record | One-record transform |
| 28 | Loop through records | Many-record orchestration |
| 29 | Put conversions in parsers | Helper module design |
| 30 | Keep status mapping in transforms | Transform module |
| 31 | Keep rules in validators | Validator module |
| 32 | Keep messages in formatters | Formatter module |
| 33 | Normalize normalized status again | Idempotence |
| 34 | Reuse validator for two sources | Cross-source reuse |
| 35 | Change minimum without code edit | Configuration-driven validation |

For each situation, document input, output, failure behaviour, and side effects. The same small function can then support many source types without silently changing its rules.
