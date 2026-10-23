# Common Function Design Mistakes

| # | What is wrong | Why it matters | Safer approach |
|---|---|---|---|
| 1 | Hidden global configuration | Caller cannot see dependency | Pass configuration parameter |
| 2 | Too many parameters | Contract becomes unclear | Group related configuration |
| 3 | Vague name | Intent is hidden | Use action-focused names |
| 4 | Mutable default | State survives calls | Default to `None` |
| 5 | Mixed return types | Caller must guess | Use one contract |
| 6 | Implicit `None` | Missing behaviour is unclear | Return/document `None` deliberately |
| 7 | Print instead of return | Result cannot be reused | Return data; print in app |
| 8 | Ignored return | Work is lost | Assign/use result |
| 9 | Transform and validate silently mixed | Stage intent blurs | Separate helpers |
| 10 | I/O and logic mixed | Tests need infrastructure | Isolate I/O |
| 11 | Hidden side effect | Calls surprise users | Make effect explicit |
| 12 | Global mutation | Calls affect later calls | Return new values |
| 13 | Source record mutation | Raw evidence changes | Copy with `{**record}` |
| 14 | Hidden threshold | Rule is unreviewable | Parameterize it |
| 15 | Hard-coded statuses | Caller cannot adapt | Supply allowed statuses |
| 16 | Caller cannot configure | Helper is narrow | Expose relevant options |
| 17 | Validator normalizes | Rules become hard to trace | Normalize first |
| 18 | Parser defaults bad input | Bad data is hidden | Return `None`/failure result |
| 19 | Broad exception | Real bugs are swallowed | Catch specific exceptions |
| 20 | Duplicated rules | Results drift | Reuse validator |
| 21 | Giant function | Debugging is difficult | Compose small functions |
| 22 | Deep nesting | Paths are hard to follow | Return early or split stages |
| 23 | Helper depends on print | Tests capture output | Return result |
| 24 | Formatter validates | Responsibility mixes | Format only |
| 25 | Validator formats | Business rule mixes display | Return structured result |
| 26 | App has all logic | Reuse is impossible | Move helpers to modules |
| 27 | Top-level execution on import | Import has surprising effects | Use `main()` guard |
| 28 | Circular imports | Module loading fails | Keep dependencies one-way |
| 29 | `sys.path` hack | Layout becomes fragile | Use package layout |
| 30 | Wildcard import | Names are unclear | Import explicit names |
| 31 | Inconsistent validation keys | Callers break | Always use status/reason |
| 32 | Unclear optional parameter | Callers misuse it | Document default meaning |
| 33 | Undocumented `None` | Missing vs invalid is unclear | State behaviour in contract |
| 34 | Non-idempotent normalization | Re-runs change values | Make normalized output stable |
| 35 | Mutable collection mutation | Caller data unexpectedly changes | Return a new collection |
| 36 | Side effects in tests | Tests become slow/brittle | Test pure helpers directly |
| 37 | Unnecessary package | Complexity grows | Start with focused modules |
| 38 | Premature classes/decorators | Beginner logic is obscured | Use plain functions first |
| 39 | Wrong type between stages | Later failures are confusing | Define input/output contracts |
| 40 | Missing reason text | Review cannot act | Return actionable reason |
