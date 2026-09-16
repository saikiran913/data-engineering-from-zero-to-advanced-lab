# Variable Basics

## Assignment

Assignment gives a value to a variable name.

```python
source_name = "orders"
record_count = 250
```

## Descriptive Naming

Short names are easy to type but often hard to understand.

Bad:

```python
x = 250
```

Better:

```python
record_count = 250
```

Good names explain business meaning.

## Snake Case

Python commonly uses `snake_case`:

```python
daily_record_count = 250
source_file_name = "orders.csv"
```

Words are lowercase and separated by underscores.

## Reassignment

```python
record_count = 250
record_count = 300
```

The second assignment changes what the name refers to.

## Multiple Variables

Start with separate assignments:

```python
source_name = "orders"
record_count = 250
is_valid = True
```

This is clear for beginners and easy to inspect.

## Constants Conceptually

Python programmers often use uppercase for values they do not intend to change:

```python
MAX_RETRIES = 3
```

Python does not enforce constants. The uppercase style is a convention.

## Reserved Keywords

Some words are reserved by Python. Do not use them as variable names.

```python
# class = "orders"  # invalid
```

## Practice Type Checks

```python
record_count = 250
average_amount = 42.5
source_name = "orders"
file_name = "orders.csv"
country_code = "UK"
order_id = "ORD-001"
is_valid = True
has_errors = False
last_error = None
empty_comment = ""
zero_count = 0
amount_text = "42.5"

print(type(record_count))
print(type(average_amount))
print(type(source_name))
print(type(file_name))
print(type(country_code))
print(type(order_id))
print(type(is_valid))
print(type(has_errors))
print(type(last_error))
print(type(empty_comment))
print(type(zero_count))
print(type(amount_text))
```
