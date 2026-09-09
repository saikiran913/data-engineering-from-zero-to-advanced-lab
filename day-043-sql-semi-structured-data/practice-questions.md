# Practice Questions

## Section A: Concept Checks

1. What is semi-structured data?
2. What is JSON?
3. What is a JSON object?
4. What is a key-value pair?
5. What is a nested path?
6. What is an array?
7. What is an array of objects?
8. What is a missing key?
9. What is an explicit null?
10. What is a blank value?
11. What is malformed JSON?
12. What is extraction?
13. What is typed extraction?
14. Why can casting fail?
15. What is schema-on-read?
16. Why preserve parent key?
17. What is array expansion?
18. How does array expansion affect grain?
19. What is nested schema drift?
20. What is a required path?
21. What is an optional path?
22. Why build exception outputs?
23. Why does vendor syntax matter?
24. Why should arrays not be flattened blindly?

## Section B: Classify the Issue

Classify each as valid, missing key, explicit null, blank value, invalid number, invalid date, unexpected type, empty array, malformed JSON, nested schema drift, or optional missing field.

1. `customer.id` is absent for an order event.
2. `customer.id` exists as null.
3. `customer.id` is `""`.
4. `order.amount` is `not_available`.
5. `order.date` is `bad-date`.
6. `tags` is an empty optional array.
7. `customer.customer_id` appears instead of `customer.id`.
8. Payload syntax is incomplete.
9. Optional `customer.country` is absent for product view.
10. `order.status` is `UNKNOWN`.
11. Item object lacks `product_code`.
12. Quantity is `two`.
13. New `experiment.id` appears.
14. `order.amount` changes from number to string.
15. Valid customer ID is present.
16. Tags array has duplicate tag values.

## Section C: Complete the SQL

Write read-only SQL to:

1. Count events by event type.
2. Summarise extraction status.
3. Find null customer IDs.
4. Find blank customer IDs.
5. Find invalid numeric cases.
6. Find invalid date cases.
7. Count array elements by event.
8. Count parent events.
9. Compare parent count with array element rows.
10. Find missing product codes in item elements.
11. Find invalid quantities.
12. List expected required paths.
13. Summarise schema changes.
14. Build an exception queue.
15. Summarise validation cases by severity.
16. Apply an event-type-specific rule.

## Section D: Fix the Mistake

1. Assuming JSON syntax is universal.
2. Treating missing key as null.
3. Treating null as blank.
4. Treating numeric text as numeric automatically.
5. Casting without checking invalid values.
6. Ignoring invalid date text.
7. Flattening arrays without `event_id`.
8. Dropping array index.
9. Calling row multiplication duplication automatically.
10. Ignoring duplicate array elements.
11. Treating empty array as missing key.
12. Treating optional missing fields as failures.
13. Applying one required-field rule to every event type.
14. Ignoring nested schema drift.
15. Treating object values as scalars.
16. Mixing malformed payloads with business validation.

## Section E: Design the Nested Contract

For each scenario, define parent grain, event type, path, required flag, expected type, array flag, output grain, severity, validation, and review action.

1. Order-created customer ID.
2. Order-created amount.
3. Order-created item quantity.
4. Product-view product code.
5. Optional tags.
6. Customer-updated active flag.
7. Order-updated status.
8. Product-view experiment ID.
9. Renamed customer key.
10. Empty item array.

## Section F: Mini Case Study

Use all supplied files to define parent event grain, identify expected paths, validate extraction status, find missing/null/blank values, validate numeric/date fields, review arrays, count array elements, preserve parent keys, validate array-element fields, compare nested schema versions, build an exception queue, and build a validation summary.

## Answer Key

### Section A

1. Data with structure that may vary.
2. A text format for objects, keys, values, and arrays.
3. A collection of key-value pairs.
4. A key name connected to a value.
5. A conceptual address for a nested value.
6. A collection of zero or more elements.
7. An array where each element is an object.
8. A key that does not exist.
9. A key that exists with null.
10. A key with empty string.
11. JSON text with invalid syntax.
12. Reading a nested value.
13. Reading or casting a value to an expected type.
14. Data may be inconsistent.
15. Structure interpreted when queried.
16. To trace child rows to the source.
17. Turning array elements into rows.
18. It changes one event into zero, one, or many element rows.
19. Nested structure changes over time.
20. A path that must exist.
21. A path allowed to be missing.
22. To route records for review.
23. JSON functions differ by platform.
24. Flattening changes grain and can multiply rows.

### Section B

1. Missing key.
2. Explicit null.
3. Blank value.
4. Invalid number.
5. Invalid date.
6. Empty array, valid if optional.
7. Nested schema drift.
8. Malformed JSON.
9. Optional missing field.
10. Unsupported value.
11. Missing key in array element.
12. Invalid number.
13. Unexpected key.
14. Type change.
15. Valid.
16. Duplicate array element review.

### Section C Sample Answers

```sql
SELECT
    event_type,
    COUNT(*) AS event_count
FROM event_records
GROUP BY event_type;
```

```sql
SELECT
    extraction_status,
    COUNT(*) AS event_count
FROM extracted_json_fields
GROUP BY extraction_status;
```

```sql
SELECT
    event_id,
    event_type,
    customer_id_text
FROM extracted_json_fields
WHERE customer_id_text IS NULL OR customer_id_text = '';
```

```sql
SELECT
    event_id,
    array_name,
    COUNT(*) AS element_count
FROM array_element_records
GROUP BY event_id, array_name;
```

### Section D

The safer pattern is to document expected paths, preserve parent keys, validate missing/null/blank separately, validate types before casting, and build exception outputs for review.

