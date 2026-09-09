# Sample Tables for Day 043

Day 043 uses relationalized sample data so executable SQL can remain vendor-neutral while learners practise semi-structured data concepts.

## File Overview

| File | Purpose | Grain | Key | Semi-structured role |
|---|---|---|---|---|
| `event_records.csv` | Raw event records with JSON-like payload text | One row per event | `event_id` | Parent records and payload inspection |
| `extracted_json_fields.csv` | Already-extracted nested values | One row per event | `event_id` | Portable validation of extracted fields |
| `array_element_records.csv` | Relationalized array elements | One row per event and array element | `event_id`, `array_name`, `array_index` | Array expansion and grain review |
| `expected_json_paths.csv` | Expected nested path contract | One row per expected path | `path_id` | Required and optional path validation |
| `json_validation_cases.csv` | Known validation cases | One row per issue or review case | `case_id` | Exception reporting |
| `nested_schema_versions.csv` | Nested schema version comparison | One row per schema path | `schema_version`, `event_type`, `json_path` | Schema drift review |

## Known Issues Included

| Issue | Example purpose |
|---|---|
| Missing nested key | Customer ID path absent |
| Explicit null | Key exists with null value |
| Blank string | Key exists but value is empty |
| Invalid numeric text | Amount value is not numeric |
| Invalid date text | Date-like text is invalid |
| Unsupported status | Status not in expected list |
| Empty array | Array exists but has no elements |
| Array element missing key | Item object lacks product code |
| Duplicate array element | Same tag appears twice |
| Possible renamed key | `customer.id` appears as `customer.customer_id` |
| Unexpected nested key | New key appears without a contract |
| Malformed payload | Payload text cannot be parsed cleanly |

## Validation Questions

- What is the parent grain?
- Which event types are expected?
- Which nested paths are required?
- Which paths are optional?
- Are missing, null, and blank handled separately?
- Are typed values validated before casting?
- Does array expansion preserve the parent key?
- Has the output grain changed?
- Are nested schema changes documented?

