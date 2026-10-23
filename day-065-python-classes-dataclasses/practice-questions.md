# Practice Questions

Answer each section before reading the key. Use only small synthetic in-memory examples.

## Section 1: Concepts (32)

1. What is a class?
2. What is an object?
3. What is an instance?
4. What is an attribute?
5. What is a method?
6. What does `__init__` do?
7. What does `self` refer to?
8. When does the initializer run?
9. Can two instances have independent `name` values?
10. What convention is used for class names?
11. When is a dictionary a good record model?
12. When is a dataclass a good record model?
13. What does `@dataclass` generate?
14. What does a generated representation help with?
15. How do dataclasses compare equality by default?
16. Do type annotations enforce runtime types automatically?
17. Do dataclasses validate business rules automatically?
18. What is a default value?
19. Why is `tags=[]` unsafe as a dataclass field?
20. What does `field(default_factory=list)` do?
21. What does `frozen=True` prevent?
22. Does freezing recursively freeze a nested list?
23. Why might a tuple be used for allowed statuses?
24. When is a function simpler than a class?
25. When is a configured component class useful?
26. What is composition?
27. What is inheritance conceptually?
28. Why avoid deep inheritance in this lesson?
29. Why should constructor work stay focused?
30. Why avoid hidden global configuration?
31. What does `asdict()` provide conceptually?
32. What is the main decision rule for choosing an abstraction?

## Section 2: Classes and Instances (14)

1. Define a `DataSource` class with `name` and `format_name`.
2. Create an `orders` instance for CSV data.
3. Create an `events` instance for JSON data.
4. Read `orders.name`.
5. Change `orders.name` without changing `events.name`.
6. Explain why `DataSource` itself is not an order source instance.
7. What error occurs when a required constructor argument is omitted?
8. Where should per-instance attributes normally be assigned?
9. What does `self.name = name` mean?
10. Can one class create many source objects?
11. Should a source class store every unrelated pipeline rule?
12. What is a useful class name for a record with order fields?
13. Which value is `self` when calling `orders.is_active()`?
14. Why might a plain dictionary still be preferable for one source?

## Section 3: Attributes and Methods (14)

1. Write `is_active(self)` returning `self.enabled`.
2. Add a focused `disable(self)` method.
3. Name the attribute in `source.name`.
4. Name the method in `source.is_active()`.
5. Does Python pass the instance to `self` on a normal method call?
6. What happens if a method definition forgets `self`?
7. Why should a method not change an unrelated object's state?
8. Why is `get_status()` misleading if it also writes a file?
9. When may a method intentionally mutate its own state?
10. How can a method expose a computed answer without mutation?
11. What is the difference between `self.enabled` and a local `enabled`?
12. What happens if code reads an attribute never set?
13. Why keep methods small?
14. When should a simple method become a standalone function?

## Section 4: Dataclasses (16)

1. Import `dataclass` from the standard library.
2. Define an `OrderRecord` with ID, status, and amount fields.
3. Create one `OrderRecord` instance using keyword arguments.
4. What initializer is supplied automatically?
5. What representation is supplied automatically?
6. When do two default dataclass instances compare equal?
7. Does `amount: float` reject `"bad"` at construction?
8. Where should a nonnegative amount rule be checked?
9. Why is a dataclass concise for stable records?
10. When is a dictionary more flexible?
11. What does `asdict(record)` return?
12. Can a dataclass include a focused method?
13. What does `enabled: bool = True` mean?
14. When would a frozen dataclass suit configuration?
15. Can a frozen dataclass field be reassigned normally?
16. Are type annotations useful even without runtime checking?

## Section 5: Mutable Defaults (14)

1. What is wrong with `tags: list = []` in a dataclass?
2. Write a safe list field default.
3. Write a safe dictionary field default.
4. Why should each source config own its own tags list?
5. What is called by `default_factory=list`?
6. Does the factory run for each new instance needing a default?
7. Is `minimum_amount: float = 0.0` a mutable-default problem?
8. Is a tuple of allowed statuses a useful frozen field?
9. Does `frozen=True` protect an inner list's contents?
10. What test proves two instances have independent lists?
11. Why can a shared class attribute list surprise callers?
12. What happens if the same external list is passed into two objects?
13. What should be used when an empty set is needed per instance?
14. Why prefer an immutable tuple for fixed statuses?

