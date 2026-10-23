"""Show actionable exceptions and ordinary validation results."""

import math


def parse_amount(raw: object) -> float:
    if isinstance(raw, bool):
        raise ValueError("amount must be numeric")
    try:
        amount = float(raw)
    except (TypeError, ValueError) as exc:
        raise ValueError("amount must be numeric") from exc
    if not math.isfinite(amount) or amount < 0:
        raise ValueError("amount must be finite and non-negative")
    return amount


def validate_amount(raw: object) -> dict[str, str]:
    try:
        parse_amount(raw)
    except ValueError as exc:
        return {"status": "REVIEW", "reason": str(exc)}
    return {"status": "PASS", "reason": "valid amount"}


def parse_at_stage(raw: object) -> float:
    try:
        return parse_amount(raw)
    except ValueError:
        # This boundary cannot recover; bare raise preserves the traceback.
        raise


def main() -> None:
    print(f"valid amount={parse_amount('12.5')}")
    print(f"record outcome={validate_amount('invalid')}")
    try:
        parse_at_stage("invalid")
    except ValueError as exc:
        print(f"caller handled stage error: {exc}")
    print("Programming defects are not generic retry events.")


if __name__ == "__main__":
    main()
