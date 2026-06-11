# Day 004 Comparison Guide

## Quick Comparison Table

| Category | Database | Data Warehouse | Data Lake |
| --- | --- | --- | --- |
| Main purpose | Run applications and transactions | Support reporting and analytics | Store raw, mixed, and large data |
| Best for | Current operational data | Clean business-ready data | Raw files and many formats |
| Data format | Mostly structured | Mostly structured | Structured, semi-structured, and unstructured |
| Data condition | Current and operational | Cleaned and transformed | Raw or semi-processed |
| Users | Applications, operations teams | Analysts, reporting teams, dashboard tools | Data engineers, data scientists, advanced analytics teams |
| Query style | Look up or update specific records | Large queries and summaries | Depends on file type and processing tool |
| Example tools | MySQL, PostgreSQL, SQL Server, Azure SQL | BigQuery, Azure Synapse, Snowflake, Redshift | Azure Data Lake, Google Cloud Storage, Amazon S3 |
| Example data | Login details, live order, payment status | Daily sales, monthly revenue, campaign performance | CSV exports, JSON logs, PDFs, images |
| Speed priority | Fast transactions | Fast analysis over large data | Flexible storage and access |
| Storage style | Tables | Reporting tables | Files, folders, objects, and sometimes tables |
| Beginner understanding | App storage | Report storage | Raw and mixed file storage |

## When to Use a Database

Use a database when an application needs to store and retrieve current business data.

Examples:

- A user logs into a mobile app.
- A customer places an order.
- A student registers for a course.
- A bank saves a payment transaction.
- A hospital books an appointment.

The database helps the application work properly and quickly.

## When to Use a Data Warehouse

Use a data warehouse when teams need clean data for dashboards, reports, and analysis.

Examples:

- Total sales by month
- Country-wise revenue
- Campaign performance
- Customer purchase history
- Department-wise hospital appointments

The data warehouse is usually not the first place where app data is created. It receives cleaned and transformed data for analytics.

## When to Use a Data Lake

Use a data lake when companies need to store raw data, mixed formats, or large files.

Examples:

- Raw CSV exports
- JSON API responses
- Application logs
- Product images
- PDF invoices
- Videos
- Historical files

The data lake is useful when the company wants to preserve original data and process it later.

## Can a Company Use All Three?

Yes. Most modern companies use all three together.

```text
Database -> Data Lake -> Data Warehouse -> Dashboard
```

Why this flow is useful:

- The database helps the app run.
- The data lake keeps raw and mixed data safely.
- The data warehouse stores clean reporting data.
- The dashboard helps business users make decisions.

Each system has a different job. Together, they create a reliable data flow.

## Common Interview-Style Explanation

Simple answer:

"A database stores application data, a data lake stores raw or mixed data, and a data warehouse stores cleaned business-ready data for reporting."

Expanded answer:

A database is used by applications for daily transactions, such as orders, payments, logins, and appointments. A data lake stores raw files and different formats, such as CSV, JSON, logs, PDFs, images, and videos. A data warehouse stores clean and structured data that analysts and dashboard tools use for reports and business decisions.

