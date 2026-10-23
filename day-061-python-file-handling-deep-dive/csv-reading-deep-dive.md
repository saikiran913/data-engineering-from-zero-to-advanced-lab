# CSV Reading Deep Dive

CSV is comma-separated values. A CSV field can itself contain a comma when it is quoted, so use Python's `csv` module instead of manually splitting strings on commas.

```python
import csv
from pathlib import Path

path = Path("sample-data/orders_input.csv")
with path.open("r", encoding="utf-8", newline="") as file:
    reader = csv.DictReader(file)
    for row_number, row in enumerate(reader, start=2):
        print(row_number, row["order_id"], row["amount"])
```

`DictReader` uses the header row as keys. Check `reader.fieldnames` before trusting a file, and validate required columns before processing records. CSV values start as text, so convert an amount with `float()` only inside error handling.

Use `newline=""` for CSV files. It lets the CSV module manage line endings correctly across systems.
