# Beginner Summary

`pathlib.Path` represents a filesystem path and composes child paths portably. Relative paths depend on the working directory, while a script’s location may differ. Derive bundled sample paths from `__file__`, then use `exists`, `is_file`, and `is_dir` before reading.

Do not assume directory listing order; sort it. Use `with` and explicit UTF-8 encoding when reading text. CSV needs the `csv` module because commas can appear inside quoted values, and CSV values start as strings. JSON needs `json`; JSON objects become dictionaries, arrays become lists, and `null` becomes `None`.

```text
Build path → verify path → choose parser → read safely → validate structure → inspect result
```

> Filesystem paths are environment-specific. Prefer `pathlib.Path` instead of manually concatenating path separators such as `/` or `\`.

> Day 059 is intentionally read-oriented. Do not teach destructive filesystem operations such as deleting, renaming, recursively removing, or overwriting important files.

> `split(",")` is not a reliable CSV parser because valid CSV may contain quoted delimiters, embedded commas, and other edge cases. Use Python's `csv` module for CSV files.

> JSON text is not automatically a Python dictionary or list. Parse JSON using Python's `json` module and validate the resulting structure before using nested values.

Day 060 will deepen structured parsing and validation while keeping file handling safe.
