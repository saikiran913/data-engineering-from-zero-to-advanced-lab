# Clear Function Interfaces

A function interface is the contract between caller and function.

For every function define:

1. name
2. inputs
3. expected types conceptually
4. missing-value rule
5. output
6. side effects
7. business purpose

| Function | Inputs | Output | Side effects |
|---|---|---|---|
| `normalize_status` | status text | normalized text | none |
| `validate_record_count` | int/None | validation status | none |
| `calculate_completeness` | counts | float/None | none |

## Interface Clarity

Bad:

```python
def process(x):
    return x
```

Better:

```python
def calculate_completeness(valid_count, total_count):
    return (valid_count / total_count) * 100
```

## Return Consistency

Return the same kind of value from each branch whenever possible.

## Avoid Hidden Globals

Pass required values as parameters.

## Avoid Surprising Mutations

Do not change input values unexpectedly.

## Keep Functions Small

Small functions are easier to read and test.

## Docstrings as Interface Documentation

A docstring can explain what the function expects and returns.
