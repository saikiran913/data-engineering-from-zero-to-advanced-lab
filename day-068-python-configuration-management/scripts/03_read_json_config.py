"""Read and validate the bundled, non-secret JSON example without writing."""

import json
from pathlib import Path


def main() -> None:
    path = Path(__file__).resolve().parent.parent / "sample-config" / "app_config.json"
    with path.open("r", encoding="utf-8") as config_file:
        config = json.load(config_file)
    if not isinstance(config, dict):
        raise ValueError("app_config.json root must be an object")

    source_name = config.get("source_name")
    batch_size = config.get("batch_size")
    enabled = config.get("enabled")
    mode = config.get("mode")
    max_retries = config.get("max_retries")
    allowed_statuses = config.get("allowed_statuses")
    if not isinstance(source_name, str) or not source_name.strip():
        raise ValueError("source_name must be a non-empty string")
    if isinstance(batch_size, bool) or not isinstance(batch_size, int) or batch_size <= 0:
        raise ValueError("batch_size must be a positive integer")
    if not isinstance(enabled, bool):
        raise ValueError("enabled must be a Boolean setting")
    if not isinstance(mode, str) or mode not in {"development", "validation", "production"}:
        raise ValueError("mode must be an allowed choice")
    if type(max_retries) is not int or max_retries < 0:
        raise ValueError("max_retries must be a non-negative integer")
    if not isinstance(allowed_statuses, list) or not allowed_statuses or not all(isinstance(s, str) and s for s in allowed_statuses):
        raise ValueError("allowed_statuses must be a non-empty list of names")
    print(f"source_name={source_name} batch_size={batch_size} enabled={enabled}")
    print(f"JSON types: batch_size={type(batch_size).__name__} enabled={type(enabled).__name__}")


if __name__ == "__main__":
    main()
