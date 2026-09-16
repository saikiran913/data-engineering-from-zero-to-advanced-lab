# Indexing

## Zero-Based Indexing

```python
files = ["orders.csv", "customers.csv", "products.csv"]

print(files[0])
print(files[1])
```

The first item is at index `0`.

## Negative Indexing

```python
print(files[-1])
```

`-1` returns the last item.

## Out of Range

Do not execute this as a required exercise:

```python
# files[10] raises IndexError.
```

Indexing outside the valid range raises an error.

## Safe Index Thinking

- know the length
- know the sequence contract
- avoid magic positions when meaning is unclear

## Tuple Indexing

```python
record = ("ORD-1", "PASS")
print(record[0])
print(record[1])
```

## Nested Indexing Conceptually

```python
records = [
    ("ORD-1", "PASS"),
    ("ORD-2", "FAIL"),
]

print(records[0][1])
```

`records[0]` selects the first tuple. `[1]` then selects the second value inside that tuple.

## Index Meaning in Data Engineering

Indexes may represent CSV field position, row record position, or pipeline step order. Positional meaning should be documented.
