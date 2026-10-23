# Day 063 Notes

```text
collection
→ filter
→ transform
→ sort
→ validate shape
→ pass to next stage
```

A loop and a comprehension can produce the same list. A comprehension is useful when the output expression and optional filter each have one clear purpose. A loop is easier to inspect when a record needs several checks, a reason code, or PASS/REVIEW/FAIL classification.

Filtering decides which items stay. Transformation changes their representation. Sorting changes their order. Keep these decisions visible, and verify the output count and fields after each stage. `sorted()` leaves the original list order intact, which matters when the raw delivery order is evidence. `.sort()` changes the list in place.

Data engineering examples in this lesson are deliberately small and in memory. Reuse Day 062 helper functions when a rule is too substantial to fit clearly inside a comprehension.
