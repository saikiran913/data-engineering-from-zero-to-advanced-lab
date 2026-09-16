# Real-World Examples

| # | Situation | Collection and lesson |
| --- | --- | --- |
| 1 | One order | Dictionary keyed by `order_id`, `status`, and `amount` |
| 2 | One customer | Dictionary with named customer fields |
| 3 | Validation results | Dictionary from rule name to outcome |
| 4 | Pipeline setting | Dictionary lookup by configuration name |
| 5 | Optional review note | `.get()` avoids assuming the field exists |
| 6 | Required identifier | Direct access exposes missing required data |
| 7 | Missing required key | Set difference identifies it |
| 8 | Present `None` value | Treat separately from an absent key |
| 9 | Several orders | List of dictionaries preserves record order |
| 10 | Customer information | Nested dictionary keeps related fields together |
| 11 | Record flags | Dictionary contains a list of flags |
| 12 | Allowed statuses | Set supports fast membership thinking |
| 13 | Repeated source IDs | List reveals duplicate frequency |
| 14 | Unique source IDs | Set removes exact repeated identifiers |
| 15 | Expected columns | Set defines a contract |
| 16 | Observed columns | Set records supplied fields |
| 17 | Missing columns | `expected - observed` |
| 18 | Extra columns | `observed - expected` |
| 19 | Shared columns | `expected & observed` |
| 20 | All known columns | `expected | observed` |
| 21 | Status check | `status in allowed_statuses` |
| 22 | Field inspection | `.items()` shows names and values |
| 23 | Set output | Do not interpret printed order as business order |
| 24 | Key typo | A contract prevents `orderId` versus `order_id` drift |
| 25 | Uneven nested record | Validate optional customer data safely |
| 26 | Optional nested country | Inspect customer before country |
| 27 | Record versus list | Named record uses dictionary, many records use list |
| 28 | Tuple versus dictionary | Names remove positional guesswork |
| 29 | List versus set | Preserve sequence when duplicates matter |
| 30 | Mutation side effect | Copy a working record before adding validation output |
| 31 | Full lookup workflow | Validate keys, status, optional note, nested country |

Each example should start with a documented shape, select the collection based on business meaning, and record validation assumptions before later pipeline stages depend on it.
