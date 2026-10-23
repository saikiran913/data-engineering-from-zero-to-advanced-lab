"""Merge approved settings and reject invalid simulated overrides."""


DEFAULTS = {"batch_size": 100, "mode": "development", "enabled": False}
ENV_NAMES = {"DAY068_BATCH_SIZE": "batch_size", "DAY068_MODE": "mode", "DAY068_ENABLED": "enabled"}


def parse_bool(raw_value: object, setting_name: str) -> bool:
    if isinstance(raw_value, bool):
        return raw_value
    if isinstance(raw_value, str):
        value = raw_value.strip().lower()
        if value in {"true", "1", "yes"}:
            return True
        if value in {"false", "0", "no"}:
            return False
    raise ValueError(f"{setting_name} must be a Boolean setting")


def validate(raw: dict[str, object]) -> dict[str, object]:
    raw_size = raw["batch_size"]
    if type(raw_size) not in (int, str):
        raise ValueError("batch_size must be a positive integer")
    try:
        batch_size = int(raw_size)
    except (TypeError, ValueError) as exc:
        raise ValueError("batch_size must be a positive integer") from exc
    if batch_size <= 0:
        raise ValueError("batch_size must be a positive integer")
    mode = raw["mode"]
    if not isinstance(mode, str) or mode not in {"development", "validation", "production"}:
        raise ValueError("mode must be an allowed choice")
    return {"batch_size": batch_size, "mode": mode, "enabled": parse_bool(raw["enabled"], "enabled")}


def load(file_settings: dict[str, object], simulated_env: dict[str, str]) -> dict[str, object]:
    overrides = {setting: simulated_env[name] for name, setting in ENV_NAMES.items() if name in simulated_env}
    merged = {**DEFAULTS, **file_settings, **overrides}
    return validate(merged)


def main() -> None:
    file_settings = {"batch_size": 50, "mode": "validation", "enabled": True}
    simulated_env = {"DAY068_BATCH_SIZE": "25", "DAY068_ENABLED": "false"}
    result = load(file_settings, simulated_env)
    print(f"batch_size={result['batch_size']} mode={result['mode']} enabled={result['enabled']}")
    for bad_overrides in ({"DAY068_BATCH_SIZE": "0"}, {"DAY068_ENABLED": "perhaps"}):
        try:
            load(file_settings, bad_overrides)
        except ValueError as exc:
            print(f"controlled validation error: {exc}")


if __name__ == "__main__":
    main()
