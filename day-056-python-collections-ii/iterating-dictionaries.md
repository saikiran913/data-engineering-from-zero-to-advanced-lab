# Iterating Dictionaries

Looping over a dictionary gives keys by default. Use `.items()` when both the key and value are needed.

```python
for field_name in order:
    print(field_name)

for value in order.values():
    print(value)

for field_name, value in order.items():
    print(field_name, value)
```

`.keys()`, `.values()`, and `.items()` make intent clearer. Python dictionaries preserve insertion order, but business logic should depend on key meaning rather than accidental field order. Do not add or remove dictionary keys while iterating over that same dictionary.

## Practice Examples

1. Loop over keys.
2. Loop over `.keys()`.
3. Loop over `.values()`.
4. Loop over `.items()`.
5. Print each field and value.
6. Count fields.
7. Check one key before lookup.
8. Iterate a configuration dictionary.
9. Explain key/value unpacking.
10. Explain insertion order caution.
11. Avoid resizing during a loop.
12. State when `.items()` is best.
