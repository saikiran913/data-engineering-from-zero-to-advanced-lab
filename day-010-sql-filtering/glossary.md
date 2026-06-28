# Day 010 Glossary

| Term | Simple Meaning | Beginner Example |
| --- | --- | --- |
| Filter | A rule that keeps only matching rows. | Only UK customers. |
| WHERE | SQL clause used to filter rows. | `WHERE country = 'UK'` |
| Condition | A rule that can be true or false. | `order_amount > 500` |
| Comparison Operator | Symbol used to compare values. | `=`, `>`, `<` |
| AND | All conditions must be true. | Active customers from UK. |
| OR | At least one condition must be true. | Cancelled or Returned orders. |
| Parentheses | Symbols used to group logic. | `(status = 'Failed' OR status = 'Refunded')` |
| IN | Checks whether value is in a list. | `country IN ('UK', 'India')` |
| BETWEEN | Checks whether value is within a range. | `price BETWEEN 20 AND 100` |
| LIKE | Searches for text pattern. | `name LIKE '%Book%'` |
| Wildcard | Symbol that represents flexible matching. | `%` in `LIKE` |
| Percent Wildcard | Matches any number of characters. | `'%Sale%'` |
| Pattern Matching | Searching by text pattern. | Product name contains Book. |
| IS NULL | Finds missing values. | `email IS NULL` |
| IS NOT NULL | Finds available values. | `email IS NOT NULL` |
| NULL | Missing, unknown, or unavailable value. | Missing delivery date. |
| Empty String | Text with no characters. | `''` |
| Text Filter | Filter on text values. | `status = 'Active'` |
| Numeric Filter | Filter on numbers. | `amount > 500` |
| Date Filter | Filter on dates. | `order_date >= '2026-06-01'` |
| Boolean Filter | Filter on true/false values. | `is_active = true` |
| Exact Match | Value must match exactly. | `country = 'UK'` |
| Range Filter | Filter between low and high values. | `budget BETWEEN 1000 AND 5000` |
| Multiple Value Filter | Filter using several allowed values. | `channel IN ('Search', 'Email')` |
| Data Quality Filter | Filter used to find data issues. | `email IS NULL` |
| Business Rule Filter | Filter based on business meaning. | Exclude cancelled orders. |
| Case Sensitivity | Whether uppercase and lowercase are treated differently. | `Book` vs `book` |
| Date Range | Start date and end date filter. | June orders. |
| Query Logic | How conditions work together. | `AND`, `OR`, parentheses. |
| Selected Rows | Rows kept by a filter. | Matching records. |
| Excluded Rows | Rows removed by a filter. | Non-matching records. |

