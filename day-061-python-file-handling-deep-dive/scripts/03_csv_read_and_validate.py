import csv
import json
from pathlib import Path

day_dir = Path(__file__).resolve().parent.parent
path = day_dir / "sample-data" / "orders_input.csv"
with (day_dir / "sample-data" / "source_config.json").open("r", encoding="utf-8") as file:
    config = json.load(file)
required = set(config["required_columns"])
with path.open("r", encoding="utf-8", newline="") as file:
    reader = csv.DictReader(file)
    print("Missing columns:", required - set(reader.fieldnames or []))
    for number, row in enumerate(reader, start=2):
        status = row["status"].strip().upper()
        result = "PASS"
        reason = ""
        try:
            amount = float(row["amount"])
            if amount < config["minimum_amount"]:
                result, reason = "FAIL", "negative amount"
        except ValueError:
            result, reason = "FAIL", "invalid amount"
        if row["order_id"].strip() == "":
            result, reason = "FAIL", "blank order_id"
        elif result == "PASS" and status not in config["allowed_statuses"]:
            result, reason = "REVIEW", "unexpected status"
        print(number, row["order_id"], status, result, reason)
