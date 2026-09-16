"""Day 059: parse a synthetic JSON configuration safely."""

import json
from pathlib import Path

config_path = Path(__file__).resolve().parent.parent / "sample-data" / "source_config.json"
with config_path.open("r", encoding="utf-8") as file:
    config = json.load(file)

required_keys = {"source_name", "expected_format", "required_columns"}
print("Root is dictionary:", isinstance(config, dict))
print("Missing required keys:", required_keys - set(config.keys()))
print("Source:", config["source_name"])
print("Optional enabled:", config.get("enabled"))
print("Required columns:", config["required_columns"])
