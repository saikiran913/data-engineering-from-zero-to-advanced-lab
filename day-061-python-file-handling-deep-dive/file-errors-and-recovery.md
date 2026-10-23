# File Errors and Recovery

File handling can fail before parsing, while parsing, or during validation. An understandable failure is much safer than a partially trusted output.

| Error | Meaning | Beginner response |
|---|---|---|
| `FileNotFoundError` | Path does not exist | Check the path and source delivery |
| `PermissionError` | Process cannot access it | Check access and whether another tool owns it |
| `UnicodeDecodeError` | Encoding does not match | Confirm source encoding before retrying |
| `csv.Error` | CSV structure is unusable | Quarantine and inspect the source |
| `JSONDecodeError` | JSON syntax is invalid | Report the location and obtain a corrected file |
| `ValueError` | A value cannot be converted or accepted | Mark the row for review or failure |

Recover safely: preserve the original input, record the filename and reason, write only generated output, and rerun only after the cause is understood. Never overwrite an input file to "fix" it in place.
