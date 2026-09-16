# Filesystem Patterns for Data Engineers

```python
day_dir = Path(__file__).resolve().parent.parent
data_dir = day_dir / "sample-data"
```

Use script-relative paths so scripts work from different terminals. Verify required files, inspect a sorted directory, dispatch a parser based on the expected format, read CSV into row dictionaries, load JSON configuration, count file types, and print a read-only summary.

```text
base directory → expected path → existence/type check → parser → in-memory structure → validation summary
```
