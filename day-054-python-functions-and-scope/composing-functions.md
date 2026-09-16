# Composing Functions

Composition means connecting small functions into a larger workflow.

```python
raw_status = " ready "

clean_status = normalize_status(raw_status)
validation_result = validate_status(clean_status)
```

Mental model:

```text
raw input
→ normalize
→ validate
→ classify
```

## Composition Benefits

- small focused functions
- clear steps
- easier debugging
- easier reuse

## Orchestration Layer

```python
def main():
    raw_status = " ready "
    clean_status = normalize_status(raw_status)
    result = validate_status(clean_status)

    print(clean_status)
    print(result)
```

The `main()` function coordinates work. It calls smaller functions and displays results.

## Keep It Beginner-Friendly

This is not advanced functional programming. It is a simple way to connect clear transformation and validation steps.
