"""Contrast numeric boundaries with missing and blank required fields."""


def missing_fields(record: dict[str, object], required: tuple[str, ...]) -> list[str]:
    return [
        name for name in required
        if name not in record or record[name] is None
        or (isinstance(record[name], str) and not record[name].strip())
    ]


def main() -> None:
    assert 0 >= 0
    assert not (-1 >= 0)
    assert missing_fields({"amount": 0}, ("amount", "order_id")) == ["order_id"]
    assert missing_fields({"order_id": "  "}, ("order_id",)) == ["order_id"]
    print("Zero is valid; negative is not. Missing and blank fields are reported.")


if __name__ == "__main__":
    main()
