# Inspect Python Values and Types Like a Data Engineer

Use the Day 051 scripts and Python standard library only.

## Part 1 — Verify Environment

```bash
python --version
```

Use the Python 3 command from your own environment.

## Part 2 — Run Variable Basics

```bash
python scripts/01_variable_basics.py
```

Confirm that values and types are printed.

## Part 3 — Run Numeric Types

```bash
python scripts/02_numeric_types.py
```

Notice the difference between `int` and `float`.

## Part 4 — Run Strings and Booleans

```bash
python scripts/03_strings_and_booleans.py
```

Pay attention to `bool("False")`.

## Part 5 — Run None and Type Script

```bash
python scripts/04_none_and_types.py
```

Compare `None`, `0`, `False`, and `""`.

## Part 6 — Run Conversion Script

```bash
python scripts/05_type_conversion.py
```

Review successful conversions and the commented unsafe examples.

## Part 7 — Run Data Engineering Type Check

```bash
python scripts/06_data_engineering_type_check.py
```

Read each business meaning beside the value and type.

## Part 8 — Open Python REPL

```python
row_count = 100
type(row_count)
```

## Part 9 — Compare Numeric String

```python
row_count_text = "100"
type(row_count_text)
```

`"100"` is a string, not an integer.

## Part 10 — Compare Missing-Like Values

```python
value_a = None
value_b = 0
value_c = False
value_d = ""

type(value_a)
type(value_b)
type(value_c)
type(value_d)
```

## Part 11 — Try Safe Conversions

```python
int("100")
float("42.5")
str(100)
```

## Part 12 — Discuss Unsafe Conversion

Do not deliberately crash the session unless you are comfortable restarting it.

```python
# int("not-a-number") would raise ValueError.
```

## Part 13 — Build Five Data Engineering Variables

Create:

```python
source_name = "orders"
record_count = 100
average_amount = 42.5
is_valid = True
error_message = None
```

## Part 14 — Print Value and Type

```python
print(source_name, type(source_name))
print(record_count, type(record_count))
print(average_amount, type(average_amount))
print(is_valid, type(is_valid))
print(error_message, type(error_message))
```

## Lab Checklist

- can assign variables
- recognises five core scalar types
- can inspect type
- understands `None`
- understands numeric text
- understands basic conversions
- understands type-aware Data Engineering thinking
