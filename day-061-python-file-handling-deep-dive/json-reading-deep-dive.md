# JSON Reading Deep Dive

JSON stores structured data using objects, lists, strings, numbers, booleans, and `null`. Python's `json` module converts JSON text into dictionaries and lists.

```python
import json
from pathlib import Path

with Path("sample-data/source_config.json").open("r", encoding="utf-8") as file:
    config = json.load(file)
print(config["required_columns"])
```

Use `json.load(file)` for an open file and `json.loads(text)` for a JSON string. Catch `json.JSONDecodeError` for malformed JSON, such as the deliberate `malformed_config.json` example. A parse error means the structure cannot be trusted; report the file and stop or quarantine it rather than guessing its meaning.

Validate expected keys and value types after parsing. Valid JSON syntax does not guarantee that a configuration has the fields your pipeline needs.
