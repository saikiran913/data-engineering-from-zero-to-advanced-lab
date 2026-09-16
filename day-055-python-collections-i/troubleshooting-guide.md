# Troubleshooting Guide

## `IndexError: list index out of range`

The requested index does not exist. Print the sequence and `len(sequence)`.

## Tuple Index Out of Range

Tuple indexing follows the same rules as list indexing.

## Wrong Item Returned

Check zero-based indexing. The first item is index `0`.

## Slice Missing Expected Item

The stop index is excluded.

## Single-Item Tuple Behaves Unexpectedly

Use a trailing comma:

```python
single = ("orders",)
```

## `TypeError` When Modifying Tuple

Tuples are immutable.

## Too Many Values to Unpack

There are more values than variables.

## Not Enough Values to Unpack

There are fewer values than variables.

## List Changed Unexpectedly

Lists are mutable. Check whether another part of the code changed the same list.

## Append Created Nested List Unexpectedly

`append()` adds one item. `extend()` adds each item from another sequence.

## Membership Returns False Unexpectedly

Check type mismatch. `"100"` is not the same as `100`.

## Loop Record Values Assigned to Wrong Variables

Check tuple position and unpacking order.

## Empty Sequence Produces No Loop Output

This is normal. A loop over an empty sequence has no iterations.

## Troubleshooting Flow

```text
1. print sequence
2. print len(sequence)
3. inspect index
4. inspect slice bounds
5. confirm list vs tuple
6. confirm item types
7. confirm record field order
8. test with 2-3 items
```
