# Context Managers Deep Dive

A context manager is Python's `with` pattern for managing a resource such as an open file. It opens the file for a clearly limited block and closes it when that block ends, including when an error occurs.

```python
from pathlib import Path

path = Path("sample-data/pipeline_notes.txt")
with path.open("r", encoding="utf-8") as file:
    contents = file.read()
```

`file` is available inside the indented block. After the block, the file is closed. This prevents file handles being left open and makes pipeline steps easier to reason about.

## Why It Matters

| Situation | Benefit of `with` |
|---|---|
| Reading an input file | Releases it promptly after parsing |
| Writing generated output | Ensures buffered data is flushed and closed |
| An exception occurs | Cleanup still happens |
| Reviewing a pipeline | The resource lifetime is visible |

Use one `with` block for each clear read or write step. Do not rely on Python eventually closing a file for you.

## Safe Pattern

```python
try:
    with Path("sample-data/source_config.json").open("r", encoding="utf-8") as file:
        config = file.read()
except FileNotFoundError:
    print("Configuration file was not found.")
```

The context manager handles closing; `try` and `except` handle a problem that the pipeline can explain or recover from.
