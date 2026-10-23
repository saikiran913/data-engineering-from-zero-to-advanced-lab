"""Read a bundled INI file and convert its text values explicitly."""

import configparser
from pathlib import Path


def main() -> None:
    path = Path(__file__).resolve().parent.parent / "sample-config" / "pipeline_settings.ini"
    parser = configparser.ConfigParser()
    if not parser.read(path, encoding="utf-8"):
        raise FileNotFoundError("pipeline_settings.ini was not read")
    if not parser.has_section("pipeline") or not parser.has_section("validation"):
        raise ValueError("required INI section is missing")
    source_name = parser.get("pipeline", "source_name").strip()
    batch_size = parser.getint("pipeline", "batch_size")
    enabled = parser.getboolean("pipeline", "enabled")
    require_order_id = parser.getboolean("validation", "require_order_id")
    max_retries = parser.getint("pipeline", "max_retries")
    mode = parser.get("pipeline", "mode")
    if not source_name or batch_size <= 0:
        raise ValueError("source_name must be non-empty and batch_size positive")
    if max_retries < 0 or mode not in {"development", "validation", "production"}:
        raise ValueError("max_retries or mode violates its setting contract")
    print(
        f"source_name={source_name} batch_size={batch_size} "
        f"enabled={enabled} require_order_id={require_order_id}"
    )
    print("getint and getboolean converted INI text into Python values")


if __name__ == "__main__":
    main()
