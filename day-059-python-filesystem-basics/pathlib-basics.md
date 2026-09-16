# Pathlib Basics

```python
from pathlib import Path

data_dir = Path("sample-data")
file_path = data_dir / "orders_sample.csv"
```

`Path` represents a filesystem path without manual separator concatenation. Use `.name`, `.stem`, `.suffix`, and `.parent` to inspect it. Use `.exists()`, `.is_file()`, and `.is_dir()` before relying on it. `Path.cwd()` shows the current working directory. `.resolve()` creates an environment-specific absolute representation that is useful for debugging, not for committing personal paths.

Practice: build parent/child paths, inspect four properties, check a known file, check a known directory, and explain why `/` composition is portable.
