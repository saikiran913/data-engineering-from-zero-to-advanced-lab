# Classes vs Functions vs Dictionaries

| Need | Good beginner choice |
|---|---|
| Simple named record | Dictionary or dataclass |
| Simple transformation | Function |
| Related state and behaviour | Class |
| Fixed configuration record | Frozen dataclass |
| Small one-off values | Dictionary |
| Reusable configured processor | Class |

Use a dictionary when fields are flexible and no behaviour is needed. Use a function for stateless transformation or validation. Use a dataclass when a record or configuration has a stable shape that benefits from named attributes and representation. Use a class when behaviour repeatedly uses configuration or state held by the instance.

An object adds construction and interfaces. Choose it when those additions clarify the workflow. A tiny rule such as `normalize_status(text)` should remain a function unless it genuinely depends on stored configuration.