## Section 6: Choose Dict, Function, Dataclass, or Class (16)

1. A one-off flexible metadata record.
2. A stable order ID/status/amount record used in many steps.
3. A stateless string-trimming rule.
4. A normalizer that reuses an allowed-status set across calls.
5. A fixed validation threshold and status tuple.
6. A tiny one-time source description with changing keys.
7. A function that adds tax to one numeric value.
8. A processor with a validator and normalizer.
9. A small fixed website-event record.
10. Dynamic event properties with different keys per event.
11. A repeated classification rule with stored configuration.
12. A one-line Boolean check without state.
13. An independent source's enabled flag plus related methods.
14. A group of immutable reporting settings.
15. A raw source row before its schema has been checked.
16. A cleaned stable output record after validation.

## Section 7: Composition or Inheritance? (12)

1. Processor uses a normalizer object.
2. Processor uses a validator object.
3. Create five subclasses only to change allowed statuses.
4. Pass a configuration object to the validator.
5. Put normalization and validation into one huge base class.
6. Test the normalizer without constructing the processor.
7. Replace one validator while retaining the processor.
8. A child class depends on hidden parent attributes.
9. Compose two focused objects with explicit constructor arguments.
10. Extend a parent class for no additional behaviour.
11. Keep status normalization as a stateless function when no state is needed.
12. Explain the beginner rule of thumb for these pipeline components.

## Integrated Mini Case

A pipeline receives raw order dictionaries with `order_id`, `status`, and `amount`. It has a fixed allowed-status list and minimum amount. Design a record dataclass, a frozen validation configuration, a status normalizer component, and a validator. Classify records as PASS, REVIEW, or FAIL. Identify any stateless logic that can remain a function. Create two record instances, use composition for a processor, explain why inheritance is unnecessary, and explain why dataclass field annotations do not validate runtime values. Preserve a simple design and safe defaults.

## Answer Key

### Section 1

1. Blueprint for objects. 2. A created class value. 3. An object of a class. 4. Value on an object. 5. Function on a class. 6. Initializes instance state. 7. Current instance. 8. During object construction. 9. Yes. 10. `CapitalizedWords`. 11. Flexible or one-off fields. 12. Stable named fields. 13. Initializer, representation, equality by default. 14. Easier inspection. 15. Corresponding field values. 16. No. 17. No. 18. Value used when omitted. 19. Mutable collections need per-instance creation; dataclasses reject common mutable defaults. 20. Creates a fresh list when needed. 21. Field reassignment. 22. No. 23. Fixed immutable values. 24. Stateless behaviour. 25. Behaviour reuses stored configuration. 26. Object uses other objects. 27. Class extends another. 28. Rule location becomes hard to trace. 29. Creation should not hide a workflow. 30. Dependencies should be visible. 31. New dictionary of field values. 32. Use the simplest form that clarifies data and behaviour.

### Section 2

1. `class DataSource:` with `__init__(self, name, format_name)` assigning both to `self`.
2. `orders = DataSource('orders', 'csv')`.
3. `events = DataSource('events', 'json')`.
4. `orders.name` is `'orders'`.
5. `orders.name = 'daily_orders'` leaves `events.name` unchanged.
6. It is the blueprint, not a constructed instance.
7. `TypeError`.
8. In `__init__` on `self`.
9. Store the passed `name` on the current instance.
10. Yes.
11. No; keep responsibilities focused.
12. `OrderRecord`.
13. The `orders` instance.
14. It needs fewer lines and suits a flexible one-off shape.

### Section 3

1. `def is_active(self): return self.enabled`.
2. `def disable(self): self.enabled = False`.
3. `name`.
4. `is_active`.
5. Yes.
6. The call has an argument mismatch, normally `TypeError`.
7. Side effects become surprising.
8. Name suggests reading state, while writing changes storage.
9. When the object's documented purpose includes that update.
10. Return the computed value.
11. `self.enabled` persists on the instance; local `enabled` exists only during the call.
12. `AttributeError`.
13. Focused methods are easier to test and trace.
14. When it depends only on explicit parameters, not persistent instance state.

### Section 4

