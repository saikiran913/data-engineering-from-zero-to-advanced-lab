# Python Filesystem Cheatsheet

```python
from pathlib import Path
import csv
import json

path = Path("sample-data") / "orders_sample.csv"
Path.cwd()
path.exists()
path.is_file()
path.name
path.stem
path.suffix
path.parent
```

```python
with path.open("r", encoding="utf-8") as file:
    text = file.read()
```

```text
locate → verify → identify format → parse → validate
```

Use `csv.DictReader` for CSV and `json.load` for JSON. Sort directory listings before displaying or processing them.
