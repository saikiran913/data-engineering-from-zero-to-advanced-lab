"""Read bundled settings, merge safe overrides, and process in-memory records."""

from dataclasses import dataclass
import json
from pathlib import Path


@dataclass(frozen=True)
class Settings:
    source_name: str
    batch_size: int
    enabled: bool
    mode: str
    max_retries: int
    allowed_statuses: tuple[str, ...]


def parse_bool(raw: object) -> bool:
    if isinstance(raw, bool):
        return raw
    if isinstance(raw, str):
        value = raw.strip().lower()
        if value in {"true", "1", "yes"}:
            return True
        if value in {"false", "0", "no"}:
            return False
    raise ValueError("enabled must be a Boolean setting")


def validate(raw: dict[str, object]) -> Settings:
    source_name = raw.get("source_name")
    if not isinstance(source_name, str) or not source_name.strip():
        raise ValueError("source_name must be a non-empty string")
    raw_size = raw.get("batch_size")
    if type(raw_size) not in (int, str):
        raise ValueError("batch_size must be a positive integer")
    try:
        batch_size = int(raw_size)
    except (TypeError, ValueError) as exc:
        raise ValueError("batch_size must be a positive integer") from exc
    if batch_size <= 0:
        raise ValueError("batch_size must be a positive integer")
    mode = raw.get("mode")
    if not isinstance(mode, str) or mode not in {"development", "validation", "production"}:
        raise ValueError("mode must be an allowed choice")
    max_retries = raw.get("max_retries")
    if type(max_retries) is not int or max_retries < 0:
        raise ValueError("max_retries must be a non-negative integer")
    statuses = raw.get("allowed_statuses")
    if not isinstance(statuses, list) or not statuses or not all(isinstance(s, str) and s for s in statuses):
        raise ValueError("allowed_statuses must be a non-empty list of names")
    return Settings(source_name.strip(), batch_size, parse_bool(raw.get("enabled")), mode, max_retries, tuple(statuses))


def process(records: list[dict[str, object]], settings: Settings) -> dict[str, int]:
    if not settings.enabled:
        return {"received": len(records), "processed": 0, "accepted": 0, "rejected": 0, "deferred": len(records)}
    selected = records[:settings.batch_size]
    accepted = sum(record.get("status") in settings.allowed_statuses for record in selected)
    return {
        "received": len(records), "processed": len(selected),
        "accepted": accepted, "rejected": len(selected) - accepted,
        "deferred": len(records) - len(selected),
    }


def main() -> None:
    path = Path(__file__).resolve().parent.parent / "sample-config" / "app_config.json"
    with path.open("r", encoding="utf-8") as config_file:
        file_settings = json.load(config_file)
    if not isinstance(file_settings, dict):
        raise ValueError("app_config.json root must be an object")
    defaults: dict[str, object] = {"batch_size": 100, "enabled": False}
    simulated_env = {"DAY068_BATCH_SIZE": "3", "DAY068_ENABLED": "true"}
    approved_env = {"DAY068_BATCH_SIZE": "batch_size", "DAY068_ENABLED": "enabled"}
    overrides = {setting: simulated_env[name] for name, setting in approved_env.items() if name in simulated_env}
    settings = validate({**defaults, **file_settings, **overrides})
    records: list[dict[str, object]] = [
        {"status": "READY"}, {"status": "COMPLETED"}, {"status": "UNKNOWN"},
        {"status": "REVIEW"}, {"status": "READY"},
    ]
    result = process(records, settings)
    assert result["processed"] == result["accepted"] + result["rejected"]
    assert result["received"] == result["processed"] + result["deferred"]
    print(
        f"source_name={settings.source_name} batch_size={settings.batch_size} enabled={settings.enabled} "
        f"received={result['received']} processed={result['processed']} "
        f"accepted={result['accepted']} rejected={result['rejected']} deferred={result['deferred']}"
    )


if __name__ == "__main__":
    main()
