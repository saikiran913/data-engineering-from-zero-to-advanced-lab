# Real-World Examples

| Scenario | Grain | Partition | Ordering | Function | Comparison | Boundary Policy | Review Condition |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Payment-status change | One status event | `transaction_id` | `status_sequence` | `LAG` | Current status vs previous | First status is expected | Status changed |
| Product-price increase | One price update | `product_id` | `price_date`, `updated_at` | `LAG` | Current price vs previous | First price is expected | Price increased |
| Product-price decrease | One price update | `product_id` | `price_date`, `updated_at` | `LAG` | Current price vs previous | First price is expected | Price decreased |
| Daily sales change | One region-date row | `region` | `sale_date` | `LAG` | Current sales vs previous | First date is expected | Large movement |
| Missing daily file | One region-date row | `region` | `sale_date` | `LAG` | Current date vs previous | First date is expected | Date gap |
| Website event gap | One event | `user_id` | `event_sequence` | `LAG` | Current sequence vs previous | First event is expected | Gap greater than one |
| Duplicate event sequence | One event | `user_id` | `event_sequence` | `LAG` | Current sequence vs previous | First event is expected | Difference equals zero |
| First and final order state | One order version | `order_id` | `updated_at`, `version_number` | `LAG` and `LEAD` | Boundary rows | Null boundary expected | Missing final state |
| Next expected workflow step | One status event | `transaction_id` | `status_sequence` | `LEAD` | Current status vs next | Last status expected | Unexpected next status |
| Late-arriving update | One order version | `customer_id` | `updated_at` | `LAG` | Loaded order date vs previous | First load expected | Older business date loaded later |
| Unchanged value monitoring | One product update | `product_id` | `price_date` | `LAG` | Current price vs previous | First price expected | No change over multiple rows |
| Suspicious large change | One sales day | `region` | `sale_date` | `LAG` | Difference amount | First date expected | Large increase or decrease |

Validation checks should include partition counts, duplicate ordering values, boundary counts, null comparison values, and review of change flags.
