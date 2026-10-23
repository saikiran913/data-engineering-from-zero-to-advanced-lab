# Modelling Records with Classes

A dictionary is a simple record:

```python
record = {"order_id": "ORD-1001", "status": "READY", "amount": 100.0}
```

A class gives the fields named attributes and can attach related behaviour:

```python
class OrderRecord:
    def __init__(self, order_id, status, amount):
        self.order_id = order_id
        self.status = status
        self.amount = amount

    def is_valid_amount(self):
        return self.amount >= 0
```

`record.order_id` is clear when the schema is stable. An instance method is useful if the check naturally belongs with the record, though a separate validation function may be easier to reuse with several record types. The class takes more code than the dictionary; a one-off or flexible source record can stay a dictionary.
