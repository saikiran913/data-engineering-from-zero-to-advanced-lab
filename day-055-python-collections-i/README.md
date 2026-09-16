# Day 055 — Python Collections I

Lists, tuples, indexing, slicing, record sequences, and ordered data help Python work with multiple related values.

## Connect to Day 054

Day 054 taught reusable functions. Day 055 introduces collections that functions and loops commonly accept and return.

Lists and tuples allow Data Engineers to work with multiple related values in one structure, such as source files, validation results, ordered pipeline steps, and row-like records.

## Learning Objectives

By the end of this day, you should understand:

- collection and sequence concepts
- lists and tuples
- ordered collections
- mutable and immutable values
- zero-based indexing, positive indexing, and negative indexing
- `len()`
- slicing, slice start, slice stop, omitted bounds, and step concept
- why slice stop is excluded
- membership with `in` and `not in`
- iteration over lists and tuples
- empty lists and empty tuples
- single-item tuple syntax
- list mutation with replacement, append, extend, insert, remove, and pop conceptually
- tuple immutability
- tuple unpacking
- nested sequences conceptually
- row-like tuples and record sequences
- why tuple position matters
- why list order matters
- why out-of-range indexing fails
- why indexing before checking length can be unsafe
- why sequence contracts should be documented
- why complex positional records should later move to named structures

## Why Lists and Tuples Matter for Data Engineers

Lists and tuples are useful for a list of source files, table names, validation results, ordered pipeline steps, row-like tuples, schema field positions conceptually, batch labels, records passed into helper functions, and collections iterated in loops.

## Required Warnings

> Python sequences use zero-based indexing. The first item is at index `0`, not index `1`.

> Indexing outside the valid range raises an error. Check sequence length or design inputs carefully before accessing fixed positions.

> Lists are mutable and can be changed after creation. Tuples are immutable, but the objects stored inside them may still be mutable.

> Positional record structures become difficult to understand as they grow. Use clear documentation and move to named structures such as dictionaries when field meaning becomes complex.

## Recommended Learning Order

1. `notes.md`
2. `list-basics.md`
3. `tuple-basics.md`
4. `indexing.md`
5. `slicing.md`
6. `list-mutation.md`
7. `tuple-immutability.md`
8. `iterating-sequences.md`
9. `record-sequences.md`
10. `sequence-design-for-data-engineering.md`
11. inspect `scripts/`
12. complete `practice-lab.md`
13. use `troubleshooting-guide.md`
14. review `python-sequences-cheatsheet.md`
15. complete `practice-questions.md`
16. read `beginner-summary.md`
17. read `glossary.md`

## Main Concepts

| Concept | Simple meaning |
|---|---|
| Collection | One value holding multiple values |
| Sequence | Ordered collection accessed by position |
| List | Mutable sequence written with `[]` |
| Tuple | Immutable sequence written with `()` |
| Index | Position of an item |
| Slice | Range selected from a sequence |
| Mutability | Ability to change after creation |
| Immutability | Cannot be changed after creation |
| Record sequence | Ordered values representing one record |
| Order | Item position matters |
| Position | Where a value appears |
| Membership | Checking whether a value is present |

## Safe-Learning Note

Examples use the Python standard library only. There are no external files, databases, or network calls. All data is hard-coded. Dictionaries and sets are intentionally deferred.

## Navigation

- Previous Day: [Day 054 - Python Functions and Scope](../day-054-python-functions-and-scope/)
- Next Day: [Day 056 - Python Collections II](../day-056-python-collections-ii/)
- [Back to Main Learning Path](../README.md)
