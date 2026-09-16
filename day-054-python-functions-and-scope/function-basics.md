# Function Basics

## Define

```python
def show_pipeline_name():
    print("daily_orders")
```

`def` starts a function definition.

## Call

```python
show_pipeline_name()
```

A function does not run until it is called.

## Naming

Good names:

- `validate_record_count`
- `normalize_status`
- `calculate_completeness`

Avoid:

- `do_it`
- `thing`
- `func1`

## Function Body

The function body is the indented code inside the function.

## Indentation

```python
def show_source_name():
    print("orders")
```

The body is indented with four spaces.

## One Focused Responsibility

A function should ideally do one focused job. A function that validates, transforms, prints, writes files, and controls workflow is hard to review.

## Docstring Introduction

```python
def validate_record_count(record_count):
    """Classify a record count as PASS, REVIEW, or FAIL."""
```

Triple-quoted docstrings are common in real Python.

## Practice

```python
def show_source_name():
    print("orders")

def show_table_name():
    print("daily_orders")

def show_validation_message():
    print("Validation started")

def show_pipeline_stage():
    print("staging")

def show_record_count(record_count):
    print(record_count)

def show_status(status):
    print(status)

def show_country_code(country_code):
    print(country_code)

def show_file_name(file_name):
    print(file_name)

def show_error_count(error_count):
    print(error_count)

def show_completeness(completeness_pct):
    print(completeness_pct)

def show_outcome(outcome):
    print(outcome)

def show_review_message(message):
    print(message)
```
