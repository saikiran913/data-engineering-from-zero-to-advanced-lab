# Day 007 Storage and Processing Guide

## Formats and Storage

| Format | Common Storage Location | Example |
| --- | --- | --- |
| CSV | Local files, shared folders, raw data lake zones | Daily sales export |
| JSON | APIs, logs, event stores, raw data lake zones | Payment API response |
| XML | Enterprise file exchange, raw data lake zones | Banking transaction file |
| Parquet | Clean data lake zones, analytical platforms | Sales analytics dataset |
| Avro | Streaming systems, ingestion pipelines, event storage | Transaction event message |

## Formats and Data Lakes

Data lakes can store many formats.

- Raw zone may store CSV, JSON, XML, and original exports.
- Cleaned zone may store Parquet for analytics.
- Event zone may store JSON or Avro.
- Reporting layer may use warehouse tables created from these files.

## Formats and Data Warehouses

Warehouses often load data from files and store it in tables.

High-level examples:

- BigQuery can load common analytical formats.
- Azure Synapse can work with files and tables.
- Snowflake can load and query common file formats.

The warehouse usually helps turn files into structured reporting data.

## Formats and ETL / ELT

ETL:

```text
Extract file -> Transform / clean -> Load final table
```

ELT:

```text
Extract file -> Load raw file or table -> Transform later
```

Both patterns often include format validation and format conversion.

## Formats and Batch Processing

Batch pipelines often process files like:

- Daily CSV exports
- JSON log files
- Monthly XML files
- Parquet datasets

Batch processing is common when files arrive on a schedule.

## Formats and Streaming

Streaming pipelines often process messages or events using:

- JSON
- Avro
- Other serialized formats

Streaming formats should be easy for systems to produce, read, and validate quickly.

## Format Conversion

Data engineers often convert formats.

Examples:

- CSV to Parquet for analytics
- JSON to table for reporting
- XML to structured table
- Avro events to warehouse table
- Raw files to clean business tables

## Why Convert CSV to Parquet?

CSV is simple, but Parquet is often better for large analytics because it offers:

- Better compression
- Faster analytics
- Better schema handling
- Less storage cost
- Easier large-scale querying

This does not mean CSV is bad. It means CSV and Parquet solve different problems.

## Common Format Validation Checks

| Check | Why It Matters | Example |
| --- | --- | --- |
| File exists | Pipeline needs an input file | Daily export arrived |
| File is not empty | Empty files can create wrong reports | File has at least one data row |
| Expected columns exist | Required fields must be present | `order_id` exists |
| Column count matches | Rows should follow expected structure | CSV has 5 columns |
| JSON is valid | Invalid JSON cannot be parsed reliably | Braces and quotes are correct |
| XML tags are valid | Broken XML cannot be parsed reliably | Opening and closing tags match |
| Schema matches expectation | Structure should be trusted | Field types match expected schema |
| Date format is valid | Dates are needed for reporting | `2026-06-22` |
| Numeric fields are numeric | Calculations need numbers | Amount is `2500`, not text |
| Required fields are not null | Important fields should not be missing | Customer ID is present |
| File size is reasonable | Too small or too large may signal a problem | File is near expected size |
| Record count is reasonable | Unexpected counts may indicate failure | Around expected daily order count |

