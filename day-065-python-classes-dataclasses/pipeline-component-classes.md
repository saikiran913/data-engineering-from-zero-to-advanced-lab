# Pipeline Component Classes

Store configuration once when several method calls share it:

```python
class StatusNormalizer:
    def __init__(self, allowed_statuses):
        self.allowed_statuses = tuple(allowed_statuses)

    def normalize(self, raw_status):
        return raw_status.strip().upper()

    def is_allowed(self, status):
        return status in self.allowed_statuses
```

The component holds related state and behaviour. It can be reused for many records without storing a separate copy of the allowed values in each call. `normalize` and `is_allowed` remain focused; neither reads files or changes outside state. If there is no lasting configuration or state, two functions may be simpler than a class. Avoid one giant component that parses, validates, logs, writes, and reports everything.
