"""Model stable order fields with a normal class."""


class OrderRecord:
    def __init__(self, order_id, status, amount):
        self.order_id = order_id
        self.status = status
        self.amount = amount

    def is_valid_amount(self):
        return self.amount >= 0


def main():
    raw = {"order_id": "ORD-1001", "status": "READY", "amount": 100.0}
    # A dictionary is simpler for one flexible record; a class names stable fields.
    order = OrderRecord(raw["order_id"], raw["status"], raw["amount"])
    print(order.order_id, order.status, order.is_valid_amount())
    print("Raw dictionary remains:", raw)


if __name__ == "__main__":
    main()
