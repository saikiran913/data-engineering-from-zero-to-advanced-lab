"""Read one harmless real variable; use simulated overrides for repeatable results."""

import os


def parse_bool(raw_value: object, setting_name: str) -> bool:
    if isinstance(raw_value, bool):
        return raw_value
    if isinstance(raw_value, str):
        normalized = raw_value.strip().lower()
        if normalized in {"true", "1", "yes"}:
            return True
        if normalized in {"false", "0", "no"}:
            return False
    raise ValueError(f"{setting_name} must be a Boolean setting")


def main() -> None:
    # This harmless lookup depends on the caller's process environment.
    mode = os.getenv("DAY068_EXAMPLE_SETTING", "development")
    print(f"Real DAY068_EXAMPLE_SETTING is present: {os.getenv('DAY068_EXAMPLE_SETTING') is not None}")
    print("Real lookup is environment-dependent; no fixed value is assumed or printed.")
    _ = mode

    simulated_environment = {
        "DAY068_BATCH_SIZE": "25",
        "DAY068_ENABLED": "false",
        "DAY068_EMPTY": "",
        "DAY068_INVALID_ENABLED": "perhaps",
    }
    batch_size = int(simulated_environment["DAY068_BATCH_SIZE"])
    enabled = parse_bool(simulated_environment["DAY068_ENABLED"], "DAY068_ENABLED")
    print(f"simulated batch_size={batch_size} type={type(batch_size).__name__}")
    print(f"simulated enabled={enabled} type={type(enabled).__name__}")
    print(f"missing_is_none={simulated_environment.get('DAY068_ABSENT') is None}")
    print(f"empty_is_blank={simulated_environment['DAY068_EMPTY'] == ''}")
    try:
        parse_bool(simulated_environment["DAY068_INVALID_ENABLED"], "DAY068_INVALID_ENABLED")
    except ValueError as exc:
        print(f"controlled validation error: {exc}")


if __name__ == "__main__":
    main()
