# Beginner Summary

A class is a blueprint, and an object is an instance created from it. `__init__` stores initial state in attributes on `self`, the current instance. Methods are functions attached to the class that can read or deliberately change that state. Two instances normally have independent instance attributes.

Dataclasses are useful for stable record shapes. `@dataclass` creates an initializer, readable representation, and value-based equality by default. Field annotations document expected types, but Python does not automatically enforce them at runtime. A record still needs explicit business validation. A dictionary remains a good choice for flexible source data; a stateless transformation is often best as a function.

Defaults need care. Immutable defaults such as `0.0` are straightforward. For a list or dictionary field, `field(default_factory=list)` or `field(default_factory=dict)` creates a fresh collection per instance. A frozen dataclass can hold stable configuration, especially with immutable field values such as a tuple of allowed statuses. Freezing is shallow, so nested mutable values can still change.

A configured class is useful when related behaviour repeatedly uses the same state. A normalizer and validator can be separate small objects; a processor can compose them. There is no need for a deep inheritance tree. Keep the object model small enough that a learner can follow where a rule lives and how a record moves through it.

```text
Need data only? → dict/dataclass
Need stateless logic? → function
Need configured state + behaviour? → class
```

> Use classes when state and behaviour genuinely belong together. Do not convert every function or dictionary into a class simply because object-oriented syntax is available.

> Dataclasses reduce boilerplate for record-like objects, but they do not automatically validate business rules. Validation still needs explicit logic.

> Avoid mutable default values such as `[]` or `{}` directly in dataclass fields. Use `field(default_factory=...)` when each instance needs its own mutable collection.

> Prefer simple composition over deep inheritance for beginner Data Engineering components. Small focused objects are easier to understand, test, and reuse.

Day 066 will cover Python logging for data pipelines: levels, structured messages, and debugging workflows.
