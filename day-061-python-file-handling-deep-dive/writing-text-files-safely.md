# Writing Text Files Safely

Writing changes storage, so decide whether the destination is an input, an output, or a log before opening it.

| Mode | Meaning | Main safety concern |
|---|---|---|
| `w` | Write a new file or replace an existing file | Replaces prior contents |
| `a` | Add text to the end | Re-running can create duplicate lines |
| `x` | Create only when absent | Raises an error if it already exists |

Write generated files under `output/`; do not write to `sample-data/`. Use `encoding="utf-8"`, and add `\n` deliberately so each record is readable.

```python
from pathlib import Path

output = Path("output/clean_pipeline_notes.txt")
lines = ["Read input", "Validate rows", "Write output"]
with output.open("w", encoding="utf-8") as file:
    file.write("\n".join(lines) + "\n")
```

After writing, reopen the output in read mode and check a row count or a small sample. This simple verification catches an incorrect path, empty content, and accidental formatting changes.
