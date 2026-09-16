# Troubleshooting Guide

## `SyntaxError` Near `if`

Check:

- colon after the condition
- balanced parentheses
- matched quotes

## `IndentationError`

Python uses indentation to define blocks. Keep indentation consistent, usually four spaces.

## Condition Always False

Possible causes:

- wrong type
- wrong case
- wrong comparison operator

Print the value and `type(value)`.

## Condition Always True

Possible causes:

- misuse of `or`
- truthy non-empty string

Classic caution:

```python
if status == "READY" or "RETRY":
    print("Allowed")
```

This is wrong because `"RETRY"` is a non-empty string and is truthy.

Correct:

```python
if status == "READY" or status == "RETRY":
    print("Allowed")
```

Or:

```python
if status in ("READY", "RETRY"):
    print("Allowed")
```

## `None` Comparison Fails

Do not compare `None` numerically before checking it.

```python
if row_count is not None and row_count > 0:
    print("Rows available")
```

## Numeric String Comparison Issue

`"100"` is text. Compare or convert deliberately after validation.

## Wrong Branch Runs

Check rule order. Earlier branches can prevent later branches from running.

## Later `elif` Never Runs

An earlier broad condition may capture the value first.

## Boundary Behaves Unexpectedly

Check `>` versus `>=`, and `<` versus `<=`.

## `bool("False")` Returns True

`"False"` is a non-empty string, so it is truthy.

## Independent Rules Skipped

Maybe `elif` was used when separate `if` statements were required.

## Multiple Outcomes Occur Unexpectedly

Maybe multiple independent `if` statements were used when an exclusive chain was intended.

## Troubleshooting Flow

```text
1. print input value
2. print type
3. print individual condition result
4. test boundaries
5. inspect rule order
6. simplify Boolean expression
7. add parentheses
8. explain expected business rule in plain English
```
