# Day 003 - Types of Data: Structured, Semi-Structured, and Unstructured

## Learning Goal

By the end of Day 003, you will understand the main types of data used in Data Engineering:

- Structured data
- Semi-structured data
- Unstructured data

You will also understand where these data types come from, how they look, where they are stored, and why data engineers handle them differently.

## Why Data Types Matter in Data Engineering

Not all data looks the same.

Some data is neatly arranged in rows and columns. Some data has labels and nested values. Some data does not have a fixed structure at all.

Examples:

- Customer order table
- JSON response from an API
- Email message
- Image file
- Video file
- Server log
- Excel file

Before a data engineer stores, cleans, transforms, or analyzes data, they need to understand what type of data it is. The type of data affects the tools, storage, and processing approach.

## Simple Definition of Data Types

In this context, data types mean the format or structure in which data appears.

Simple question:

```text
How is the data organized?
```

The answer helps us decide whether the data is structured, semi-structured, or unstructured.

## The Three Main Types of Data

| Data Type | Simple Meaning | Example |
| --- | --- | --- |
| Structured Data | Data organized in rows and columns. | Customer table, orders table, sales Excel sheet. |
| Semi-Structured Data | Data with some organization, but not always table-like. | JSON, XML, API response, application log. |
| Unstructured Data | Data without a fixed table-like structure. | Images, videos, PDFs, emails, audio files. |

## Structured Data

Structured data is data that is organized in a clear format, usually rows and columns.

It looks like a table.

Examples:

- Customer table
- Orders table
- Product table
- Student marks table
- Bank transaction table

Example customer table:

| customer_id | customer_name | country | signup_date |
| --- | --- | --- | --- |
| 101 | Customer A | India | 2026-06-01 |
| 102 | Customer B | United Kingdom | 2026-06-03 |
| 103 | Customer C | United States | 2026-06-05 |

Structured data is beginner-friendly because it is easy to see and understand. Each row usually represents one record. Each column represents one piece of information.

Structured data is also easy to query using SQL because SQL works very well with tables.

Common storage systems for structured data:

- Relational databases
- Data warehouses
- Spreadsheets
- BigQuery tables
- Azure SQL tables
- Snowflake tables

These tools are mentioned only at a high level for now. The important idea is that structured data fits neatly into tables.

## Semi-Structured Data

Semi-structured data has some organization, but it does not always fit neatly into rows and columns.

It usually has labels, keys, tags, or patterns that help describe the data.

Examples:

- JSON
- XML
- Application logs
- API responses
- Event tracking data

Small JSON example:

```json
{
  "customer_id": 101,
  "customer_name": "Customer A",
  "order": {
    "order_id": 5001,
    "amount": 2500
  }
}
```

This data has structure. We can see fields like `customer_id`, `customer_name`, `order_id`, and `amount`. But it is not a simple flat table because the order details are nested inside another section.

Semi-structured data is common in modern applications and APIs. Many systems send and receive data as JSON.

Data engineers often need to extract useful fields from semi-structured data and convert them into structured tables.

Example:

```text
JSON API response -> Extract fields -> Customer order table
```

## Unstructured Data

Unstructured data does not have a fixed table-like structure.

Examples:

- Images
- Videos
- Audio recordings
- PDFs
- Emails
- Social media comments
- Documents
- Chat conversations

Unstructured data is harder to analyze directly because it does not fit neatly into rows and columns.

For example, a product image is data, but it does not have columns like `product_id`, `price`, and `country` inside it. A customer support call recording is also data, but it must be processed before a company can easily analyze it.

Companies may use high-level techniques such as:

- AI
- Machine learning
- OCR
- Text processing
- Metadata extraction

For now, do not worry about learning these tools deeply. Just remember that unstructured data often needs extra processing before it becomes easy to analyze.

## Structured vs Semi-Structured vs Unstructured

