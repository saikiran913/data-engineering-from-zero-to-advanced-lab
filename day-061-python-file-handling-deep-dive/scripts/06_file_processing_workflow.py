import csv
import json
from pathlib import Path

day_dir = Path(__file__).resolve().parent.parent
source = day_dir / "sample-data" / "orders_input.csv"
config_path = day_dir / "sample-data" / "source_config.json"
output = day_dir / "output"
with config_path.open("r", encoding="utf-8") as file:
    config = json.load(file)
with source.open("r", encoding="utf-8", newline="") as file:
    reader = csv.DictReader(file)
    missing_columns = set(config["required_columns"]) - set(reader.fieldnames or [])
    if missing_columns:
        raise ValueError(f"Missing required columns: {sorted(missing_columns)}")
    rows = list(reader)
results = []
for row in rows:
    status = row["status"].strip().upper()
    validation_status = "PASS"
    reason = ""
    try:
        if float(row["amount"]) < 0:
            validation_status, reason = "FAIL", "negative amount"
    except ValueError:
        validation_status, reason = "FAIL", "invalid amount"
    if row["order_id"].strip() == "":
        validation_status, reason = "FAIL", "blank order_id"
    elif validation_status == "PASS" and status not in config["allowed_statuses"]:
        validation_status, reason = "REVIEW", "unexpected status"
    results.append({**row, "status": status, "validation_status": validation_status, "validation_reason": reason})
with (output / "orders_validated_workflow.csv").open("w", encoding="utf-8", newline="") as file:
    writer = csv.DictWriter(file, fieldnames=list(results[0].keys()))
    writer.writeheader(); writer.writerows(results)
summary = {
    "total_rows": len(results),
    "pass_rows": sum(r["validation_status"] == "PASS" for r in results),
    "review_rows": sum(r["validation_status"] == "REVIEW" for r in results),
    "fail_rows": sum(r["validation_status"] == "FAIL" for r in results),
    "source_file": source.name,
}
with (output / "validation_summary.json").open("w", encoding="utf-8") as file:
    json.dump(summary, file, indent=2)
with (output / "validation_summary.json").open("r", encoding="utf-8") as file:
    print(json.load(file))
