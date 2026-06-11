# Day 003 Notes - Types of Data

## What Data Types Mean

In Data Engineering, data types describe how data is organized.

This lesson focuses on three broad types:

- Structured data
- Semi-structured data
- Unstructured data

These are not about small programming data types like numbers or text. Here, data type means the overall format of the data.

Simple question:

```text
Does the data fit neatly into rows and columns?
```

If yes, it is usually structured data. If it has some organization but does not fit neatly into tables, it is semi-structured data. If it has no fixed table-like structure, it is unstructured data.

## Why Format Matters

Format matters because it affects how data is stored, cleaned, transformed, and analyzed.

For example:

- A customer table can be stored in a database.
- A JSON API response may need parsing before it becomes a table.
- A video file may need metadata extraction before it can be searched or analyzed.

Data engineers first understand the format, then decide the right process.

| Question | Why It Matters |
| --- | --- |
| Is the data table-like? | It may be easy to store in a database or warehouse. |
| Is the data nested? | It may need parsing and flattening. |
| Is the data a file like an image or PDF? | It may need special storage or extraction tools. |
| Is the data used for reports? | It may need to become structured first. |

## Structured Data

Structured data is organized in rows and columns.

Each row is usually one record. Each column is one attribute or field.

Example:

| order_id | customer_id | amount | order_date |
| --- | --- | --- | --- |
| 1001 | 501 | 1200 | 2026-06-11 |
| 1002 | 502 | 900 | 2026-06-11 |

This is structured because every row follows the same shape.

Common examples:

- Customer details
- Product list
- Order transactions
- Bank transactions
- Student marks
- Sales spreadsheets

Structured data is widely used in business reports because it is easy to filter, group, join, and summarize.

## Why Structured Data Is Beginner-Friendly

Structured data is beginner-friendly because it is easy to visualize.

When learners see a table, they can quickly understand:

- What each row means
- What each column means
- Which values belong together
- How a report might summarize the data

This is also why SQL is usually taught with structured data first.

## Semi-Structured Data

Semi-structured data has some organization, but it may not be a simple table.

It often uses keys, tags, nesting, or repeated sections.

Common examples:

- JSON files
- XML files
- API responses
- Application logs
- Event tracking payloads

Example:

```json
{
  "event_name": "product_viewed",
  "user_id": 501,
  "product": {
    "product_id": 9001,
    "category": "Electronics"
  },
  "timestamp": "2026-06-11T10:15:00"
}
```

This data is organized, but it is nested. A data engineer may extract fields from it and create a table.

Possible table:

| event_name | user_id | product_id | category | timestamp |
| --- | --- | --- | --- | --- |
| product_viewed | 501 | 9001 | Electronics | 2026-06-11T10:15:00 |

## Why Semi-Structured Data Is Important

Semi-structured data is important because modern applications often communicate through APIs and events.

APIs commonly send JSON. Websites and apps create event data. Logs capture system behavior.

This means data engineers often work with semi-structured data before converting it into structured data for reporting.

## Unstructured Data

Unstructured data does not follow a fixed table-like format.

Examples:

- Images
- Videos
- Audio recordings
- PDFs
- Emails
- Documents
- Chat conversations
- Social media comments

Unstructured data can contain valuable information, but it is harder to analyze directly.

For example, a customer complaint email may contain useful feedback, but it is not already organized in columns like `customer_id`, `issue_type`, and `sentiment`.

## Why Unstructured Data Is Growing

Unstructured data is growing because companies now collect more digital content than ever before.

Examples:

- Product images in online stores
- Training videos in learning platforms
- Support chat messages
- Customer call recordings
- PDF invoices
- Social media comments
- Scanned documents

AI, machine learning, OCR, text processing, and metadata extraction can help companies turn unstructured data into useful insights.

## How Each Type Is Used in Business

| Data Type | Business Use |
| --- | --- |
| Structured Data | Sales reports, finance reports, inventory tracking, customer dashboards. |
| Semi-Structured Data | API integrations, clickstream analysis, application monitoring, event tracking. |
| Unstructured Data | Document search, image analysis, customer feedback analysis, call review. |

## How Data Engineers Decide Storage and Processing

Data engineers look at the data type before choosing storage and processing methods.

| Data Type | Storage Approach | Processing Approach |
| --- | --- | --- |
| Structured | Database or data warehouse | SQL queries, table transformations, quality checks. |
| Semi-Structured | Data lake, object storage, NoSQL database, warehouse JSON column | Parse, extract fields, flatten, convert to tables. |
| Unstructured | Data lake, object storage, document storage, media storage | Extract metadata, process text or media, connect to AI or search systems. |

## Important Beginner Reminder

Most beginners start with structured data because it is easier to understand. That is a good learning path.

But real companies handle all three types. A strong data engineer learns how to recognize each type and choose the right approach.

