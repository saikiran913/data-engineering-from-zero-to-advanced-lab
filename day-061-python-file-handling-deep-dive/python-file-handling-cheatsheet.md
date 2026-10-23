# Python File Handling Cheatsheet

| Need | Pattern |
|---|---|
| Build a path | `Path(__file__).resolve().parent` |
| Read text | `with path.open("r", encoding="utf-8") as file:` |
| Write output | `with path.open("w", encoding="utf-8") as file:` |
| Append log text | `path.open("a", encoding="utf-8")` |
| Read CSV rows | `csv.DictReader(file)` |
| Write CSV rows | `csv.DictWriter(file, fieldnames=fields)` |
| Read JSON | `json.load(file)` |
| Write JSON | `json.dump(data, file, indent=2)` |
| Handle a missing file | `except FileNotFoundError:` |
| Handle invalid JSON | `except json.JSONDecodeError:` |

Always use `with`, `encoding="utf-8"`, explicit CSV columns, and an output path separate from the source path. Use `newline=""` when opening CSV files. Verify output by reading it back.

```python
with path.open("r", encoding="utf-8", newline="") as file:
    rows = list(csv.DictReader(file))
```
