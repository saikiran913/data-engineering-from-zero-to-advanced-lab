# Glossary

| Term | Simple meaning | Beginner example |
|---|---|---|
| Argument | Value passed to a function | `"READY"` |
| Caller | Code that calls a function | `validate_status("READY")` |
| Composition | Connecting functions | normalize then validate |
| Default parameter | Parameter with fallback value | `review_limit=5` |
| Deterministic | Same input gives same output | normalize status |
| Docstring | Function documentation string | `"""Validate count."""` |
| Function | Named reusable logic | `def greet():` |
| Function body | Indented code inside function | body under `def` |
| Function call | Running a function | `greet()` |
| Function definition | Creating a function | `def name():` |
| Function interface | Inputs, output, side effects | function contract |
| Function name | Name used to call function | `normalize_status` |
| Function signature | Function name and parameters | `def f(value):` |
| Global scope | Module-level name area | value outside function |
| Implicit None | Return when no `return` exists | print-only function |
| Keyword argument | Argument by parameter name | `error_count=3` |
| Local scope | Inside a function | local variable |
| Local variable | Variable created in function | `local_total` |
| Module-level variable concept | Value defined outside functions | `default_status` |
| Orchestration | Coordinating steps | `main()` calls functions |
| Parameter | Input name in definition | `status` |
| Positional argument | Argument matched by order | `calculate(1, 2)` |
| Pure function | No hidden external changes | normalize text |
| Return | Send value back | `return result` |
| Return value | Value received by caller | `result` |
| Reusable logic | Logic packaged once | validation function |
| Scope | Where a name is available | local/global |
| Side effect | External action | `print()` |
| Transformation | Change raw to clean | strip and uppercase |
| Validation function | Function checking a rule | `validate_status` |
| Variable shadowing | Local name hides outer name | local `status` |
