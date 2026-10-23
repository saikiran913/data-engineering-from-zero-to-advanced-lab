"""Keep explicit in-memory outcomes and reasons for every synthetic record."""

import math


def classify(record: dict[str, object]) -> dict[str, str]:
    record_id = str(record["record_id"])
    if "amount" not in record:
        return {"record_id": record_id, "status": "FAIL", "reason": "amount is required"}
    raw_amount = record["amount"]
    if raw_amount is None or raw_amount == "":
        return {"record_id": record_id, "status": "REVIEW", "reason": "amount is blank"}
    if isinstance(raw_amount, bool):
        return {"record_id": record_id, "status": "REVIEW", "reason": "amount is not numeric"}
    try:
        amount = float(raw_amount)
    except (TypeError, ValueError):
        return {"record_id": record_id, "status": "REVIEW", "reason": "amount is not numeric"}
    if not math.isfinite(amount) or amount < 0:
        return {"record_id": record_id, "status": "FAIL", "reason": "amount is not finite and non-negative"}
    if record.get("status") not in {"READY", "COMPLETED"}:
        return {"record_id": record_id, "status": "REVIEW", "reason": "status is unsupported"}
    return {"record_id": record_id, "status": "PASS", "reason": "valid"}


def main() -> None:
    records = [
        {"record_id": "REC-001", "amount": 12, "status": "READY"},
        {"record_id": "REC-002", "amount": "", "status": "READY"},
        {"record_id": "REC-003", "amount": "invalid", "status": "READY"},
        {"record_id": "REC-004", "amount": 8, "status": "UNKNOWN"},
        {"record_id": "REC-005", "status": "READY"},
        {"record_id": "REC-006", "amount": 5, "status": "COMPLETED"},
    ]
    results = [classify(record) for record in records]
    review_results = [result for result in results if result["status"] == "REVIEW"]
    counts = {status: sum(result["status"] == status for result in results) for status in ("PASS", "REVIEW", "FAIL")}
    assert sum(counts.values()) == len(records)
    print(f"processed={len(records)} pass={counts['PASS']} review={counts['REVIEW']} fail={counts['FAIL']}")
    for result in review_results:
        print(f"record_id={result['record_id']} status=REVIEW reason={result['reason']}")
    print("Review results remain in memory; malformed values were not retried.")


if __name__ == "__main__":
    main()
