# CSV Introduction

CSV has rows, columns, a delimiter, and often a header. Use the standard-library `csv` parser, not `split(",")`.

```python
import csv

with file_path.open("r", encoding="utf-8", newline="") as file:
    reader = csv.DictReader(file)
    for row in reader:
        print(row["order_id"])
```

`DictReader` returns dictionaries, connecting to Day 056. CSV values are strings until converted explicitly. Quoted commas are valid CSV, which is why naive splitting is unsafe. `newline=""` is the recommended form for the CSV module.
