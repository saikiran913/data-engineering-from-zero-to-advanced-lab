# Day 065 — Python Classes and Dataclasses: Data Records, Configuration, and Pipeline Components

Day 051 introduced values and types, Day 054 functions, Day 056 dictionary records, Day 060 modules, Day 062 reusable pipeline logic, and Day 064 one-record-at-a-time processing. This lesson introduces objects where a stable record shape or related state and behaviour becomes clearer.

## Learning Objectives

Define classes and instances; use `__init__`, `self`, attributes, and methods; model a record with a class or dataclass; choose safe defaults; hold stable configuration in a frozen dataclass; and combine small components without a class hierarchy.

## Why Data Engineers Use These Models

Source records and validation settings often have a known shape. A dataclass can document that shape concisely, while a configured component can keep a rule and its behaviour together. Plain dictionaries and functions remain useful when a small task does not need persistent object state.

## Warnings

> Use classes when state and behaviour genuinely belong together. Do not convert every function or dictionary into a class simply because object-oriented syntax is available.

> Dataclasses reduce boilerplate for record-like objects, but they do not automatically validate business rules. Validation still needs explicit logic.

> Avoid mutable default values such as `[]` or `{}` directly in dataclass fields. Use `field(default_factory=...)` when each instance needs its own mutable collection.

> Prefer simple composition over deep inheritance for beginner Data Engineering components. Small focused objects are easier to understand, test, and reuse.

## Learning Order

1. Read [notes.md](notes.md), [class-basics.md](class-basics.md), and [attributes-and-methods.md](attributes-and-methods.md).
2. Compare record classes, dataclasses, and safe defaults.
3. Study configuration objects, pipeline components, and composition.
4. Run scripts `01` through `06` in order.
5. Complete the [practice lab](practice-lab.md) and [practice questions](practice-questions.md).

## File Overview

| Topic | Files |
|---|---|
| Class foundations | [classes](class-basics.md), [attributes and methods](attributes-and-methods.md), [record classes](modelling-records-with-classes.md) |
| Record models | [dataclass basics](dataclass-basics.md), [defaults and safety](dataclass-defaults-and-safety.md), [configuration](configuration-objects.md) |
| Design decisions | [components](pipeline-component-classes.md), [composition](composition-vs-inheritance.md), [choice guide](classes-vs-functions-vs-dictionaries.md) |
| Revision | [cheatsheet](python-classes-dataclasses-cheatsheet.md), [mistakes](common-mistakes.md), [examples](real-world-examples.md), [summary](beginner-summary.md), [glossary](glossary.md), [questions](practice-questions.md), [lab](practice-lab.md), [troubleshooting](troubleshooting-guide.md) |

All scripts use synthetic in-memory records and only the Python standard library.

## Navigation

- Previous Day: [Day 064 — Python Iterators and Generators](../day-064-python-iterators-generators/)
- Next Day: [Day 066 — Python Type Hints, Docstrings, and Maintainable Data Engineering Code](../day-066-python-type-hints-docstrings-maintainability/)
- [Back to Main Learning Path](../README.md)
