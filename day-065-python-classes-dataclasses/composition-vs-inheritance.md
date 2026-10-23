# Composition vs Inheritance

```text
RecordProcessor
├── StatusNormalizer
└── RecordValidator
```

**Composition** means one object uses other focused objects. **Inheritance** means one class extends another. A beginner record processor usually needs the first relationship:

```python
class RecordProcessor:
    def __init__(self, normalizer, validator):
        self.normalizer = normalizer
        self.validator = validator

    def process(self, raw_record):
        status = self.normalizer.normalize(raw_record["status"])
        return self.validator.validate(status, raw_record["amount"])
```

Each collaborator has one responsibility. You can inspect or test them separately. Deep inheritance can make it hard to trace which class supplies a rule; Day 065 does not need an inheritance hierarchy.
