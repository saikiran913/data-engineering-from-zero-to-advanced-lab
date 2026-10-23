# JSON Configuration Files

JSON can represent a root object with named settings, numbers, Booleans, and lists. Day 068's [bundled file](sample-config/app_config.json) contains only synthetic settings.

```python
import json
from pathlib import Path

path = Path("sample-config/app_config.json")
with path.open("r", encoding="utf-8") as file:
    config = json.load(file)
if not isinstance(config, dict):
    raise ValueError("app_config.json root must be an object")
```

The relative path above depends on the current working directory. A runnable script derives the lesson root with `Path(__file__).resolve().parent.parent` and then appends `sample-config/app_config.json`, so it also works when invoked from elsewhere.

`json.load` can raise `json.JSONDecodeError` for malformed JSON; opening can raise `FileNotFoundError`. A syntactically valid JSON list is still the wrong root shape here. A valid object can still omit `source_name`, contain a blank value, or use `batch_size: 0`. Check known required and optional keys, types, and bounds after reading and merging. Nested objects are possible, but the lesson keeps one simple flat contract. Do not place credentials in public JSON fixtures.
