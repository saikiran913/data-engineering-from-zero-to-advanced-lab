"""Day 059: a complete read-only bundled-file inspection workflow."""

import csv
import json
from pathlib import Path


def read_csv_rows(path):
    with path.open("r", encoding="utf-8", newline="") as file:
        return list(csv.DictReader(file))


day_dir = Path(__file__).resolve().parent.parent
data_dir = day_dir / "sample-data"
required_names = {"pipeline_notes.txt", "orders_sample.csv", "source_config.json"}
observed_names = {path.name for path in data_dir.iterdir() if path.is_file()}
missing_names = required_names - observed_names

notes_path = data_dir / "pipeline_notes.txt"
csv_path = data_dir / "orders_sample.csv"
config_path = data_dir / "source_config.json"
with notes_path.open("r", encoding="utf-8") as file:
    note_count = len(list(file))
rows = read_csv_rows(csv_path)
with config_path.open("r", encoding="utf-8") as file:
    config = json.load(file)

print("Sample directory:", data_dir.is_dir())
print("Files:", sorted(observed_names))
print("Missing expected files:", missing_names)
print("Text note lines:", note_count)
print("CSV rows:", len(rows))
print("CSV first order:", rows[0]["order_id"])
print("JSON root is dictionary:", isinstance(config, dict))
print("JSON source:", config.get("source_name"))
