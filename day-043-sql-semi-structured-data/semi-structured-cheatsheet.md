# Semi-Structured Data Cheatsheet

## JSON Mental Model

JSON contains objects, keys, values, nested objects, arrays, scalars, booleans, and nulls.

## Nested Path Checklist

- Define event type.
- Define parent grain.
- Identify the path.
- Mark required or optional.
- Define expected type.
- Validate extracted value.

## Missing, Null, and Blank Checklist

- Missing key: key does not exist.
- Explicit null: key exists with null.
- Blank value: key exists with `""`.
- Failed cast: value cannot become expected type.

## Typed Value Checklist

- Is the value required?
- Is it text, number, date text, boolean, object, or array?
- Is safe-cast syntax platform-specific?
- Are invalid values routed to review?

## Array Checklist

- Is the array required?
- Can it be empty?
- What does one element represent?
- Does order matter?

## Array Expansion Checklist

- Preserve parent key.
- Preserve array index when useful.
- Document output grain.
- Reconcile parent count and element count.

## Exception Output Template

| Column | Meaning |
|---|---|
| `exception_level` | Field, payload, array, or schema issue |
| `event_id` | Parent event key |
| `event_type` | Event-specific rule |
| `path_or_array` | Nested path or array name |
| `issue_category` | Type of issue |
| `severity` | Review priority |
| `review_message` | Human-readable reason |

## Platform Syntax Caution

Function families include scalar extraction, object extraction, array expansion, and safe casting. Names and behaviour vary by SQL platform.

