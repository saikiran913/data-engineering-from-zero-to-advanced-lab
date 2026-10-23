# Day 064 — Python Iterators and Generators: Memory-Aware Record Processing

Day 053 introduced loops, Days 055 and 056 introduced sequences and collections, Day 062 built reusable functions, and Day 063 transformed collections eagerly. Day 064 shows how to request and process one record at a time.

## Learning Objectives

Explain iterables and iterators; use `iter()` and `next()` safely; write bounded generator functions with `yield`; recognise generator expressions; build focused lazy stages; diagnose exhaustion; and choose deliberately between a generator and a list.

## Why This Matters

Data pipelines may receive many records. When each record can be handled independently, a generator can avoid building a separate full list after every transformation. The benefit depends on the source and consumer: an existing full list already occupies memory, and sorting or repeated passes may still require materialising values.

## Warnings

> Generators are usually consumed once. After an iterator is exhausted, calling `next()` again does not restart it.

> Lazy processing reduces the need to hold every transformed record in memory, but it does not automatically make code faster or better. Use it when the data-flow semantics justify it.

> Generator pipelines can be harder to debug because values are produced only when requested. Keep each stage small and inspect intermediate outputs when troubleshooting.

> Do not convert a generator to `list(...)` unless you intentionally want to materialise all remaining values in memory.

## Learning Order

1. Read [notes.md](notes.md), [iterable-vs-iterator.md](iterable-vs-iterator.md), and [iter-and-next.md](iter-and-next.md).
2. Study generator functions, generator expressions, and eager versus lazy processing.
3. Work through generator pipeline patterns and memory-aware record processing.
4. Run scripts `01` through `06` in order.
5. Complete the [practice lab](practice-lab.md) and [practice questions](practice-questions.md).

## File Overview

| Topic | Files |
|---|---|
| Foundations | [iterable vs iterator](iterable-vs-iterator.md), [iter and next](iter-and-next.md), [generator functions](generator-functions.md), [generator expressions](generator-expressions.md) |
| Pipeline decisions | [eager vs lazy](eager-vs-lazy-processing.md), [pipeline patterns](generator-pipeline-patterns.md), [memory-aware records](memory-aware-record-processing.md), [when to use generators](when-to-use-generators.md) |
| Revision | [exhaustion and debugging](generator-exhaustion-and-debugging.md), [cheatsheet](python-generators-cheatsheet.md), [mistakes](common-mistakes.md), [examples](real-world-examples.md), [summary](beginner-summary.md), [glossary](glossary.md), [questions](practice-questions.md), [lab](practice-lab.md), [troubleshooting](troubleshooting-guide.md) |

All runnable examples use Python 3 and the standard library. They use bounded synthetic values in memory.

## Navigation

- Previous Day: [Day 063 — Python Comprehensions, Sorting, and Data Transformation Patterns](../day-063-python-comprehensions-sorting-transformations/)
- Next Day: [Day 065 — Python Classes and Dataclasses: Data Records, Configuration, and Pipeline Components](../day-065-python-classes-dataclasses/)
- [Back to Main Learning Path](../README.md)
