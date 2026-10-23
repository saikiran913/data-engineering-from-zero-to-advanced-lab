# Troubleshooting Guide

```text
1. inspect class definition
2. inspect __init__ parameters
3. inspect instance attributes
4. inspect method responsibility
5. check mutable defaults
6. check whether state mutation is intentional
7. compare with simpler dict/function design
8. use composition before inheritance
```

| Symptom | Likely cause | Response |
|---|---|---|
| `TypeError` missing constructor argument | Required value omitted | Match `__init__` or dataclass fields |
| `AttributeError` | Name differs or attribute was never set | Inspect `self` assignments |
| Forgot `self` | Method signature missing current instance | Add `self` as first parameter |
| Attribute changed unexpectedly | Method or caller mutated state | Locate write and decide whether it belongs |
| List shared across instances | Mutable default or shared class attribute | Use instance field with `default_factory` |
| Dataclass accepts wrong runtime type | Annotation is documentation, not a check | Add explicit type/business validation |
| Frozen dataclass cannot be modified | Field reassignment is blocked | Create a new config instance when rules change |
| Method returns unexpected result | Branches use inconsistent returns | Define one return contract |
| Too much logic inside `__init__` | Constructor mixes setup and processing | Move work to focused method or function |
| Class feels harder than dict/function | Abstraction may be unnecessary | Choose simpler representation |
| Circular import between modules | Components depend on each other both ways | Keep dependencies one-way |
| Inheritance confusion | Behaviour hidden across parent classes | Use small composed components |
