# Day 008 Data Quality Issue Examples

| # | Issue Name | Bad / Raw Value | Expected / Clean Value | Why It Matters |
| --- | --- | --- | --- | --- |
| 1 | Name has extra spaces | `"  Customer A  "` | `"Customer A"` | Matching and grouping become cleaner. |
| 2 | Email uppercase | `USER@EMAIL.COM` | `user@email.com` | Email comparisons become consistent. |
| 3 | Missing customer ID | blank | valid customer ID | Order cannot be linked to a customer. |
| 4 | Duplicate order ID | `ORD1001` appears twice | one `ORD1001` record | Revenue may be double-counted. |
| 5 | Wrong date format | `31/31/2026` | valid date | Date processing may fail. |
| 6 | Amount stored as text | `"2500"` | `2500` | Calculations need numeric values. |
| 7 | Negative quantity | `-5` | positive quantity | Quantity is unrealistic for normal sale. |
| 8 | Country value inconsistent | `UK`, `U.K.`, `United Kingdom` | standard country value | Country reports split incorrectly. |
| 9 | Payment status unexpected | `Maybe` | Paid, Failed, Pending, or Refunded | Status reports become unreliable. |
| 10 | Future transaction date | `2099-01-01` | realistic transaction date | Time-based reports become wrong. |
| 11 | Null order amount | null | valid amount | Revenue cannot be calculated. |
| 12 | Product ID missing | blank | valid product ID | Sale cannot be linked to product. |
| 13 | Duplicate click event | same event ID twice | one event | Clicks may be overcounted. |
| 14 | File has zero rows | empty file | expected records | Dashboard may show zero activity. |
| 15 | CSV missing header | first row is data | header row present | Pipeline cannot map columns reliably. |
| 16 | JSON missing key | no `order_id` | `order_id` present | Required field cannot be extracted. |
| 17 | Source row count mismatch | source 1,000, target 900 | counts match or explained | Data may be lost during loading. |
| 18 | Target total sales mismatch | source 50,000, target 48,000 | totals match or explained | Revenue reporting may be wrong. |
| 19 | Dashboard not refreshed | last update three days ago | current expected refresh | Users see stale data. |
| 20 | Order exists without customer | unknown customer ID | matching customer exists | Joins and reports break. |
| 21 | Refund greater than purchase | refund 120, purchase 100 | refund <= purchase | Business rule is violated. |
| 22 | Delivery date before order date | delivered before ordered | delivery date after order date | Timeline is impossible. |
| 23 | Click-through rate greater than 100% | 180% | 0% to 100% | Metric calculation or input is wrong. |
| 24 | Reprocessed file loaded twice | same file loaded twice | file loaded once | Counts and totals duplicate. |
| 25 | Unknown campaign ID | click references missing campaign | campaign exists | Marketing attribution fails. |

