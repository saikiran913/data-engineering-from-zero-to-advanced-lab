# Iterating Sequences

## Loop List

```python
files = ["orders.csv", "customers.csv"]

for file_name in files:
    print(file_name)
```

## Loop Tuple

```python
statuses = ("PASS", "REVIEW", "FAIL")

for status in statuses:
    print(status)
```

## `enumerate()`

```python
for position, file_name in enumerate(files, start=1):
    print(position, file_name)
```

`enumerate()` provides a position and an item.

## Index-Based Loop Versus Direct Iteration

Prefer direct iteration when the index is not needed:

```python
for file_name in files:
    print(file_name)
```

Avoid unnecessary index-based loops:

```python
for index in range(len(files)):
    print(files[index])
```

## Iterate Records

```python
records = [
    ("ORD-1", "PASS"),
    ("ORD-2", "FAIL"),
]

for order_id, status in records:
    print(order_id, status)
```

## Conditions Inside Loop

```python
for status in statuses:
    if status == "FAIL":
        print("Needs attention")
```

## Functions with Loop Values

Functions from Day 054 can accept one item at a time from a sequence.

## Empty Sequence Behaviour

A loop over an empty sequence has no iterations.
