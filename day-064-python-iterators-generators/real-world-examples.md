# Real-World Examples

All situations use generic synthetic records. The consumer is the step that asks for values.

| # | Source | Eager or lazy choice | Transformation | Consumer | Memory or reuse consideration |
|---|---|---|---|---|---|
| 1 | Small status list | Eager list | Uppercase values | Report | Reuse is easy |
| 2 | Status list iterable | Lazy iterator | None | `for` loop | List remains materialised |
| 3 | `iter(statuses)` | Lazy iterator | `next()` | Manual caller | Position advances |
| 4 | Bounded ID function | Lazy generator | Format IDs | Loop | Recreate to repeat |
| 5 | Number list | Generator expression | Double values | `sum()` | No intermediate doubled list |
| 6 | Order dictionaries | Lazy stage | Normalize statuses | Next stage | Yield copies |
| 7 | Order dictionaries | Lazy stage | Keep active records | Consumer | Excluded rows need policy |
| 8 | Normalized records | Lazy chain | Filter valid IDs | Loop | One pass |
| 9 | Validation results | Lazy chain | Count statuses | Counter variables | No final result list |
| 10 | Conceptual million-row source | Lazy flow | One-record cleanup | Incremental sink concept | Benefit if source is incremental |
| 11 | One-pass event stream concept | Lazy iterator | Select event type | Review loop | Cannot replay same iterator |
| 12 | Small orders needing two reports | Eager list | Normalize once | Two reports | Multiple passes justify list |
| 13 | Orders to sort | Eager result | `sorted()` by date | Dashboard | Sorting materialises |
| 14 | Records needing index 5 | Eager list | None | Random-access lookup | Generator has no index |
| 15 | Empty source generator | Lazy | Normalize nothing | Loop | Counts remain zero |
| 16 | Three records | Lazy generator | Iterate once | Two loops | Second loop is empty |
| 17 | Generator function | Lazy | Recreate source | New loop | Fresh state for repeat |
| 18 | Ten events | Lazy | Filter desired type | Consumer stops early | Later values never requested |
| 19 | Raw records | Lazy validation | PASS/REVIEW/FAIL | Count loop | Errors appear during consumption |
| 20 | Text amount values concept | Lazy parser | Convert per record | Validator | Bad values need explicit result |
| 21 | Two status values | Eager list | Clean strings | Display | Generator adds little value |
| 22 | Regional records | Lazy stage | Canonical region code | Next stage | Keep provenance |
| 23 | Campaign rows | Lazy stage | Keep nonnegative costs | Audit loop | Document rejected rows |
| 24 | Website events | Lazy stage | Extract event IDs | Count loop | One-pass collection |
| 25 | Monthly records | Eager list | Sort by date | Report | Full chronology needs materialisation |
| 26 | Parsed records | Lazy stage | Add clean field | Validator | Copy raw dictionary |
| 27 | Source generator | Lazy chain | Normalize and classify | Print loop | Output happens on demand |
| 28 | Diagnostic sample | Deliberate small list | Inspect first few | Developer | Sample consumption advances source |
| 29 | Repeated source names | Eager set | Deduplicate | Summary | Full uniqueness set uses memory |
| 30 | Totals by status | Lazy chain | Yield result category | Counting loop | Only category counts retained |
