"""Check actual values before applying typed business rules."""

from math import isfinite


def parse_amount(raw_amount: str | None) -> float | None:
    """Return a finite amount, or None for missing or invalid text."""
    if raw_amount is None or not raw_amount.strip():
        return None
    try:
        amount = float(raw_amount)
    except ValueError:
        return None
    return amount if isfinite(amount) else None


def normalize_status(raw_status: str | None) -> str | None:
    """Return a canonical status, or None for missing or blank text."""
    if raw_status is None or not raw_status.strip():
        return None
    return raw_status.strip().upper()


def validate_input(
    raw_amount: str | None,
    raw_status: str | None,
    allowed_statuses: set[str],
) -> tuple[str, str]:
    """Return status and reason after explicit parsing and rule checks."""
    amount = parse_amount(raw_amount)
    status = normalize_status(raw_status)
    if amount is None or amount < 0:
        return "FAIL", "Missing, invalid, or negative amount"
    if status is None:
        return "FAIL", "Missing status"
    if status not in allowed_statuses:
        return "REVIEW", "Unsupported status"
    return "PASS", "Valid input"


def main() -> None:
    allowed = {"READY", "COMPLETED"}
    samples = [("12.50", " ready "), (None, "READY"), ("", "READY"), ("bad", "READY"), ("nan", "READY"), ("4", "unknown")]
    for raw_amount, raw_status in samples:
        print("Input:", raw_amount, raw_status, "Result:", validate_input(raw_amount, raw_status, allowed))
    print("Annotations state expectations; the checks above validate actual inputs.")


if __name__ == "__main__":
    main()
