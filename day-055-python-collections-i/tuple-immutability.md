# Tuple Immutability

## Cannot Reassign Item

Do not execute this as a required exercise:

```python
# record[1] = "NEW" raises TypeError.
```

Tuple positions cannot be changed after creation.

## Why Immutability Is Useful

- fixed record shape
- reduced accidental positional changes
- communicates "do not change structure"

## Important Caveat

A tuple may contain a mutable object.

```python
record = ("ORD-1", ["PASS"])
```

The tuple itself is immutable, but the contained list is still mutable. Keep this caveat brief for now.

## Tuple Unpacking

```python
order_id, status = ("ORD-1", "PASS")
```

The number of variables must match the number of values.
