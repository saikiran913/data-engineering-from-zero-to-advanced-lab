import csv
import json
from pathlib import Path

day_dir = Path(__file__).resolve().parent.parent
source = day_dir / "sample-data" / "orders_input.csv"
output = day_dir / "output" / "orders_validated.csv"
with (day_dir / "sample-data" / "source_config.json").open("r", encoding="utf-8") as file:
    config = json.load(file)
with source.open("r", encoding="utf-8", newline="") as file:
    rows = list(csv.DictReader(file))
fields = ["order_id", "customer_id", "order_date", "status", "amount", "order_note", "validation_status", "validation_reason"]
with output.open("w", encoding="utf-8", newline="") as file:
    writer = csv.DictWriter(file, fieldnames=fields)
    writer.writeheader()
    for row in rows:
        result, reason = "PASS", ""
        if row["order_id"].strip() == "":
            result, reason = "FAIL", "order_id required"
        else:
            try:
                if float(row["amount"]) < config["minimum_amount"]:
                    result, reason = "FAIL", "negative amount"
            except ValueError:
                result, reason = "FAIL", "invalid amount"
            if result == "PASS" and row["status"].strip().upper() not in config["allowed_statuses"]:
                result, reason = "REVIEW", "unexpected status"
        writer.writerow({
            **row,
            "validation_status": result,
            "validation_reason": reason,
        })
print("Wrote:", output.name)
