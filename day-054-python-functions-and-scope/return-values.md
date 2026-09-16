# Return Values

## `return`

```python
def calculate_total(a, b):
    return a + b
```

`return` sends the result back to the caller.

## Caller Receives Result

```python
total = calculate_total(10, 20)
```

The variable `total` receives the returned value.

## Return Versus Print

Bad reusable pattern:

```python
def calculate_total(a, b):
    print(a + b)
```

Better:

```python
def calculate_total(a, b):
    return a + b
```

Print at the orchestration layer if needed.

## Multiple Return Paths

```python
def classify_record_count(record_count):
    if record_count is None:
        return "REVIEW"

    if record_count == 0:
        return "FAIL"

    return "PASS"
```

Each branch returns a clear outcome.

## Implicit None

A function without `return` returns `None`.

```python
def show_value(value):
    print(value)
```

This displays the value but does not return a reusable result.

## Consistent Return Type

A validation function should consistently return the same kind of value, such as a status string.

## Early Return Concept

Returning early can make rule order clear when each branch is simple.