| Feature | Structured Data | Semi-Structured Data | Unstructured Data |
| --- | --- | --- | --- |
| Rows and columns | Yes | Sometimes after processing | No fixed table structure |
| Easy to query with SQL | Yes | Not directly always | No, not directly |
| Common examples | Tables, spreadsheets, transactions | JSON, XML, logs, API responses | Images, videos, PDFs, emails |
| Common storage | Databases, warehouses, spreadsheets | Data lakes, object storage, NoSQL databases | Data lakes, object storage, document storage |
| Difficulty level | Easier for beginners | Medium | Harder |
| Typical use case | Reports, dashboards, business metrics | App events, API data, logs | Media analysis, document search, text analysis |

## Real-World Example: Food Delivery App

A food delivery app can generate all three types of data.

### Structured Data

- Customer table
- Restaurant table
- Order table
- Payment table

This data is useful for dashboards such as total orders, revenue, restaurant performance, and customer count.

### Semi-Structured Data

- Live order tracking event logs
- API response from delivery partner
- JSON location updates

This data may show where a delivery partner is, when an order status changed, or how the delivery system responded.

### Unstructured Data

- Customer review text
- Food images
- Support chat messages
- Delivery call recordings

This data may help the company understand customer experience, food quality, and support issues.

## Real-World Example: Marketing Campaign

Marketing platforms also generate different data types.

### Structured Data

- Campaign name
- Impressions
- Clicks
- Cost
- Conversions

This data can be stored in tables and used for campaign performance reports.

### Semi-Structured Data

- API campaign response
- Event tracking payloads
- Clickstream logs

This data often comes from marketing platforms and websites.

### Unstructured Data

- Ad creatives
- Video ads
- Customer comments
- Feedback messages

This data can help teams understand audience reaction and creative performance.

## How Data Engineers Handle Each Type

| Data Type | What Data Engineer Usually Does |
| --- | --- |
| Structured Data | Store in a database or warehouse, write SQL queries, clean and transform tables. |
| Semi-Structured Data | Parse JSON, XML, or logs, extract useful fields, and convert them to structured format. |
| Unstructured Data | Store in a data lake, extract metadata, use AI or ML tools where required, and connect to downstream systems. |

## Where Different Data Types Are Stored

Structured data is commonly stored in:

- Databases
- Data warehouses

Semi-structured data is commonly stored in:

- Data lakes
- Object storage
- NoSQL databases
- Warehouse columns that support JSON

Unstructured data is commonly stored in:

- Data lakes
- Object storage
- Document storage
- Media storage

High-level tool examples:

- Azure Data Lake
- Google Cloud Storage
- BigQuery
- Azure Synapse
- Snowflake
- MongoDB

You do not need to master these tools today. The goal is to understand that different data types often need different storage choices.

## Common Beginner Mistakes

- Thinking all data is stored in tables.
- Thinking SQL is enough for every data type.
- Thinking images and videos are not data.
- Confusing semi-structured and unstructured data.
- Ignoring logs and event data.
- Not checking data format before processing.

These mistakes are normal at the beginning. The solution is to always ask: "How is this data organized?"

## Why This Topic Matters Before Learning SQL

SQL mostly works with structured data. That is why many beginners start with tables.

But real-world Data Engineering involves many formats:

- Tables
- JSON
- Logs
- Files
- Images
- Documents
- Videos

Future lessons will start with structured data first because it is easier to learn. After that, this repository will slowly move into semi-structured data and cloud storage concepts.

## Key Takeaways

- Not all data looks the same.
- Data type means the format or structure of data.
- Structured data is organized in rows and columns.
- Semi-structured data has some organization but may not fit neatly into tables.
- Unstructured data has no fixed table-like structure.
- SQL is easiest to use with structured data.
- APIs commonly return semi-structured data like JSON.
- Images, videos, emails, and documents are also data.
- Data engineers choose storage and processing methods based on data type.
- Understanding data types makes future SQL, database, and cloud lessons easier.

## Next Day Preview

Day 004 will explain databases, data warehouses, and data lakes.

