# Troubleshooting Guide

## `NameError`

Possible causes:

- typo in variable name
- variable used before assignment
- case mismatch

Check the spelling and make sure assignment happened earlier.

## `SyntaxError` Around Assignment

Possible causes:

- invalid variable name
- unmatched quotes
- hyphen in a variable name

```python
# source-name = "orders"  # invalid
source_name = "orders"
```

## `TypeError`

Example:

```python
# "100" + 20
```

This tries to combine a string and an integer. Inspect values with `type()`.

## `ValueError`

Example:

```python
# int("one hundred")
```

The text is not valid numeric text for integer conversion.

## `NameError: name 'true' is not defined`

Python uses:

```python
True
```

not `true`.

## `NameError: name 'none' is not defined`

Python uses:

```python
None
```

not `none`.

## Numeric Output Concatenates Unexpectedly

If `"100" + "20"` gives `"10020"`, the values are strings. Convert only after checking that conversion is safe.

## Leading Zeros Disappear

If `"00125"` becomes `125`, the value was converted to an integer. Identifiers often need to remain strings.

## `bool("False")` Gives `True`

Any non-empty string is truthy. `bool()` is not a parser for textual true/false values.

## `type()` Result Surprises You

Print both value and type:

```python
print(value)
print(type(value))
```

The observed value may not be the expected business type.

## `None` Printed

`None` is not necessarily an error. It means the variable currently holds a no-value state.

## Wrong Python Interpreter

Reuse Day 050 checks:

```bash
python --version
python scripts/06_data_engineering_type_check.py
```

If output differs across terminals, check which interpreter is active.

## Troubleshooting Flow

```text
1. print the value
2. print type(value)
3. check variable spelling
4. check quotes
5. check expected business meaning
6. check conversion
7. check missing-value rule
```
