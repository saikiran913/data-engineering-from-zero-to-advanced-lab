# Common Mistakes

| Mistake | Why it matters | Safer approach |
| --- | --- | --- |
| Forgetting strings are immutable | Original value remains unchanged | Save the returned string |
| Calling `strip()` without assignment | Cleaning appears ineffective | Use `clean = raw.strip()` |
| Empty string confused with `None` | States can mean different things | Check `None` first |
| Ignoring whitespace-only text | Required field may pass poorly | Strip before blank check |
| Removing internal spaces blindly | Can alter a name or code | Apply a documented rule |
| Uppercasing free text | Display meaning may change | Limit to controlled codes |
| Lowercasing a meaningful ID | Identifier may change | Preserve its contract |
| Removing leading zeros | ID identity is damaged | Keep IDs as strings |
| Broad `replace()` | Changes business meaning | Test a precise replacement |
| Replacing all occurrences accidentally | More text changes than intended | Review input and output |
| Wrong split delimiter | Parts are incorrect | Use the agreed delimiter |
| No field-count check | Later indexing can fail | Validate `len(parts)` |
| Treating split as complex CSV parsing | Quotes can break results | Use a proper parser later |
| Ignoring quoted delimiter | Field boundaries become wrong | Keep this lesson controlled |
| Ignoring empty split field | Required data may be blank | Validate each part |
| Indexing before count check | Can raise `IndexError` | Check length first |
| Converting number text too early | Bad text can fail conversion | Validate text before conversion |
| Wrong join delimiter | Output contract changes | Reuse agreed delimiter |
| Prefix check case mismatch | Valid filename appears invalid | Normalise controlled casing first |
| Suffix check case mismatch | Extension check fails | Strip and normalise if allowed |
| Searching before normalisation | Equivalent value may not match | Clean first |
| Misreading `find()` result | `-1` means absent | Prefer `in` for existence |
| Formatting mistaken for transformation | Underlying value is unchanged | Separate display from data |
| Display rounding mistaken for numeric change | Values are misunderstood | Keep original number |
| Map misses valid variant | Valid input becomes unknown | Review approved variants |
| Map invents unsupported variant | Meaning is guessed | Use business-approved rules |
| Raw value overwritten | Traceability is lost | Keep raw and canonical variables |
| Cleaning not idempotent | Repeat processing drifts | Test a second pass |
| Repeating maps in many places | Rules diverge | Keep one documented map |
| Blank silently defaulted | Quality issue is hidden | Return review state |
| Missing converted to empty text | Source state is lost | Treat `None` separately |
| Whitespace rule undocumented | Readers cannot trust output | Document the rule |
| Standardisation rule undocumented | Canonical output is unclear | Define a contract |
| Free text treated as a code | Meaning is over-cleaned | Use minimal changes |
| Regex introduced unnecessarily | Adds complexity | Use built-in methods here |
| External package added unnecessarily | Basics need no dependency | Use built-ins |
| File parsing introduced too early | Scope becomes unclear | Use in-memory strings |
| Raw/canonical names unclear | Processing is hard to follow | Use descriptive variables |
