# Attributes and Methods

```python
class DataSource:
    def __init__(self, name, enabled):
        self.name = name
        self.enabled = enabled

    def is_active(self):
        return self.enabled

source = DataSource("orders", True)
print(source.is_active())
```

`name` and `enabled` are instance attributes. `is_active` is an instance method. It receives `self` automatically when called through `source`, so it can read that source's state.

A method can update state when that is part of the object's purpose:

```python
def disable(self):
    self.enabled = False
```

Such a change should be easy to see and document. Prefer a method that returns a result without mutation for ordinary record transformations. Do not let a method update unrelated objects or hide I/O behind a name that sounds like a simple check.
