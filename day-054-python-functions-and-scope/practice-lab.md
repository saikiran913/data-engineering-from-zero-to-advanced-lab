# Build Reusable Data Engineering Validation Functions

## Part 1 — Verify Python

```bash
python --version
```

Use the Python 3 command from your own environment.

## Part 2 — Run Function Basics

```bash
python scripts/01_function_basics.py
```

## Part 3 — Run Parameters and Returns

```bash
python scripts/02_parameters_and_returns.py
```

## Part 4 — Run Scope Basics

```bash
python scripts/03_scope_basics.py
```

## Part 5 — Run Validation Functions

```bash
python scripts/04_validation_functions.py
```

## Part 6 — Run Transformation Functions

```bash
python scripts/05_transformation_functions.py
```

## Part 7 — Run Full Function Workflow

```bash
python scripts/06_data_engineering_function_workflow.py
```

## Part 8 — REPL Function

```python
def classify_row_count(row_count):
    if row_count == 0:
        return "FAIL"
    return "PASS"
```

## Part 9 — Call with 0 and 100

```python
classify_row_count(0)
classify_row_count(100)
```

## Part 10 — Add None Handling

Add:

```python
if row_count is None:
    return "REVIEW"
```

## Part 11 — Create Normalize Function

```python
def normalize_status(status):
    return status.strip().upper()
```

## Part 12 — Compose Normalize and Validate

Normalize a raw status, then pass the clean status into a validation function.

## Part 13 — Return Versus Print Experiment

Create one function that prints a value and one function that returns a value. Compare what the caller receives.

## Part 14 — Scope Experiment

Create the same variable name inside and outside a function and observe behaviour.

## Part 15 — Build Completeness Function

Create a function that returns `None` when total count is zero, otherwise returns a percentage.

## Lab Checklist

- can define function
- can call function
- understands parameters and arguments
- understands return
- understands local scope
- understands hidden-global risk
- can create validation function
- can create transformation function
- can compose functions
