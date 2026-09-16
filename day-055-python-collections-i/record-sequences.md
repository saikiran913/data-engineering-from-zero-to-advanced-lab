# Record Sequences

Record-like tuples use position to carry meaning.

```python
order_record = (
    "ORD-1001",
    "CUST-001",
    "COMPLETED",
    125.50,
)
```

| Index | Meaning |
|---:|---|
| 0 | order_id |
| 1 | customer_id |
| 2 | status |
| 3 | amount |

## Sequence of Records

```python
records = [
    ("ORD-1001", "COMPLETED", 125.50),
    ("ORD-1002", "PENDING", 80.00),
]
```

## Loop Through Records

```python
for order_id, status, amount in records:
    print(order_id, status, amount)
```

Tuple unpacking places each tuple value into a clear variable.

## Validate Shape Conceptually

All tuples should have the same expected positions for reliable processing.

## Positional-Record Risk

As records grow:

- difficult to remember positions
- prone to index errors
- dictionaries or named structures are better later

## Do Not Introduce Dictionaries Yet

Day 055 stays with lists and tuples. Dictionaries come next.
