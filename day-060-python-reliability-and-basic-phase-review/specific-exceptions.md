# Specific Exceptions

| Operation | Likely exception | Safe response |
| --- | --- | --- |
| `int("abc")` | `ValueError` | Mark invalid conversion |
| Missing dict key | `KeyError` | Check contract |
| Bad list index | `IndexError` | Check length |
| Missing file | `FileNotFoundError` | Report path |
| Malformed JSON | `JSONDecodeError` | Report invalid JSON |

Catch only exceptions that code can handle meaningfully. Avoid broad `except Exception:` in beginner workflows.
