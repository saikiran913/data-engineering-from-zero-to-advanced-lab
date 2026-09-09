# Real-World Examples

| # | Source pattern | JSON shape | Target path | Parent grain | Output grain | Validation risk | Recommended check |
|---|---|---|---|---|---|---|---|
| 1 | Application event | Customer object | `customer.id` | Event | Event | Missing ID | Required path check |
| 2 | Order-created event | Order object | `order.amount` | Event | Event | Invalid number | Type validation |
| 3 | Order-updated event | Status object | `order.status` | Event | Event | Unsupported status | Allowed-value check |
| 4 | Product-view event | Product object | `product.code` | Event | Event | Missing product | Required path check |
| 5 | Optional country field | Customer object | `customer.country` | Event | Event | False failure | Optionality check |
| 6 | Missing customer ID | No key | `customer.id` | Event | Event | Missing key | Exception queue |
| 7 | Explicit null ID | Null value | `customer.id` | Event | Event | Null confused with missing | Null case review |
| 8 | Blank customer ID | Empty string | `customer.id` | Event | Event | Blank accepted incorrectly | Blank check |
| 9 | Numeric amount | Number | `order.amount` | Event | Event | None expected | Typed review |
| 10 | Numeric as text | String number | `order.amount` | Event | Event | Cast needed | Safe-cast concept |
| 11 | Invalid numeric | Text | `order.amount` | Event | Event | Cast failure | Invalid number queue |
| 12 | Date string | Text date | `order.date` | Event | Event | Bad format | Date validation |
| 13 | Invalid date | Bad text | `order.date` | Event | Event | Wrong period | Invalid date queue |
| 14 | Tags array | String array | `tags[]` | Event | Event-tag | Row multiplication | Element count |
| 15 | Empty tags | Empty array | `tags` | Event | Event | Confused with missing | Empty-array review |
| 16 | Item array | Object array | `items[]` | Event | Event-item | Grain change | Preserve event ID |
| 17 | Item missing product | Object array | `items[].product_code` | Event | Event-item | Missing key | Element exception |
| 18 | Invalid quantity | Object array | `items[].quantity` | Event | Event-item | Invalid number | Quantity validation |
| 19 | Renamed key | Nested object | `customer.customer_id` | Event | Event | Schema drift | Version comparison |
| 20 | Added key | Extra object | `experiment.id` | Event | Event | Unknown meaning | Unexpected key review |
| 21 | Type changed | Number to string | `order.amount` | Event | Event | Type drift | Schema version check |
| 22 | Malformed payload | Invalid JSON text | `payload_text` | Event | Event | Parse failure | Payload exception |
| 23 | One parent many elements | Array | `items[]` | Event | Event-item | Count increase | Parent-element reconciliation |
| 24 | No-flattening-needed case | Nested scalar | `customer.id` | Event | Event | Unnecessary row growth | Extract scalar only |

