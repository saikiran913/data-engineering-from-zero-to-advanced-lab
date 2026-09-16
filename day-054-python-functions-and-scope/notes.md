# Notes — Python Functions and Scope

## What Is a Function?

A function is a named block of reusable logic.

```python
def greet():
    print("Hello")
```

## Why Functions Exist

Functions help with reuse, readability, separation of concerns, testability, and clear interfaces.

## Function Call

```python
greet()
```

A function does not run just because it is defined. It runs when called.

## Parameters

```python
def classify_status(status):
    print(status)
```

`status` is a parameter. It is the input name inside the function.

## Arguments

```python
classify_status("READY")
```

`"READY"` is an argument. It is the value supplied by the caller.

## Return Values

```python
def double(value):
    return value * 2
```

`return` sends a value back to the caller.

## Scope

```text
outside function
→ module/global scope concept

inside function
→ local scope
```

Names created inside a function are local to that function.

## Pure Function Concept

```text
same input
→ same output
→ no hidden external changes
```

Pure functions are easier to reason about and reuse.

## Side Effect Concept

Side effects include printing, writing a file, changing external state, database updates, or network calls. Day 054 keeps side effects minimal and uses only `print()` in orchestration examples.

## Data Engineering Mental Model

```text
input
→ validation/transformation function
→ output
→ next step
```
