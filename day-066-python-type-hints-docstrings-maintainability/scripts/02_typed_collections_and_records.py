"""Annotate common collections and one static dictionary record shape."""

from typing import TypedDict


class RawOrder(TypedDict):
    record_id: str
    raw_amount: str


def describe_order(order: RawOrder) -> str:
    """Return a label for a record with the documented keys."""
    return f"{order['record_id']}: {order['raw_amount']}"


def collect_ids(records: list[RawOrder]) -> list[str]:
    """Return identifiers from records with the RawOrder shape."""
    return [record["record_id"] for record in records]


def main() -> None:
    source_names: list[str] = ["orders", "customers"]
    allowed_statuses: set[str] = {"READY", "COMPLETED"}
    status_mapping: dict[str, str] = {"done": "COMPLETED"}
    status_and_reason: tuple[str, str] = ("PASS", "Valid")
    records: list[RawOrder] = [
        {"record_id": "A-1", "raw_amount": "12.50"},
        {"record_id": "B-2", "raw_amount": "4.00"},
    ]
    print("Sources:", source_names)
    print("Allowed statuses:", sorted(allowed_statuses))
    print("Status mapping:", status_mapping)
    print("Validation pair:", status_and_reason)
    print("First order:", describe_order(records[0]))
    print("Record IDs:", collect_ids(records))
    # TypedDict helps readers and static tools; it does not check runtime keys.


if __name__ == "__main__":
    main()
