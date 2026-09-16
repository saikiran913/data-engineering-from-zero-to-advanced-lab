# Troubleshooting Guide

| Problem | Check |
| --- | --- |
| `FileNotFoundError` | Path, cwd, and script-relative base |
| Expected path wrong | Print expected path and resolve |
| `IsADirectoryError` | Path is directory, not file |
| `NotADirectoryError` | Parent component is wrong |
| `UnicodeDecodeError` | Encoding does not match source |
| CSV header unexpected | Inspect header row |
| CSV type unexpected | Reader returns strings |
| CSV row KeyError | Column missing or misspelled |
| JSON decode error | JSON is malformed |
| JSON root list | Validate type before key lookup |
| JSON key missing | Check contract |
| Listing order changes | Sort explicitly |
| Script only works in one folder | Use `__file__`-relative paths |

```text
1. print Path.cwd()
2. print expected path
3. print path.resolve()
4. check exists/is_file/is_dir
5. check suffix
6. choose parser
7. inspect parsed type
8. validate required structure
```
