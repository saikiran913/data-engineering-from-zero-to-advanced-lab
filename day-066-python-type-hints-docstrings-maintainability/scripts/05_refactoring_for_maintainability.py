"""Compare a small cluttered classifier with focused typed helpers."""


def old_check(x):
    # The repeated branches and literal threshold make this harder to maintain.
    if not x["id"] or float(x["amount"]) < 0:
        return "FAIL"
    if x["status"].strip().upper() != "READY":
        return "REVIEW"
    return "PASS"


def normalize_status(raw_status: str) -> str:
    """Return a trimmed, uppercase status."""
    return raw_status.strip().upper()


def classify_record(record: dict[str, str], minimum_amount: float) -> tuple[str, str]:
    """Classify a source record and return a stable status/reason pair."""
    record_id = record["id"].strip()
    try:
        amount = float(record["amount"])
    except ValueError:
        return "FAIL", "Invalid amount"
    if not record_id:
        return "FAIL", "Missing ID"
    if amount < minimum_amount:
        return "FAIL", "Amount below minimum"
    if normalize_status(record["status"]) != "READY":
        return "REVIEW", "Unknown status"
    return "PASS", "Valid record"


def main() -> None:
    minimum_amount = 0.0
    records = [
        {"id": "A-1", "amount": "10", "status": " ready "},
        {"id": "B-2", "amount": "5", "status": " unknown "},
        {"id": "", "amount": "3", "status": "READY"},
    ]
    old_outcomes = [old_check(record) for record in records]
    new_results = [classify_record(record, minimum_amount) for record in records]
    new_outcomes = [status for status, _ in new_results]
    assert old_outcomes == new_outcomes == ["PASS", "REVIEW", "FAIL"]
    print("Before outcomes:", old_outcomes)
    print("After status/reason pairs:", new_results)
    print("Classifications preserved:", old_outcomes == new_outcomes)


if __name__ == "__main__":
    main()
