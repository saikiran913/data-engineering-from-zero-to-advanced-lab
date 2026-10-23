# Build a Memory-Aware Record Processing Flow with Generators

1. Verify Python with `python --version`.
2. Run `python scripts/01_iterable_and_iterator.py`.
3. Run `python scripts/02_iter_and_next.py`.
4. Run `python scripts/03_generator_functions.py`.
5. Run `python scripts/04_generator_expressions.py`.
6. Run `python scripts/05_generator_pipeline.py`.
7. Run `python scripts/06_memory_aware_record_workflow.py`.
8. Create an iterator from a three-item list and manually call `next()` once.
9. Exhaust it safely with `try/except StopIteration`.
10. Recreate an iterator from the original list and request its first value.
11. Compare a list comprehension with a generator expression using the same three values.
12. Intentionally materialise one generator using `list()`.
13. Show that consuming the same generator a second time gives an empty list.
14. Explain when a list would better support sorting or repeated access.

## Completion Checklist

- Explain iterable, iterator, `iter()`, `next()`, and `StopIteration`.
- Identify a generator function, `yield`, and a generator expression.
- Explain lazy versus eager results and one-pass exhaustion.
- Trace source, stages, and consumer without building a final list.
