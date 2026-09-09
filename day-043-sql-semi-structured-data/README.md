# Day 043 - SQL for Semi-Structured Data

Day 043 introduces SQL thinking for semi-structured data: JSON fields, nested values, arrays, extraction, validation, and grain.

Day 003 introduced semi-structured data. Day 007 introduced JSON as a common format. Day 037 introduced schema validation. Day 043 combines these ideas and shows how data engineers reason about nested data in SQL.

## Learning Objectives

By the end of this day, you should understand:

- what semi-structured data means
- what JSON objects, keys, values, nested objects, and arrays are
- what a JSON path means conceptually
- what schema-on-read means
- why nested fields can vary across rows
- why missing key, explicit null, blank string, and failed cast are different
- why JSON extraction syntax differs across SQL platforms
- why extracted values may need type validation
- why arrays can contain zero, one, or many elements
- why array expansion changes grain and can multiply rows
- why parent keys must be preserved during array expansion
- why nested schema drift can happen without relational schema changes
- how to create exception outputs for nested-data issues
- why semi-structured data should not be flattened blindly

## Why Semi-Structured SQL Matters

Data engineers often receive:

- application events stored as JSON
- API payloads
- webhook records
- clickstream attributes
- product metadata
- nested customer attributes
- arrays of tags
- arrays of line items
- nested campaign metadata
- optional fields that vary by event type

## Required Warnings

> JSON extraction syntax varies significantly across SQL platforms. Day 043 teaches the concepts and common patterns, not one universal JSON function syntax.

> A missing JSON key, an explicit JSON null, an empty string, and a failed cast are different data-quality conditions and should not be treated as the same problem.

> Expanding an array changes the output grain and can multiply rows. Preserve the parent business key and reconcile the expected number of array elements.

> Semi-structured data can change shape over time even when the relational table schema remains unchanged. Nested schema drift should be validated explicitly.

## Suggested Learning Order

1. Read `notes.md`
2. Review `sample-tables.md`
3. Inspect sample CSVs
4. Learn JSON object concepts
5. Review nested paths
6. Compare missing/null/type cases
7. Validate nested fields
8. Learn array concepts
9. Review array expansion and grain
10. Validate typed values
11. Validate nested schemas
12. Build semi-structured exceptions
13. Build validation summary
14. Complete the debugging lab
15. Run the integrated workflow
16. Review the cheat sheet
17. Complete practice questions
18. Read the summary and glossary

## Files

| File | Purpose | Recommended order |
|---|---|---|
| `README.md` | Day 043 landing page | 1 |
| `notes.md` | Semi-structured data concepts | 2 |
| `sample-tables.md` | Sample data guide | 3 |
| `json-object-concepts.sql` | JSON object and payload review | 4 |
| `nested-path-extraction.sql` | Nested path extraction review | 5 |
| `missing-null-and-type-review.sql` | Missing, null, blank, and type checks | 6 |
| `nested-field-validation.sql` | Required nested-field validation | 7 |
| `array-concepts.sql` | Array element review | 8 |
| `array-expansion-and-grain.sql` | Array expansion and grain checks | 9 |
| `typed-value-validation.sql` | Number, date, boolean, and status checks | 10 |
| `nested-schema-validation.sql` | Nested schema drift review | 11 |
| `semi-structured-exception-reporting.sql` | Exception queue patterns | 12 |
| `semi-structured-validation-summary.sql` | Summary checks | 13 |
| `json-debugging-lab.sql` | Debugging practice | 14 |
| `integrated-semi-structured-workflow.sql` | End-to-end workflow | 15 |
| `query-explanations.md` | Query explanations | 16 |
| `semi-structured-cheatsheet.md` | Quick reference | 17 |
| `json-validation-guide.md` | Validation guide | 18 |
| `common-mistakes.md` | Mistakes and safer habits | 19 |
| `real-world-examples.md` | Practical scenarios | 20 |
| `beginner-summary.md` | Lesson recap | 21 |
| `glossary.md` | Key terms | 22 |
| `practice-questions.md` | Exercises and answer key | 23 |

## Main Concepts

| Concept | Simple meaning |
|---|---|
| Semi-structured data | Data with structure that may vary by row |
| JSON | Text format with objects, keys, values, and arrays |
| JSON object | A collection of key-value pairs |
| JSON key | Name used to find a value |
| JSON value | Stored value such as text, number, object, array, boolean, or null |
| Nested object | Object inside another object |
| JSON path | Conceptual address for a nested value |
| Array | Ordered collection of zero or more elements |
| Scalar | Single value such as text or number |
| Missing key | Key does not exist |
| Explicit null | Key exists with null value |
| Extraction | Reading a value from a nested path |
| Typed extraction | Extracting or casting into an expected type |
| Schema-on-read | Interpreting structure when data is queried |
| Array expansion | Turning array elements into rows |
| Parent key | Event or record ID retained during expansion |
| Nested schema drift | Nested paths change over time |
| Semi-structured exception | Review row for a nested-data issue |

## Safe-Learning Note

All executable SQL is read-only. JSON syntax examples are platform-specific and commented. No source data is modified. Array expansion examples document grain explicitly. Production parsing, automatic inference, schema registries, and cloud-specific setup remain out of scope.

## Navigation

- Previous Day: [Day 042 - SQL Performance Habits](../day-042-sql-performance-habits/)
- Next Day: [Day 044 - Command Line Fundamentals for Data Engineers](../day-044-command-line-fundamentals/)
- [Back to Main Learning Path](../README.md)
