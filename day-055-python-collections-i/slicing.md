# Slicing

## Basic Slice

```python
files = ["orders.csv", "customers.csv", "products.csv"]
print(files[0:2])
```

This returns the items at indexes `0` and `1`.

## Stop Excluded

The stop index is not included.

## Omit Start

```python
files[:2]
```

This starts from the beginning.

## Omit Stop

```python
files[1:]
```

This continues to the end.

## Full Slice

```python
files[:]
```

This returns a shallow copy of the whole list.

## Negative Slice Concept

```python
files[-2:]
```

This returns the last two items.

## Step Concept

```python
files[::2]
```

This selects every second item.

## Slice Return Type

A list slice returns a list. A tuple slice returns a tuple.

## Common Mistakes

- assuming stop is inclusive
- using wrong boundaries
- using slicing instead of validating sequence shape

## Data Engineering Scenarios

- first N sample files
- last N recent labels conceptually
- subset for debugging
