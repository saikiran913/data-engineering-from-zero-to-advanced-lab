"""A typed in-memory order workflow with explicit validation contracts."""

from math import isfinite


def parse_amount(raw_amount: str | None) -> float | None:
    """Return a finite numeric amount, or None for missing or invalid text."""
    if raw_amount is None or not raw_amount.strip():
        return None
    try:
        amount = float(raw_amount)
    except ValueError:
        return None
    return amount if isfinite(amount) else None


def normalize_status(raw_status: str | None) -> str | None:
    """Return an uppercase status, or None for missing or blank text."""
    if raw_status is None or not raw_status.strip():
        return None
    return raw_status.strip().upper()


def validate_record(
    record_id: str | None,
    status: str | None,
    amount: float | None,
    allowed_statuses: set[str],
    minimum_amount: float,
) -> tuple[str, str]:
    """Return PASS, REVIEW, or FAIL with a reason using explicit rules."""
    if record_id is None or not record_id.strip():
        return "FAIL", "Missing record ID"
    if amount is None:
        return "FAIL", "Missing or invalid amount"
    if amount < minimum_amount:
        return "FAIL", "Amount below minimum"
    if status is None:
        return "FAIL", "Missing status"
    if status not in allowed_statuses:
        return "REVIEW", "Unsupported status"
    return "PASS", "Valid record"


def process_record(
    raw: dict[str, str | None],
    allowed_statuses: set[str],
    minimum_amount: float,
) -> dict[str, str]:
    """Classify one raw record without changing it; return three text fields."""
    record_id = raw.get("record_id")
    status = normalize_status(raw.get("status"))
    amount = parse_amount(raw.get("amount"))
    validation_status, reason = validate_record(
        record_id, status, amount, allowed_statuses, minimum_amount
    )
    return {
        "record_id": record_id.strip() if record_id else "(missing)",
        "validation_status": validation_status,
        "reason": reason,
    }


def main() -> None:
    raw_records: list[dict[str, str | None]] = [
        {"record_id": "A-1", "status": " ready ", "amount": "12.50"},
        {"record_id": "B-2", "status": "completed", "amount": "8"},
        {"record_id": "C-3", "status": "unknown", "amount": "4"},
        {"record_id": "", "status": "READY", "amount": "3"},
        {"record_id": "E-5", "status": "READY", "amount": "bad"},
        {"record_id": "F-6", "status": None, "amount": "2"},
        {"record_id": "G-7", "status": "READY", "amount": "-1"},
    ]
    original = [record.copy() for record in raw_records]
    allowed_statuses = {"READY", "COMPLETED"}
    minimum_amount = 0.0
    counts = {"PASS": 0, "REVIEW": 0, "FAIL": 0}
    for raw in raw_records:
        result = process_record(raw, allowed_statuses, minimum_amount)
        counts[result["validation_status"]] += 1
        print("Result:", result)
    assert raw_records == original
    assert sum(counts.values()) == len(raw_records)
    print("Summary:", counts, "Total:", len(raw_records))


if __name__ == "__main__":
    main()