1. `from dataclasses import dataclass`.
2. `@dataclass` above `class OrderRecord:` with `order_id: str`, `status: str`, `amount: float`.
3. `OrderRecord(order_id='ORD-1', status='READY', amount=10.0)`.
4. An `__init__` accepting the declared fields.
5. Readable field-based `repr`.
6. Their corresponding fields have equal values.
7. No; annotations do not enforce types by themselves.
8. In an explicit validator or deliberate construction check.
9. The decorator supplies routine methods.
10. When keys are flexible or sparse.
11. A new dictionary with dataclass field values.
12. Yes.
13. `enabled` defaults to `True` when omitted.
14. When settings should remain stable during processing.
15. No; reassignment raises a frozen-instance error.
16. Yes; they document expected fields and types.

### Section 5

1. A mutable field needs a fresh list per instance; the direct default is unsafe.
2. `tags: list[str] = field(default_factory=list)`.
3. `metadata: dict = field(default_factory=dict)`.
4. A tag added to one source must not appear on another.
5. The `list` callable, creating an empty list.
6. Yes.
7. No; a float is not mutable.
8. Yes.
9. No; frozen is shallow.
10. Append to `first.tags`, then check `second.tags == []` and `first.tags is not second.tags`.
11. The list can be shared by every instance.
12. They can still share that supplied list; copy it if independent ownership is required.
13. `field(default_factory=set)`.
14. It communicates fixed values and avoids accidental mutation.

### Section 6

1. Dictionary; flexible keys.
2. Dataclass; stable named fields.
3. Function; stateless.
4. Class; stored configuration supports reusable methods.
5. Frozen dataclass; stable grouped settings.
6. Dictionary; changing keys.
7. Function; one stateless calculation.
8. Small class using composition; collaborators own focused rules.
9. Dataclass; stable event schema.
10. Dictionary; dynamic fields.
11. Class; configuration is reused.
12. Function; no state.
13. Class; instance state and related methods.
14. Frozen dataclass; stable settings.
15. Dictionary; inspect raw schema first.
16. Dataclass; validated stable output shape.

### Section 7

1. Composition. 2. Composition. 3. Avoid inheritance; pass configuration. 4. Composition or explicit dependency. 5. Split focused components. 6. Composition makes direct tests possible. 7. Composition permits replacement through a clear interface. 8. Fragile inheritance; remove hidden parent dependency. 9. Composition. 10. Unnecessary inheritance. 11. Use a function. 12. Prefer small focused collaborators; add a class only when state and behaviour belong together.

### Integrated Mini Case

```python
from dataclasses import dataclass

@dataclass(frozen=True)
class ValidationConfig:
    allowed_statuses: tuple[str, ...]
    minimum_amount: float = 0.0

@dataclass
class OrderRecord:
    order_id: str
    status: str
    amount: float

class StatusNormalizer:
    def normalize(self, status):
        return status.strip().upper()

class RecordValidator:
    def __init__(self, config):
        self.config = config

    def classify(self, record):
        if not record.order_id or record.amount < self.config.minimum_amount:
            return 'FAIL'
        if record.status not in self.config.allowed_statuses:
            return 'REVIEW'
        return 'PASS'

class RecordProcessor:
    def __init__(self, normalizer, validator):
        self.normalizer = normalizer
        self.validator = validator

    def process(self, raw):
        record = OrderRecord(
            raw['order_id'].strip(),
            self.normalizer.normalize(raw['status']),
            raw['amount'],
        )
        return record, self.validator.classify(record)

config = ValidationConfig(('READY', 'COMPLETED'))
processor = RecordProcessor(StatusNormalizer(), RecordValidator(config))
first = {'order_id': 'A-1', 'status': ' ready ', 'amount': 10.0}
second = {'order_id': 'B-2', 'status': ' unknown ', 'amount': 5.0}
assert processor.process(first)[1] == 'PASS'
assert processor.process(second)[1] == 'REVIEW'
```

The normalizer method above is stateless and could be a plain function. It is kept as a component only to demonstrate composition; a production version should choose the simpler function unless the normalizer gains real configuration. A tuple avoids a mutable default. No inheritance is needed because the processor uses collaborators directly. `amount: float` documents an intended type but does not reject invalid runtime values; explicit parsing or validation is still required. The raw dictionaries remain unchanged.
