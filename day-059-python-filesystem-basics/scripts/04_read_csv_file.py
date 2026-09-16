"""Day 059: parse synthetic CSV rows safely with DictReader."""

import csv
from pathlib import Path

csv_path = Path(__file__).resolve().parent.parent / "sample-data" / "orders_sample.csv"
with csv_path.open("r", encoding="utf-8", newline="") as file:
    reader = csv.DictReader(file)
    field_names = reader.fieldnames
    rows = list(reader)

print("Fields:", field_names)
print("Row count:", len(rows))
for row in rows[:3]:
    print(row["order_id"], row["order_status"], row["order_amount"], type(row["order_amount"]).__name__)
