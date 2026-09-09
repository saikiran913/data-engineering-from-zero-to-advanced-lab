# Beginner Summary

Semi-structured data has structure, but that structure can vary from row to row. JSON is a common semi-structured format. JSON objects contain keys and values. Values can be scalars, nested objects, arrays, booleans, or nulls.

A nested path identifies a value inside an object, such as `customer.id` or `order.amount`. SQL platforms use different syntax to extract these paths, so Day 043 focuses on concepts and uses relationalized sample files for executable practice.

Missing key, explicit null, blank string, and failed cast are different conditions. Treating them as the same problem hides useful information. Required paths should be documented by event type, and optional paths should not create false failures.

Extracted values may need type validation. A number can arrive as a number, as numeric text, or as invalid text. Dates may look like text but still be invalid. Safe-cast functions vary by platform.

Arrays contain zero or more elements. Expanding an array changes the output grain and can multiply rows. Preserve the parent key, such as `event_id`, and keep the array index when it matters. Do not flatten arrays unless the downstream need requires it.

Nested schema can drift even when the relational table schema stays the same. A payload column can remain unchanged while paths are added, removed, renamed, or changed in type. Exception queues help route bad or surprising records for review.

Mental model:

```text
inspect -> identify path -> extract -> cast -> validate -> preserve parent key -> flatten only when needed -> reconcile row growth
```

Final warnings:

> JSON extraction syntax varies significantly across SQL platforms. Day 043 teaches the concepts and common patterns, not one universal JSON function syntax.

> A missing JSON key, an explicit JSON null, an empty string, and a failed cast are different data-quality conditions and should not be treated as the same problem.

> Expanding an array changes the output grain and can multiply rows. Preserve the parent business key and reconcile the expected number of array elements.

> Semi-structured data can change shape over time even when the relational table schema remains unchanged. Nested schema drift should be validated explicitly.

Day 044 will deepen semi-structured SQL through practical nested-object and array workflows while staying vendor-neutral.

