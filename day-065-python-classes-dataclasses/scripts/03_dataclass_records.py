"""Show generated initializer, representation, equality, and a focused method."""

from dataclasses import asdict, dataclass


@dataclass
class OrderRecord:
    order_id: str
    status: str
    amount: float

    def has_nonnegative_amount(self):
        return self.amount >= 0


def main():
    first = OrderRecord("ORD-1001", "READY", 100.0)
    same_values = OrderRecord("ORD-1001", "READY", 100.0)
    second = OrderRecord("ORD-1002", "REVIEW", -1.0)
    print("Representation:", first)
    print("Equal field values:", first == same_values)
    print("Second amount valid:", second.has_nonnegative_amount())
    print("Dictionary copy:", asdict(first))


if __name__ == "__main__":
    main()
