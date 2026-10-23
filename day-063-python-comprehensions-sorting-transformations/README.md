# Day 063 — Python Comprehensions, Sorting, and Data Transformation Patterns

Day 053 introduced loops, Day 055 lists and tuples, Day 056 dictionaries and sets, Day 057 string cleaning, and Day 062 reusable pipeline functions. This lesson uses those skills to transform and order collections of records.

## Learning Objectives

By the end of this day, you can build readable list, dictionary, and set comprehensions; filter and project records; choose between `sorted()` and `.sort()`; sort dictionaries using a key; handle missing sort values; and arrange simple transformations into a reviewable pipeline.

## Why Data Engineers Use These Patterns

Incoming records often need consistent labels, selected columns, a sensible order, and checks before the next pipeline stage. Small collection transformations make these steps concise. For complicated business decisions, a named function and loop make the decisions easier to inspect.

## Warnings

> Comprehensions are useful when the transformation is simple and readable. If the logic contains several conditions or business rules, a normal loop is usually clearer.

> `sorted()` returns a new list, while `.sort()` changes the existing list in place. Choose deliberately when raw input order must be preserved.

> Sorting records requires a clear contract for missing or `None` values. Do not rely on mixed incomparable types.

> Compact code is not automatically better code. Data Engineering transformations should prioritise correctness, clarity, and reviewability over clever one-liners.

## Learning Order

1. Read [notes.md](notes.md) and the three comprehension guides.
2. Read [sorting-basics.md](sorting-basics.md) and [sorting-records.md](sorting-records.md).
3. Study [transformation-patterns.md](transformation-patterns.md) and the workflow examples.
4. Run scripts `01` through `06`, then complete [practice-lab.md](practice-lab.md).
5. Use the cheatsheet, glossary, questions, and troubleshooting guide for revision.

## File Overview

| Topic | Files |
|---|---|
| Comprehensions | [list](list-comprehensions.md), [filtered](filtered-comprehensions.md), [dictionary and set](dictionary-and-set-comprehensions.md) |
| Ordering | [sorting basics](sorting-basics.md), [sorting records](sorting-records.md) |
| Pipeline design | [patterns](transformation-patterns.md), [readability](readable-vs-clever-transformations.md), [examples](pipeline-transformation-examples.md) |
| Revision and practice | [cheatsheet](python-transformation-cheatsheet.md), [common mistakes](common-mistakes.md), [real-world examples](real-world-examples.md), [summary](beginner-summary.md), [glossary](glossary.md), [questions](practice-questions.md), [lab](practice-lab.md), [troubleshooting](troubleshooting-guide.md) |

All examples use Python 3 and its standard library. The scripts use synthetic values in memory.

## Navigation

- Previous Day: [Day 062 — Python Functions for Pipelines](../day-062-python-functions-for-pipelines/)
- Next Day: [Day 064 — Python Iterators and Generators: Memory-Aware Record Processing](../day-064-python-iterators-generators/)
- [Back to Main Learning Path](../README.md)
