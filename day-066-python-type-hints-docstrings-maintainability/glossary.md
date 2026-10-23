# Glossary

| Term | Simple meaning | Example |
|---|---|---|
| Annotation | Type information written beside a name | `amount: float` |
| Argument | Value passed to a function | `parse_amount("12")` |
| Business validation | Check against a domain rule | Amount is nonnegative |
| Comment | Note about a nearby code decision | Explain an unusual threshold |
| Configuration | Values controlling behaviour | Allowed statuses |
| Dataclass | Class with generated record methods | `@dataclass` |
| Docstring | Triple-quoted purpose and contract text | `"""Parse an amount."""` |
| Function contract | Agreed inputs, outputs, errors, and side effects | Parser returns float or None |
| Input type | Intended kind of parameter value | `raw_status: str` |
| Maintainability | Ease of understanding and changing code safely | Focused functions |
| Module docstring | Documentation at the top of a Python module | `"""Order helpers."""` |
| Naming convention | Consistent naming practice | `minimum_amount` |
| Optional value | Value that may be absent | `str | None` |
| Parameter | Named function input | `raw_amount` |
| PEP 257 | Python docstring guidance | Concise purpose line |
| PEP 8 | General Python style guidance | Four-space indentation |
| Return type | Intended type after `->` | `-> bool` |
| Runtime check | Code inspecting an actual value | `isinstance(value, str)` |
| Side effect | Observable action besides returning | Printing |
| Static type checker | Tool using hints to flag likely mismatches | Optional editor check |
| Type hint | Annotation describing intended shape | `list[str]` |
| Type safety | Reducing mismatches between intended and actual values | Validate parsed amount |
| TypedDict | Static hint for named dictionary keys | `class RawOrder(TypedDict)` |
| Validation | Checking structure or rule | Required ID present |
