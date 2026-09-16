# Strings

## String Literals

A string is text.

```python
source_name = "orders"
table_name = 'daily_orders'
```

Single and double quotes both create strings. Choose one style and stay consistent.

## Empty String

```python
value = ""
```

An empty string is text with no characters. It is not the same as `None`.

## Whitespace String

```python
value = " "
```

A whitespace string contains a space. It can look empty on screen but still has content.

## Numeric String

```python
record_count_text = "100"
record_count = 100
```

`"100"` is text. `100` is an integer. A value that looks numeric is not automatically a number.

## String Concatenation Concept

```python
source = "daily"
name = source + "_orders"
```

This joins text together. It does not do numeric addition.

## F-String Introduction

```python
source_name = "orders"
print(f"Source: {source_name}")
```

An f-string helps place variable values inside text.

## Data Engineering Examples

Strings are common for filenames, table names, status codes, country codes, IDs, and raw timestamps. IDs that look numeric may still need to stay strings.

```python
customer_id = "00125"
```

If this becomes an integer, the leading zeros disappear.
