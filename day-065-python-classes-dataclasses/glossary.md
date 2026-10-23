# Glossary

| Term | Simple meaning | Example |
|---|---|---|
| Attribute | Value stored on an object | `source.name` |
| Behaviour | Action an object can perform | `source.is_active()` |
| Class | Blueprint for instances | `class DataSource:` |
| Class instance | One object created from a class | `DataSource("orders")` |
| Composition | Object uses another focused object | Processor uses validator |
| Configuration object | Related settings held together | `ValidationConfig` |
| Constructor | Call that creates and initializes an object | `DataSource("orders")` |
| Dataclass | Record-oriented class with generated methods | `@dataclass` |
| Default factory | Function called for a fresh default value | `field(default_factory=list)` |
| Field | Named dataclass value | `amount: float` |
| Frozen dataclass | Dataclass whose fields cannot be reassigned | `@dataclass(frozen=True)` |
| Immutable configuration | Settings intended not to change during processing | Frozen config with tuple |
| Inheritance | One class extends another | Not needed in this lesson |
| Instance | Object created from a class | `orders = DataSource(...)` |
| Instance attribute | State belonging to one instance | `orders.enabled` |
| Instance method | Method receiving `self` | `is_active(self)` |
| Method | Function defined in a class | `normalize(self, value)` |
| Mutable default | Shared/changeable default risk | `[]` as default |
| Object | Instance with attributes and methods | `record` |
| Object-oriented programming | Organizing related state and behaviour into objects | Small processor component |
| Pipeline component | Focused processing object | `StatusNormalizer` |
| Record model | Defined shape of a data record | `OrderRecord` |
| Reusable component | Object that can process many inputs | One validator, many orders |
| Self | Name for current instance inside methods | `self.name` |
| State | Values currently held by an object | `enabled=True` |
| Type annotation | Hint documenting intended value type | `amount: float` |
