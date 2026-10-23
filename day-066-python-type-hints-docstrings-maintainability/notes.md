# Day 066 Notes

```text
intended value shape → type hint
meaning and assumptions → docstring
actual incoming value → runtime validation
clean responsibilities → maintainable pipeline
```

Type hints make a function's intended inputs and return type visible in its signature. Docstrings explain meaning that types cannot express: whether blank text is allowed, what `None` means, and why a status becomes REVIEW. Neither replaces checks on incoming values.

A readable pipeline uses focused stages with explicit names and predictable returns. Short code is not always clear code: a dense expression that hides several business rules can be harder to review than a few named functions. Document a public helper's contract; reserve inline comments for an unusual decision or constraint in the implementation. Keep the annotation, docstring, and actual behaviour aligned when code changes.
