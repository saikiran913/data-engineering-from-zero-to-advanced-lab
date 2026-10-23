# Real-World Examples

Each case uses synthetic Data Engineering data. The pattern describes communication and structure; actual inputs still need runtime checks.

| # | Scenario | Suitable pattern | Key caution |
|---|---|---|---|
| 1 | Required order ID | `record_id: str` and required-field check | Annotation does not reject blank text |
| 2 | Optional source label | `str | None` | Check before `.strip()` |
| 3 | Raw amount text | `str | None` parser input | Convert before numeric comparison |
| 4 | Parsed amount | `float | None` return | Document what `None` means |
| 5 | Allowed statuses | `set[str]` parameter | Validate incoming code separately |
| 6 | Status aliases | `dict[str, str]` mapping | Unknown alias needs a rule |
| 7 | Row count | `int` result | Distinguish source from output count |
| 8 | Nonnegative check | `float -> bool` | Value must already be numeric |
| 9 | Status/reason outcome | `tuple[str, str]` | Same two fields every branch |
| 10 | Seven raw records | `list[dict[str, str | None]]` | Validate required keys and shape |
| 11 | Named raw record | Small `TypedDict` | Static shape hint only |
| 12 | Stable configuration | Frozen dataclass with typed fields | Validate business meaning separately |
| 13 | Missing status | Optional input and explicit FAIL | Do not silently treat as READY |
| 14 | Unsupported status | REVIEW with reason | Do not discard source row |
| 15 | Invalid numeric text | Narrow `ValueError` handling | Keep reason visible |
| 16 | Blank amount | `None` from parser | Document blank-value policy |
| 17 | Date text | `str` raw then date parser | Annotation does not prove format |
| 18 | Timestamp field | Document timezone assumption | `str` alone omits meaning |
| 19 | Reusable parser | Typed small function and docstring | Match documented failures |
| 20 | Reusable normalizer | `str -> str` with one-line docstring | Do not mutate raw record |
| 21 | Pure validator | Explicit config parameters | Avoid hidden globals |
| 22 | Result formatter | `dict[str, str] -> str` | No business validation inside |
| 23 | Display-only function | `-> None` and side-effect docstring | Printing is not a reusable return |
| 24 | Changed threshold policy | Named config/parameter | Update docs and tests together |
| 25 | Stale docstring | Review signature and branches | Misleading documentation harms users |
| 26 | Long classifier | Split parse/normalize/validate | Preserve old outcomes |
| 27 | Two reports using same rule | Reuse one validator | Avoid duplicate conditions |
| 28 | Audit raw versus clean data | Return a new record | Preserve original values |
