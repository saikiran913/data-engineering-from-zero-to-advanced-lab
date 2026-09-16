# Numeric Types

## Integer

An integer is a whole number.

```python
row_count = 100
```

Data Engineers often use integers for row counts, retry counts, file sizes, and batch numbers.

## Float

A float is a decimal number.

```python
average_amount = 45.75
```

Floats are often used for measurements, amounts, percentages, and durations.

## Negative Numbers

```python
adjustment = -5
```

Negative numbers may represent corrections, differences, or offsets.

## Zero

```python
failed_rows = 0
```

Zero is a real numeric value. It is not the same as `None`.

## Integer Versus Float

```python
whole_number = 100
decimal_number = 100.0

print(type(whole_number))
print(type(decimal_number))
```

`100` is an `int`. `100.0` is a `float`.

## Basic Arithmetic for Type Awareness

```python
total = 100 + 50
average = 150 / 2

print(type(total))
print(type(average))
```

In Python 3, `/` produces a `float`, even when the result looks like a whole number.

## Precision Awareness

Floating-point representation has limitations. For beginner work, it is enough to know that decimal values need care. Financial precision needs deliberate choices, and `decimal` is future scope.

## Data Engineering Examples

| Value | Example type | Why |
|---|---|---|
| row count | `int` | rows are counted as whole numbers |
| file size bytes | `int` | bytes are whole units |
| order amount | `float` | can contain decimal values |
| conversion rate | `float` | percentage or ratio |
| duration seconds | `float` | may include decimals |
