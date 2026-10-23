# Fail Fast vs Continue

Fail fast when a global assumption is broken before processing records. Continue when one bad record can be isolated and the stage contract permits partial output. Document thresholds: some pipelines may abort when too many rows fail, but an unspecified threshold must not be invented silently.

| Situation | Scope | Decision | Report |
|---|---|---|---|
| Missing required `source_name` | Run | Fail fast | `FAILED`, no rows processed |
| Global schema cannot be interpreted | Stage | Stop | `FAILED`, reason |
| One nonnumeric amount | Record | REVIEW, continue | `PARTIAL`, reason and count |
| One negative amount | Record | FAIL, continue if allowed | `PARTIAL`, reason and count |
| All records valid | Records | Continue | `SUCCESS`, full counts |
| Known transient source failure | Stage | Safe bounded retry | Final status after success/exhaustion |

`PASS`, `REVIEW`, and `FAIL` are **record outcomes**. `SUCCESS`, `PARTIAL`, and `FAILED` are **run outcomes**. If a run finishes with one reviewed row, call it PARTIAL under this lesson's policy rather than silently calling it full SUCCESS. Even a continued run should retain counts and explicit reasons. A pipeline must not skip every bad input and report an empty successful result.
