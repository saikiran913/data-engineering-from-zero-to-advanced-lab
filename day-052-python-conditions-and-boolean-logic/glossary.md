# Glossary

| Term | Simple meaning | Beginner example |
|---|---|---|
| Allowlist concept | Values that are accepted | `status in ("READY", "RETRY")` |
| Blocklist concept | Values that are rejected | `status in ("FAILED", "CANCELLED")` |
| Boolean expression | Expression that becomes true or false | `record_count > 0` |
| Boundary value | Value at a threshold | `error_count = 5` |
| Branch | Code path chosen by a condition | `if` block |
| Comparison | Checking values against each other | `a >= b` |
| Condition | Question Python evaluates | `schema_valid` |
| Decision path | Route through branches | `if` then `else` |
| Equality | Same-value comparison | `status == "READY"` |
| Fallback branch | Final default path | `else` |
| Falsy | Behaves false-like | `0`, `None`, `""` |
| If statement | Starts a conditional branch | `if has_rows:` |
| Indentation | Spaces defining a block | four spaces |
| Logical AND | Both must be true | `a and b` |
| Logical NOT | Reverse Boolean value | `not has_errors` |
| Logical OR | At least one must be true | `a or b` |
| Membership | Check value in allowed group | `status in (...)` |
| Mutually exclusive | Only one outcome should apply | PASS/FAIL |
| Operator precedence | Evaluation order | `not`, then `and`, then `or` |
| Overlapping condition | One value matches multiple rules | `> 0` and `> 100` |
| Rule order | Order branches are checked | severe before broad |
| Short-circuit | Python may stop early | false `and` stops |
| Truthy | Behaves true-like | non-empty string |
| Unreachable branch | Branch that can never run | broad rule before narrow |
| Validation outcome | Final decision | `PASS` |
| Validation rule | Business check in code | row count must be positive |
| `and` | Boolean operator requiring both | `has_rows and is_fresh` |
| `in` | Membership operator | `status in (...)` |
| `is None` | Explicit missing check | `value is None` |
| `not` | Boolean reversal | `not has_errors` |
| `or` | Boolean operator requiring one | `ready or retry` |
