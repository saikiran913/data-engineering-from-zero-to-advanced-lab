# Day 003 Data Type Comparison

## Quick Comparison Table

| Category | Structured Data | Semi-Structured Data | Unstructured Data |
| --- | --- | --- | --- |
| Format | Rows and columns | Has keys, tags, nesting, or patterns | No fixed table-like format |
| Example | Customer table | JSON API response | Product image |
| Storage | Database, spreadsheet, data warehouse | Data lake, object storage, NoSQL database | Data lake, object storage, document or media storage |
| Query method | SQL is common | Parse first, then query extracted fields | Extract metadata or text first, then analyze |
| Difficulty | Easier | Medium | Harder |
| Common tools | SQL databases, BigQuery, Snowflake, Azure SQL | JSON tools, logs, APIs, MongoDB, data lakes | Object storage, OCR, AI or ML tools, search systems |
| Beginner learning priority | Learn first | Learn after tables | Learn later at a high level first |
| Real-world importance | Very high | Very high | Growing quickly |

## When to Use Structured Data

Structured data is useful when information fits naturally into rows and columns.

Examples:

- Customer details
- Product lists
- Order transactions
- Payment records
- Student marks
- Inventory records

Structured data is commonly used for dashboards and reports because it is easy to filter, group, join, and summarize.

Example:

```text
Order table -> Sales summary -> Sales dashboard
```

## When to Use Semi-Structured Data

Semi-structured data is useful when systems need flexible data formats.

Examples:

- API responses
- JSON event payloads
- XML messages
- Application logs
- Clickstream events

Modern applications often use semi-structured data because it is flexible. A JSON response can include nested details, optional fields, and different sections.

Example:

```text
API response -> Extract customer_id and order_id -> Orders table
```

## When to Use Unstructured Data

Unstructured data is useful when information comes as text, media, or documents instead of tables.

Examples:

- Customer emails
- Product images
- Training videos
- Support call recordings
- PDF invoices
- Social media comments

Unstructured data may contain valuable business information, but it usually needs extra processing before it can be analyzed easily.

Example:

```text
Customer review text -> Detect sentiment -> Customer feedback table
```

## How Data Engineers Convert Data Between Types

Data engineers often convert semi-structured or unstructured data into structured tables because structured tables are easier for reporting.

| Conversion | Simple Explanation |
| --- | --- |
| JSON to table | Extract fields like `customer_id`, `order_id`, and `amount` into columns. |
| Log file to structured table | Read each log line and separate timestamp, event name, user ID, and status. |
| PDF text extraction to table | Extract invoice number, invoice date, vendor, and amount from a PDF. |
| Image metadata to table | Store file name, image size, upload date, product ID, and category in a table. |
| Customer review text to sentiment table | Analyze review text and store whether the review is positive, neutral, or negative. |

The goal is not always to convert everything fully into a table. Sometimes the original file is stored as-is, while useful details are extracted into tables for searching, reporting, or analysis.

