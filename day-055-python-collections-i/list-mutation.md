# List Mutation

Lists are mutable. They can be changed after creation.

## Replace by Index

```python
statuses = ["PASS", "FAIL"]
statuses[1] = "REVIEW"
```

## Append

```python
statuses.append("PASS")
```

`append()` adds one item at the end.

## Extend

```python
statuses.extend(["PASS", "FAIL"])
```

`extend()` adds each item from another sequence.

## Insert

```python
statuses.insert(1, "REVIEW")
```

`insert()` adds an item at a position.

## Remove

```python
statuses.remove("FAIL")
```

`remove()` removes the first matching value.

## Pop

```python
last_status = statuses.pop()
```

`pop()` removes and returns an item.

## Mutation Side Effects

The same list object changes. A function receiving a list may mutate it if designed that way.

## Safer Beginner Habit

Make mutation explicit and document when a list is expected to change.

## Copy Awareness

```python
copy_of_statuses = statuses.copy()
```

This creates a shallow copy. Day 055 does not go deep into object identity.
