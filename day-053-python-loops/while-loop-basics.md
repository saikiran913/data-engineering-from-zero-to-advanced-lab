# While Loop Basics

## Basic While

```python
attempt = 1

while attempt <= 3:
    print(f"Attempt: {attempt}")
    attempt += 1
```

The loop stops when `attempt <= 3` becomes false.

## Termination Condition

A termination condition is the rule that allows the loop to end.

## Infinite Loop Risk

Do not execute this example:

```python
# attempt = 1
#
# while attempt <= 3:
#     print(attempt)
```

The value of `attempt` never changes, so the condition stays true.

## Bounded Repetition

Prefer explicit maximum attempts for beginner examples.

```python
check_number = 1
maximum_checks = 3

while check_number <= maximum_checks:
    print(f"Check {check_number}")
    check_number += 1
```

## While Versus For

| Situation | Prefer |
|---|---|
| known collection | `for` |
| known numeric count | `for` with `range()` |
| repeat while condition remains true | `while` |

## Data Engineering Conceptual Example

```python
check_number = 1

while check_number <= 3:
    print(f"Running validation check {check_number}")
    check_number += 1
```

This is only a local counter example. It does not call any external system.

## Avoid `while True` as a Beginner Pattern

`while True` can be useful later, but it needs a clear exit. Day 053 keeps `while` loops bounded.
