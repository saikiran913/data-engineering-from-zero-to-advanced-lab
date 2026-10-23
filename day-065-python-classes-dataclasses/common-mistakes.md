# Common Mistakes

| # | Problem | Why it matters | Safer approach |
|---|---|---|---|
| 1 | Class where a function suffices | Adds needless state and syntax | Use a function for stateless logic |
| 2 | Class where a dictionary suffices | Simple data becomes harder to inspect | Keep one-off record as dictionary |
| 3 | Turning every value into an object | Flow becomes fragmented | Model only useful boundaries |
| 4 | Forgetting `self` | Method call fails | First instance-method parameter is `self` |
| 5 | Wrong attribute name | Raises `AttributeError` | Use consistent field names |
| 6 | Constructor arguments mismatch | Object cannot be created | Match required signature |
| 7 | Confusing class and instance attributes | State may be shared unexpectedly | Set per-instance values in `__init__` |
| 8 | Unexpected state mutation | Later results change | Make updates explicit |
| 9 | Method changes unrelated state | Behaviour is surprising | Keep method responsibility narrow |
| 10 | Giant class with many jobs | Hard to test and trace | Split focused components |
| 11 | Assuming dataclass validates types | Wrong values can enter | Validate explicitly |
| 12 | Mutable default list | Risk of shared state or dataclass error | Use `field(default_factory=list)` |
| 13 | Mutable default dictionary | Risk of shared state or dataclass error | Use `field(default_factory=dict)` |
| 14 | Sharing one list across instances | Changes leak between sources | Give each instance its own list |
| 15 | Treating frozen as deeply immutable | Nested mutable values can change | Prefer immutable field values |
| 16 | Treating annotations as runtime enforcement | Invalid input survives construction | Add validation code |
| 17 | Hiding complex business validation in constructor | Creation has surprising failure paths | Use a documented validator |
| 18 | Constructor performs I/O | Construction becomes hard to test | Separate I/O from model |
| 19 | Class mixes file, network, and database work | Responsibilities blur | Keep component focused |
| 20 | Introducing inheritance without need | Adds indirection | Compose small objects |
| 21 | Deep inheritance tree | Rule location is hard to find | Use simple collaborators |
| 22 | Fragile parent-child dependency | Changes ripple widely | Prefer explicit component interface |
| 23 | Ignoring composition | One giant component grows | Pass focused objects to processor |
| 24 | Dataclass for highly dynamic shape | Fields do not match source variation | Use dictionary for flexible metadata |
| 25 | Converting every dictionary to class | Mapping flexibility is lost | Convert only stable records |
| 26 | Mutating raw source object | Audit evidence changes | Create a clean copy |
| 27 | Mutating config during processing | Rules drift between records | Use stable frozen config |
| 28 | Method returns mixed types | Caller must guess | Keep one return contract |
| 29 | Object stores unrelated configuration | Purpose becomes unclear | Store only rules it uses |
| 30 | Circular module dependency | Imports fail or become confusing | Keep one-way module relationships |
| 31 | Overusing magic methods | Simple model becomes opaque | Use ordinary methods |
| 32 | Adding properties unnecessarily | Hidden getter/setter logic grows | Use plain attributes initially |
| 33 | Adding an external modelling package | Unneeded dependency | Use standard-library dataclasses |
| 34 | Introducing Pydantic too early | Distracts from core Python model | Learn explicit validation first |
| 35 | Introducing ORM concepts too early | Database concerns enter record lesson | Keep in-memory models |
| 36 | No reason for class abstraction | Code gains ceremony without value | Explain required state and behaviour |
| 37 | Inconsistent object fields at construction | Downstream assumptions break | Use stable dataclass schema |
| 38 | Mutable collection shared through config | Supposedly stable rules can change | Use tuple or fresh collection |
