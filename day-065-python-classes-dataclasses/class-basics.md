# Class Basics

```python
class DataSource:
    def __init__(self, name, format_name):
        self.name = name
        self.format_name = format_name

source = DataSource("orders", "csv")
```

`class` defines the blueprint. Calling `DataSource(...)` creates an **instance** (object). `__init__` initializes it; `self` refers to that particular instance. `name` and `format_name` are its attributes. Two instances can hold different values without sharing those attributes.

| # | Concept check | Answer |
|---|---|---|
| 1 | What is `DataSource`? | A class. |
| 2 | What is `source`? | An instance. |
| 3 | What is `__init__`? | Initializer called during construction. |
| 4 | What is `self`? | The current instance. |
| 5 | What is `source.name`? | An instance attribute. |
| 6 | How many instances can one class create? | Many. |
| 7 | Can two sources have different names? | Yes. |
| 8 | What does `DataSource("events", "json")` create? | Another instance. |
| 9 | What happens if a required argument is omitted? | `TypeError`. |
| 10 | Does defining a class create a source instance? | No; call it to create one. |

Class names conventionally use `CapitalizedWords`. Use plain functions and dictionaries when an object would add ceremony without clarifying the data flow.
