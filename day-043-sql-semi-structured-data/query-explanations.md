# Query Explanations

| Semi-structured concept | Main question | Validation approach |
|---|---|---|
| JSON object | What keys and values exist? | Inspect event types and payload status |
| Nested path | Where is the value inside the object? | Compare expected paths with extracted fields |
| Extraction | Was the value read successfully? | Summarise `extraction_status` |
| Missing versus null | Is the key absent or explicitly null? | Use validation cases and separate issue labels |
| Type validation | Does text match the expected type? | Review invalid number and date cases |
| Arrays | How many elements can one event contain? | Count elements per parent event |
| Array expansion | Did one event become many rows? | Reconcile parent and element counts |
| Parent key | Can element rows be traced back? | Preserve `event_id` and `array_index` |
| Nested schema validation | Did paths change over time? | Compare schema-version rows |
| Exceptions | Which rows need review? | Build one row per issue |

## Business Purpose

Semi-structured validation helps data engineers turn flexible payloads into reliable reporting or pipeline inputs. The parent grain in this lesson is usually one row per event. Array expansion changes the output grain to one row per event and array element.

## Common Platform Caveat

JSON extraction, safe casting, and array expansion syntax vary widely. The SQL files use relationalized sample tables for executable practice and comments for platform-specific extraction examples.

## Line-by-Line Example

```sql
SELECT
    event_id,
    event_type,
    'customer.id' AS field_name,
    customer_id_text AS observed_value
FROM extracted_json_fields
WHERE event_type = 'ORDER_CREATED'
  AND (customer_id_text IS NULL OR customer_id_text = '');
```

- `event_id` preserves the parent key.
- `event_type` keeps the rule event-specific.
- `'customer.id'` documents the expected nested path.
- `customer_id_text` shows the extracted value.
- The `WHERE` clause separates null and blank values for review.

