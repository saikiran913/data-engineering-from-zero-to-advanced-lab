"""Demonstrate a tiny cleaning rule and its expected output."""


def normalize_status(value: str | None) -> str | None:
    return None if value is None else value.strip().upper()


def main() -> None:
    raw_status = " completed "
    expected = "COMPLETED"
    actual = normalize_status(raw_status)
    assert actual == expected
    assert raw_status == " completed "
    assert normalize_status(None) is None
    print(f"raw_status={raw_status!r} expected={expected} actual={actual}")


if __name__ == "__main__":
    main()
