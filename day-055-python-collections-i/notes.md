# Notes — Python Collections I

## What Is a Collection?

A collection is one value that holds multiple values.

## What Is a Sequence?

A sequence is an ordered collection. Values have positions and can be accessed by index.

## List

```python
files = ["orders.csv", "customers.csv", "products.csv"]
```

A list is mutable, which means it can be changed after creation.

## Tuple

```python
record = ("ORD-1001", "COMPLETED", 125.50)
```

A tuple is immutable, which means its positions cannot be reassigned after creation.

## List Versus Tuple

| Feature | List | Tuple |
|---|---|---|
| Ordered | Yes | Yes |
| Indexed | Yes | Yes |
| Mutable | Yes | No |
| Syntax | `[]` | `()` |
| Typical beginner use | changing collection | fixed-position record |

## Indexing

Indexing accesses one item by position.

```python
files[0]
```

The first item is index `0`.

## Slicing

Slicing selects a range.

```python
files[0:2]
```

The stop index is excluded.

## Sequence Length

```python
len(files)
```

`len()` returns the number of items.

## Membership

```python
"orders.csv" in files
```

Membership checks whether a value exists in a sequence.

## Loop Connection

Loops from Day 053 work naturally with lists and tuples.

## Function Connection

Functions from Day 054 can accept sequences as arguments and return sequences conceptually.

## Data Engineering Mental Model

```text
multiple related values
→ store in sequence
→ inspect by position
→ loop
→ validate/transform
```
