import json
from pathlib import Path

day_dir = Path(__file__).resolve().parent.parent
with (day_dir / "sample-data" / "source_config.json").open("r", encoding="utf-8") as file:
    config = json.load(file)
try:
    with (day_dir / "sample-data" / "malformed_config.json").open("r", encoding="utf-8") as file:
        json.load(file)
except json.JSONDecodeError:
    print("Malformed JSON handled safely")
with (day_dir / "output" / "source_config_pretty.json").open("w", encoding="utf-8") as file:
    json.dump(config, file, indent=2)
print("Config:", config["source_name"])
