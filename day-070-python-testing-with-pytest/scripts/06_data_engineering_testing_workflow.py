"""Combine deterministic cleaning, parsing, validation, and count assertions."""

from datetime import date


def main() -> None:
    raw_records = [
        {"status": " ready ", "amount": "10", "order_date": "2024-02-29"},
        {"status": "completed", "amount": "0", "order_date": "2024-03-01"},
    ]
    clean_records = [
        {
            "status": row["status"].strip().upper(),
            "amount": float(row["amount"]),
            "order_date": date.fromisoformat(row["order_date"]),
        }
        for row in raw_records
    ]
    assert [row["status"] for row in clean_records] == ["READY", "COMPLETED"]
    assert [row["amount"] for row in clean_records] == [10.0, 0.0]
    assert all(row["amount"] >= 0 for row in clean_records)
    assert clean_records[0]["order_date"] == date(2024, 2, 29)
    assert raw_records[0]["status"] == " ready "
    print(f"processed={len(clean_records)} valid_amounts=2 original_unchanged=True")


if __name__ == "__main__":
    main()
