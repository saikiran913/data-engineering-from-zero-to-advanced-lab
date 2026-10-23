# Sorting Basics

`sorted(values)` returns a new list. `values.sort()` changes the original list in place and returns `None`.

```python
amounts = [30, 5, 12]
ordered = sorted(amounts)                  # [5, 12, 30]
descending = sorted(amounts, reverse=True) # [30, 12, 5]
print(amounts)                             # [30, 5, 12]

amounts.sort()                             # amounts is now [5, 12, 30]
```

Strings sort alphabetically according to their characters. Numeric strings are not numbers: `sorted(['10', '2'])` gives `['10', '2']`. Convert them to numbers first when numeric order is required. Avoid sorting a mixture of strings, numbers, and `None` without a defined conversion rule.

Use `sorted()` when raw input order must remain available for traceability. Use `.sort()` when mutating a working list is deliberate and no other stage needs its original order.
