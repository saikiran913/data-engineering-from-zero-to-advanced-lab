# JSON Introduction

JSON is structured text. Use `json.load()` for a file and `json.loads()` for a JSON string.

```python
import json

with file_path.open("r", encoding="utf-8") as file:
    config = json.load(file)
```

| JSON | Python |
| --- | --- |
| object | dict |
| array | list |
| string | str |
| number | int/float |
| true/false | True/False |
| null | None |

Validate root type, required keys, and nested values after parsing. JSON is not automatically a Python dictionary and is not Python literal syntax.
