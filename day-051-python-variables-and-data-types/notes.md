# Notes — Python Variables and Data Types

## What Is a Variable?

A variable is a name that refers to a value.

```python
record_count = 100
```

In this example:

- `record_count` is the variable name
- `=` is the assignment operator
- `100` is the value

The left side receives the name. The right side provides the value.

## Assignment Versus Equality

Assignment uses one equals sign:

```python
record_count = 100
```

This means: make `record_count` refer to the value `100`.

Equality comparison uses two equals signs:

```python
record_count == 100
```

This asks: is `record_count` equal to `100`?

## Variable Naming

Valid names:

```python
record_count
source_name
is_valid
```

Invalid names:

```python
2records
source-name
class
```

A variable name cannot start with a number. It cannot use a hyphen because Python reads hyphen as subtraction. Reserved keywords such as `class` already have special meaning. Python code usually uses `snake_case` for variable names.

## Reassignment

```python
record_count = 100
record_count = 120
```

After the second line, `record_count` refers to `120`. Reassignment replaces the old reference with a new one.

## Dynamic Typing

```python
value = 100
value = "100"
```

Python allows a variable to refer to a different type later. This is called dynamic typing. Data Engineering code should still be intentional because type changes can break validation and calculations.

## Core Scalar Types

| Python type | Example | Meaning |
|---|---|---|
| `int` | `100` | whole number |
| `float` | `42.5` | decimal number |
| `str` | `"orders"` | text |
| `bool` | `True` | logical state |
| `NoneType` | `None` | no value / missing state concept |

## Type Awareness

Use `type()` to inspect what Python sees:

```python
value = "100"
print(type(value))
```

Type awareness means asking, "What type is this value now, and what type should it be for this business meaning?"

## Data Engineering Connection

```python
row_count = 1000
average_value = 45.2
source_name = "orders.csv"
is_complete = True
last_error = None
```

`row_count` is an `int`, `average_value` is a `float`, `source_name` is a `str`, `is_complete` is a `bool`, and `last_error` is `None` because no error is currently available.
