# Day 051 — Python Variables and Data Types

Variables, numbers, strings, booleans, `None`, and type awareness are the first building blocks of Python programs.

## Connect to Day 050

Day 050 prepared the Python environment: interpreter, REPL, scripts, executable paths, `pip`, dependencies, virtual environments, and reproducible setup.

Day 051 begins actual Python language fundamentals. Before working with files, records, loops, functions, or data pipelines, learners need to understand how Python stores simple values and how those values have types.

## Learning Objectives

By the end of this day, you should understand:

- what a variable is
- what assignment means
- left side versus right side of assignment
- valid and invalid variable names
- why `snake_case` is common in Python
- descriptive names and reassignment
- dynamic typing and type awareness
- `int`, `float`, `str`, `bool`, `None`, and `NoneType`
- numeric, string, and boolean literals
- empty strings and whitespace strings
- why `"100"` and `100` are different
- why `"False"` and `False` are different
- why `None`, `0`, `False`, and `""` are different
- how to inspect types with `type()`
- simple conversion with `str()`, `int()`, `float()`, and `bool()`
- why conversion can fail
- why missing values need clear business rules
- why type awareness matters in Data Engineering validation

## Why Data Types Matter for Data Engineers

Data pipelines receive values from many places. CSV values often arrive as text. API values may be numbers, booleans, nulls, or strings. Database columns usually have expected types. Numeric strings should not be summed as text, and missing values should not be confused with zero.

Validation rules depend on expected type. A pipeline can fail when a number arrives as text, or worse, produce incorrect logic when types change silently. Data Engineers do not only move data; they protect meaning.

## Required Warnings

> A value that looks numeric is not automatically a number. `"100"` is a string, while `100` is an integer.

> `None`, `0`, `False`, and an empty string represent different states and should not be treated as interchangeable without a clear business rule.

> Type conversion can fail when data is malformed. Validate or handle conversion errors rather than assuming every input can be converted safely.

> Python is dynamically typed, but Data Engineering still requires strong type awareness because incorrect types can silently produce incorrect logic or failed pipelines.

## Recommended Learning Order

1. `notes.md`
2. `variable-basics.md`
3. `numeric-types.md`
4. `strings.md`
5. `booleans.md`
6. `none-and-missing-values.md`
7. `type-awareness.md`
8. `type-conversion.md`
9. `data-engineering-type-scenarios.md`
10. inspect `scripts/`
11. complete `practice-lab.md`
12. use `troubleshooting-guide.md`
13. review `python-types-cheatsheet.md`
14. complete `practice-questions.md`
15. read `beginner-summary.md`
16. read `glossary.md`

## Main Concepts

| Concept | Simple meaning |
|---|---|
| Variable | A name that refers to a value |
| Assignment | Giving a value to a variable with `=` |
| Identifier | A valid Python name |
| Value | The actual thing stored or referenced |
| Type | The kind of value Python sees |
| Integer | Whole number, such as `100` |
| Float | Decimal number, such as `42.75` |
| String | Text, such as `"orders"` |
| Boolean | `True` or `False` |
| `None` | No-value or missing-state concept |
| Dynamic typing | A variable can later refer to a different type |
| Type conversion | Changing a value from one type to another |
| Numeric string | Text that looks like a number |
| Missing value | A value that is not available or not supplied |

## Safe-Learning Note

The scripts use Python standard library only. No external packages are required. No file, database, or network writes are performed. All examples are small, generic, and educational.

## Navigation

- Previous Day: [Day 050 - Python for Data Engineers](../day-050-python-setup-and-virtual-environments/)
- Next Day: [Day 052 - Python Conditions and Boolean Logic](../day-052-python-conditions-and-boolean-logic/)
- [Back to Main Learning Path](../README.md)
