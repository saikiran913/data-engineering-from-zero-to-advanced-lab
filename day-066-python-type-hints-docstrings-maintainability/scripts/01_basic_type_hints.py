"""Show scalar annotations and a display-only function."""


def normalize_status(status: str) -> str:
    """Return a trimmed, uppercase status."""
    return status.strip().upper()


def is_nonnegative(amount: float) -> bool:
    """Return whether a numeric amount is at least zero."""
    return amount >= 0


def count_records(records: list[str]) -> int:
    """Return the number of record identifiers supplied."""
    return len(records)


def show_result(label: str, value: str) -> None:
    """Print one labelled learning result; return no useful value."""
    print(f"{label}: {value}")


def main() -> None:
    # Annotations describe intended types; Python does not enforce them at runtime.
    show_result("Normalized", normalize_status(" ready "))
    show_result("Amount valid", str(is_nonnegative(12.5)))
    show_result("Record count", str(count_records(["A-1", "B-2"])))


if __name__ == "__main__":
    main()
