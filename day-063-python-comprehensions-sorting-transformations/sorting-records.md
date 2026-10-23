# Sorting Records

A list of dictionaries needs a sort key: a value extracted from each record.

```python
records = [
    {"order_id": "ORD-2", "amount": 50},
    {"order_id": "ORD-1", "amount": 100},
]

sorted_records = sorted(records, key=lambda record: record["amount"])
```

The small `lambda` here is an unnamed function used only to choose the amount. A named function is clearer when the rule grows:

```python
def get_amount(record):
    return record["amount"]

ordered = sorted(records, key=get_amount)
largest_first = sorted(records, key=get_amount, reverse=True)
```

For a string field, use `key=lambda record: record['order_id']`. For two fields, return a tuple: `key=lambda record: (record['status'], record['order_id'])`. The first value orders groups; the second breaks ties. Python sorting is stable: equal keys keep their previous relative order.

Define how missing values behave. This helper puts missing amounts last in ascending order and converts numeric text before comparison:

```python
def amount_key(record):
    value = record.get('amount')
    if value is None or value == '':
        return (1, 0.0)
    return (0, float(value))

ordered = sorted(records, key=amount_key)
```

If a nonnumeric value is possible, validate it before sorting or classify it explicitly. Never rely on `None` comparing to a number.
