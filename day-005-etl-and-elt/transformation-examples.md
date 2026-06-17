# Day 005 Transformation Examples

Data transformation changes raw data into a cleaner, more useful, or more business-ready form.

| # | Raw Value or Condition | Transformed Value or Result | Why It Is Needed |
| --- | --- | --- | --- |
| 1 | Name is `"  Customer A  "` | Name becomes `"Customer A"` | Removes extra spaces so values match correctly. |
| 2 | Email is `"USER@EMAIL.COM"` | Email becomes `"user@email.com"` | Makes email comparisons consistent. |
| 3 | Date is `"17/06/2026"` | Date becomes `"2026-06-17"` | Uses one standard date format. |
| 4 | Price is `"1000"` as text | Price becomes `1000` as a number | Allows calculations. |
| 5 | Same order appears twice | Keep one order record | Prevents double-counting sales. |
| 6 | Country is blank | Flag as missing or fill when trusted source exists | Helps identify incomplete data. |
| 7 | Amount is in dollars | Convert to pounds using a defined rate | Allows reporting in one currency. |
| 8 | Column name is `amt` | Rename to `order_amount` | Makes the data easier to understand. |
| 9 | First name and last name are separate | Create full name | Makes display and reporting easier. |
| 10 | Quantity is `2`, price is `500` | Total order value is `1000` | Creates a useful business metric. |
| 11 | Daily order records | Monthly sales summary | Helps business users see monthly performance. |
| 12 | Customer table and order table are separate | Customer order table | Combines related details for analysis. |
| 13 | First order date equals current order date | Customer classified as new | Helps understand customer behavior. |
| 14 | Transaction amount is negative for a purchase | Mark or remove invalid transaction | Prevents incorrect totals. |
| 15 | Processed record has no processing time | Add processing timestamp | Shows when the data was prepared. |
| 16 | Country values are `uk`, `United Kingdom`, `U.K.` | Standardize to `UK` | Keeps grouping consistent. |
| 17 | Transaction value is much higher than normal | Flag as unusual | Helps review possible errors or risk. |
| 18 | Campaign has 100 clicks and 1,000 impressions | Click-through rate is 10% | Measures campaign engagement. |

## Before and After Example

| Field | Raw Data | Transformed Data |
| --- | --- | --- |
| customer_name | `"  Customer A "` | `"Customer A"` |
| email | `"CUSTOMER@EMAIL.COM"` | `"customer@email.com"` |
| country | `" uk "` | `"UK"` |
| order_amount | `"1000"` | `1000` |
| order_date | `"17/06/2026"` | `"2026-06-17"` |

Good transformations make data easier to trust, query, summarize, and report.

