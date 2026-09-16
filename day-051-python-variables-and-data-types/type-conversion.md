# Type Conversion

Type conversion changes a value from one type to another.

## String to Integer

```python
record_count = int("100")
```

The result is the integer `100`.

## String to Float

```python
amount = float("45.75")
```

The result is the float `45.75`.

## Number to String

```python
label = str(100)
```

The result is the string `"100"`.

## Boolean Conversion

```python
print(bool(""))
print(bool("False"))
```

Generic `bool()` is not a text parser for textual true/false values. `bool("False")` is `True` because the string is non-empty.

## Invalid Conversion

```python
# int("one hundred") raises ValueError.
```

Conversion can fail when the input is malformed. Full error handling is future scope.

## Leading Zeros

```python
int("00125")
```

This becomes `125`. IDs may need to remain strings when leading zeros carry meaning.

## Missing-Value Conversion

```python
# int(None) fails.
```

Check missing values before conversion.

## Safe Conversion Checklist

1. know expected type
2. check missing state
3. validate format
4. convert
5. verify result type
6. preserve business meaning
