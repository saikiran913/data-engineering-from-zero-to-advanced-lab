"""Create two independent instances from one simple class."""


class DataSource:
    def __init__(self, name, format_name, enabled=True):
        self.name = name
        self.format_name = format_name
        self.enabled = enabled

    def is_active(self):
        return self.enabled


def main():
    orders = DataSource("orders", "csv")
    events = DataSource("events", "json")
    print(orders.name, orders.format_name, orders.is_active())
    print(events.name, events.format_name, events.is_active())
    orders.enabled = False
    print("After changing orders:", orders.is_active(), events.is_active())


if __name__ == "__main__":
    main()
