# Python Reliability Cheatsheet

```python
try:
    value = int(raw_value)
except ValueError:
    value = None
else:
    print("Valid")

if __name__ == "__main__":
    main()
```

Validate known rules first. Catch narrow, specific exceptions. Use functions for reuse, modules for organisation, packages for related modules, and `main()` for orchestration.
