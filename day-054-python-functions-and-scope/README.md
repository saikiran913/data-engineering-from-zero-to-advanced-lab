# Day 054 — Python Functions and Scope

Reusable logic, parameters, return values, scope, transformations, and clear interfaces help Python code stay understandable.

## Connect to Day 053

Day 053 repeated logic with loops. Day 054 shows how to move repeated logic into reusable functions.

Functions make validation and transformation logic easier to reuse, test, review, and compose. They help turn long scripts into smaller pieces with clear inputs and outputs.

## Learning Objectives

By the end of this day, you should understand:

- what a function is and why functions exist
- `def`, function names, and function bodies
- parameters and arguments
- positional arguments and keyword arguments
- default parameter values conceptually
- function calls
- `return` and return values
- implicit `None` return
- print versus return
- local variables and local scope
- global/module-level scope conceptually
- variable shadowing
- why hidden global dependencies are risky
- function signatures and interfaces
- clear inputs, outputs, and side effects
- focused validation functions
- focused transformation functions
- pure-function thinking and deterministic behaviour
- docstrings
- composing small functions
- separating transformation from orchestration
- why functions help testing, reuse, and review

## Why Functions Matter for Data Engineers

Data Engineers use functions to classify row counts, validate status values, calculate completeness percentages, normalize text values, transform raw values into standardized outputs, reuse the same business rule across many records, separate orchestration from transformation, reduce copy-paste logic, and create clear interfaces between pipeline steps.

## Required Warnings

> A function should have a clear contract: what inputs it expects, what it returns, and what side effects it performs.

> Avoid hidden dependencies on global variables. Functions are easier to understand, reuse, and test when required values are passed explicitly as parameters.

> `print()` displays information, while `return` sends a value back to the caller. Printing is not a substitute for returning reusable results.

> Keep functions focused. Very large functions that validate, transform, log, write files, and control workflow at the same time are difficult to review and debug.

## Recommended Learning Order

1. `notes.md`
2. `function-basics.md`
3. `parameters-and-arguments.md`
4. `return-values.md`
5. `local-and-global-scope.md`
6. `pure-functions-and-side-effects.md`
7. `validation-functions.md`
8. `transformation-functions.md`
9. `clear-function-interfaces.md`
10. `composing-functions.md`
11. inspect `scripts/`
12. complete `practice-lab.md`
13. use `troubleshooting-guide.md`
14. review `python-functions-cheatsheet.md`
15. complete `practice-questions.md`
16. read `beginner-summary.md`
17. read `glossary.md`

## Main Concepts

| Concept | Simple meaning |
|---|---|
| Function | Named reusable block of logic |
| Parameter | Input name in a function definition |
| Argument | Value passed by the caller |
| Return value | Value sent back to the caller |
| Scope | Area where a name is available |
| Local variable | Variable created inside a function |
| Global variable | Module-level value conceptually |
| Pure function | Same input gives same output without hidden changes |
| Side effect | External action such as printing or writing |
| Transformation | Change raw input into clean output |
| Validation | Check a value against a rule |
| Function interface | Function name, inputs, outputs, and side effects |
| Docstring | Short documentation inside a function |
| Composition | Connecting small functions together |

## Safe-Learning Note

Scripts use the Python standard library only. There are no file, network, or database writes. All transformations operate on in-memory hard-coded values. Examples prioritise predictable inputs and outputs.

## Navigation

- Previous Day: [Day 053 - Python Loops](../day-053-python-loops/)
- Next Day: [Day 055 - Python Collections I](../day-055-python-collections-i/)
- [Back to Main Learning Path](../README.md)
