# Real-World Examples

These scenarios use generic in-memory data and show how to choose an abstraction deliberately.

| # | Scenario | Recommended abstraction | Why | Key fields or state | Behaviour | Over-engineering risk |
|---|---|---|---|---|---|---|
| 1 | One simple order | Dictionary | Flexible one-off data | ID, status, amount | None | Class adds ceremony |
| 2 | Repeated stable orders | Dataclass | Document fixed shape | ID, status, amount | Optional simple check | Deep model tree |
| 3 | Source settings | Dataclass | Related values | Name, format | None | Stateful class without behaviour |
| 4 | Validation rules | Frozen dataclass | Stable rule bundle | Allowed statuses, minimum | None | Hidden global config |
| 5 | Immutable settings | Frozen dataclass | Prevent reassignment | Threshold, tuple | None | Mutable nested list |
| 6 | Reused status normalizer | Class | Stores allowed set | Allowed statuses | Normalize, check | Giant processor |
| 7 | Reused validator | Class | Stores rule config | Config | Classify | Mixed I/O |
| 8 | One stateless validation rule | Function | No persistent state | Amount parameter | Boolean/result | One-method class |
| 9 | Parse amount text | Function | Stateless conversion | Raw text | Numeric parse | Parser object without config |
| 10 | Parser with stable mode | Small class | Reuses mode | Mode setting | Parse | Framework-like hierarchy |
| 11 | Three regional settings | Dataclass instances | Independent configs | Region, status tuple | None | Single mutable global |
| 12 | Two data sources | Normal class instances | Independent state | Name, enabled | `is_active` | Shared class attribute |
| 13 | Shared mutable tags risk | Dataclass field | Per-instance list needed | Tags | Append tag | `tags=[]` |
| 14 | Safe tag default | Dataclass + factory | Fresh list each time | Tags | Append tag | Reusing external list |
| 15 | One-method checker | Function | No state needed | Status input | Check | Unnecessary object |
| 16 | Compare two records | Dataclass | Value equality useful | Same field values | Equality generated | Custom equality code |
| 17 | Inspect record during review | Dataclass | Readable representation | Record fields | Generated repr | Hand-built repr |
| 18 | Configured normalizer | Small class | Rule reused | Allowed statuses | Normalize | Mixed concerns |
| 19 | Normalizer plus validator | Composition | Roles stay focused | Two components | Process | Inheritance tree |
| 20 | Extend no behaviour | Composition/function | No parent needed | Inputs | Direct call | Subclass solely for reuse |
| 21 | Uppercase a status | Function | Stateless one-step logic | Text | Return uppercase | Class wrapper |
| 22 | Extra one-off metadata | Dictionary | Shape may change | Arbitrary keys | None | Rigid dataclass |
| 23 | Stable website event | Dataclass | Known schema | Event ID, date, type | None | Too many subclasses |
| 24 | Dynamic event properties | Dictionary | Variable keys | Metadata mapping | None | Fixed fields for every key |
| 25 | Per-run count state | Small class or dict | Counts persist across calls | PASS, REVIEW, FAIL | Increment | Unneeded framework |
| 26 | Immutable threshold config | Frozen dataclass | Rules stay stable | Minimum | None | Mutating during run |
| 27 | Preserve raw and clean | Dictionary plus dataclass | Trace source and model output | Raw/clean fields | Normalize separately | In-place raw mutation |
| 28 | Validate a record | Function or method | Depends on rule ownership | Record, config | Classify | Hidden constructor check |
| 29 | Simple model without package | Dataclass | Standard library suffices | Record fields | None | External dependency |
| 30 | Full in-memory flow | Dataclass + components | Clear stages | Config, order | Normalize/classify | God class |
| 31 | Class per pipeline step | Functions first | No enduring state | Input/output | Transform | Over-modelling |
| 32 | Pass rules to validator | Config + class | Explicit dependency | Rule object | Classify many rows | Hidden global |
