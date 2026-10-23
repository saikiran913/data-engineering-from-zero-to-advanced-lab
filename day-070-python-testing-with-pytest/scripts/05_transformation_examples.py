"""Check copying and a small status count without mutating source records."""


def main() -> None:
    original = {"status": " ready ", "amount": 5}
    cleaned = {**original, "status": original["status"].strip().upper()}
    assert cleaned == {"status": "READY", "amount": 5}
    assert original == {"status": " ready ", "amount": 5}
    assert cleaned is not original
    records = [cleaned, {"status": "READY"}, {"status": "COMPLETED"}]
    counts = {status: sum(row["status"] == status for row in records) for status in ("READY", "COMPLETED")}
    assert counts == {"READY": 2, "COMPLETED": 1}
    print(f"cleaned_status={cleaned['status']} counts={counts}")


if __name__ == "__main__":
    main()
