# Common Mistakes

| Mistake | Safer approach |
| --- | --- |
| Bare `except` | Catch specific exception |
| Silent `pass` | Report outcome |
| Huge try block | Wrap risky line only |
| Validate after conversion | Validate first |
| Missing key assumed | Check contract |
| List index assumed | Check length |
| Blank equals None | Handle separately |
| Missing file hidden | Report expected path |
| JSON error ignored | Report malformed structure |
| All logic in main | Use helpers |
| Module side effect | Use main guard |
| Wildcard import | Use focused imports |
| Circular imports | Keep modules focused |
| One giant module | Separate responsibilities |
| Custom exception early | Use built-ins |
| No raw value | Preserve traceability |
| Production data | Use synthetic data |
| Write/delete practice | Keep read-only |
| No summary | Report outcomes |
| Catch unknown error | Let it surface |
| Wrong type assumed | Validate input |
| Logical error ignored | Review rule |
| No init file | Include for lesson clarity |
| No input contract | Document fields |
| No output contract | State outcomes |
| Fallback hides issue | Use PASS/REVIEW/FAIL |
| No path check | Validate before read |
| No encoding | Specify UTF-8 |
| CSV split manually | Use csv parser |
| JSON unparsed | Use json parser |
| None arithmetic | Check missing |
| Mixed timezones | Use compatible values |
| Wrong exception type | Catch correct type |
| No invalid case | Test safe cases |
| Dynamic sample | Use fixed input |
| External package | Standard library only |
| Main called on import | Main guard |
| Hidden global state | Pass parameters |
