# Beginner Summary

## What Learners Should Remember

Lists and tuples are ordered sequences. A list uses square brackets `[]`. A tuple uses parentheses `()`.

Indexing starts at zero. The first item is at index `0`, not index `1`. Negative indexes count from the end, so `items[-1]` returns the last item.

Slicing selects a range. The slice stop is excluded, so `items[0:2]` returns indexes `0` and `1`, not index `2`.

Lists are mutable. They can be changed after creation with operations such as replacement, `append()`, and `extend()`. Tuples are immutable. Their positions cannot be reassigned after creation.

`len()` returns sequence length. `in` checks membership. Loops work naturally with sequences, which connects directly to Day 053.

Record tuples depend on documented position. Tuple unpacking can make fixed records easier to read:

```python
order_id, status, amount = ("ORD-1001", "PASS", 125.50)
```

Lists are useful when a collection changes. Tuples are useful for fixed positional records. Complex records should eventually move to named structures.

## Mental Model

```text
Choose sequence type
→ define order
→ access safely
→ iterate
→ preserve meaning
```

## Required Warnings

> Python sequences use zero-based indexing. The first item is at index `0`, not index `1`.

> Indexing outside the valid range raises an error. Check sequence length or design inputs carefully before accessing fixed positions.

> Lists are mutable and can be changed after creation. Tuples are immutable, but the objects stored inside them may still be mutable.

> Positional record structures become difficult to understand as they grow. Use clear documentation and move to named structures such as dictionaries when field meaning becomes complex.

## Preview

**Day 056 — Python Collections II: Dictionaries, Sets, Key-Based Records, and Deduplication**

Day 056 will introduce key-based records and uniqueness-focused collections.
