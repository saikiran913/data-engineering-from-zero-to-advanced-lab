"""Separate invalid global configuration from isolated record failures."""

import math


def require_source_name(source_name: object) -> str:
    if not isinstance(source_name, str) or not source_name.strip():
        raise ValueError("source_name is required")
    return source_name.strip()


def classify(record: dict[str, object]) -> str:
    amount = record.get("amount")
    if isinstance(amount, bool) or not isinstance(amount, (int, float)) or not math.isfinite(amount) or amount < 0:
        return "FAIL"
    if amount == 0:
        return "REVIEW"
    return "PASS"


def run(records: list[dict[str, object]], source_name: object) -> dict[str, object]:
    require_source_name(source_name)
    counts = {"PASS": 0, "REVIEW": 0, "FAIL": 0}
    for record in records:
        counts[classify(record)] += 1
    return {
        "run_status": "PARTIAL" if counts["REVIEW"] or counts["FAIL"] else "SUCCESS",
        "processed": len(records), "counts": counts,
    }


def main() -> None:
    records = [{"amount": 10}, {"amount": 0}, {"amount": "invalid"}, {"amount": 5}]
    try:
        run(records, "  ")
    except ValueError as exc:
        print(f"run_status=FAILED stage=CONFIG reason={exc}")
    result = run(records, "demo_orders")
    counts = result["counts"]
    print(
        f"run_status={result['run_status']} processed={result['processed']} "
        f"pass={counts['PASS']} review={counts['REVIEW']} fail={counts['FAIL']}"
    )


if __name__ == "__main__":
    main()
