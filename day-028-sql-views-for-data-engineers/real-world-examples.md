# Real-World View Examples

| # | Scenario | Consumer | Source Objects | Source Grain | Output Grain | Exposed Columns | Excluded Columns | Main Rule | Dependency Risk | Validation |
|---|---|---|---|---|---|---|---|---|---|---|
| 1 | Active customer directory | Analyst | `raw_customers` | Customer version | Active customer version | ID, name, country | email | Active only | Status meanings | Row count |
| 2 | Valid-order reporting view | Report | `raw_orders` | Order version | Valid order version | ID, customer, amount | Invalid rows | Positive amount | Status rules | Total reconciliation |
| 3 | Current order-state view | Operations | `raw_orders` | Order version | One row per order | Latest order fields | Older versions | Latest update | Tie-breaker | Unique order ID |
| 4 | Successful-payment view | Finance report | `raw_payments` | Payment attempt | Successful payment attempt | Payment and amount | Failed attempts | Status success | Status rules | Payment total |
| 5 | Customer sales summary | Sales report | `raw_orders` | Order version | Customer | Counts and totals | Detail rows | Completed only | Order rules | Reconcile totals |
| 6 | Country customer summary | Dashboard | `raw_customers` | Customer version | Country | Counts and dates | email | Country present | Null country | Count review |
| 7 | Order-payment details | Analyst | Orders, payments | Order and payment attempt | Payment attempt | order and payment IDs | email | Join on order_id | Row multiplication | Attempts per order |
| 8 | Campaign daily reporting | Marketing | `campaign_daily_metrics` | Delivery load | Campaign-date-channel-country | Metrics | Null spend rows | Valid metrics | Corrected loads | Duplicate delivery check |
| 9 | Campaign latest delivery | Marketing | `campaign_daily_metrics` | Delivery load | Latest delivery | Latest metrics | Old loads | Latest loaded_at | Tie-breaker | Unique campaign-date |
| 10 | Payment exception view | Finance review | Payments, orders | Payment attempt | Payment issue | payment ID, issue | normal rows | Failed or unmatched | Matching rules | Issue counts |
| 11 | Data-quality review queue | Data engineer | Multiple raw tables | Issue row | One issue | dataset, key, issue | normal rows | Review rules | Threshold changes | Issue counts |
| 12 | Restricted customer view | External report | `raw_customers` | Customer version | Customer version | ID, name, country | email, source | Column restriction | Permissions vary | Column exposure |
| 13 | Product-category summary | Merchandising | `product_catalog` | Product | Category | counts and prices | product-level rows | category present | Null category | Category counts |
| 14 | Reusable window-metric view | Analyst | campaign metrics | Campaign-date | Campaign-date metric | running metrics | raw corrections | Latest delivery first | Grain changes | Reconciliation |

When monetary examples are discussed in prose, treat amounts as INR values. CSV fields remain numeric.
