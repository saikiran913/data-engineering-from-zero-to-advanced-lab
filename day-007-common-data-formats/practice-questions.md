# Day 007 Practice Questions

## Section 1: Simple Questions

1. What is a data format?
2. Why do data formats matter in Data Engineering?
3. What does CSV stand for?
4. What does JSON use to store data?
5. What does XML use to describe data?
6. Why is Parquet useful for analytics?
7. Why is Avro useful in pipelines?
8. Which formats are easier for humans to read?
9. Which formats are more machine-optimized?
10. What is nested data?
11. What is a schema?
12. Why can data lakes store many formats?

## Section 2: Identify the Format

Identify the most likely format.

1. Comma-separated sales export
2. API response with key-value pairs
3. Old banking file with tags
4. Large analytics file in a data lake
5. Compact event message with schema
6. Marketing CSV export
7. Nested clickstream event
8. Manually shared report file
9. Enterprise system exchange file
10. Large compressed columnar dataset
11. Configuration file with tags
12. Streaming event payload
13. Warehouse load file
14. Mobile app event log
15. Machine-generated sensor event

## Section 3: Choose the Best Format

Choose a suitable format and explain why.

1. Small business report
2. API response
3. Data lake analytics
4. Streaming event pipeline
5. Legacy enterprise integration
6. Daily marketing export
7. Large historical dataset
8. Nested order data
9. Warehouse loading
10. Manual review by business team
11. Compact event exchange
12. Dashboard source data

## Section 4: Spot the Problem

Identify the issue.

1. CSV file has no header row.
2. CSV file uses semicolons but the pipeline expects commas.
3. JSON file has missing closing braces.
4. XML has `<order>` but closes with `</orders>`.
5. Source sends `order_amt` instead of expected `order_amount`.
6. Dates appear as `2026-06-22`, `22/06/2026`, and `06-22-2026`.
7. Amount is stored as `"2500"` instead of a number.
8. A text file is too large to process manually.
9. Avro producer sends a field the consumer schema does not expect.
10. Nested JSON is loaded directly into a flat dashboard table without flattening.

## Section 5: Think Like a Data Engineer

1. Which format would you use for a small report shared with a business user?
2. Where would you store raw JSON API responses?
3. Would you convert large CSV files to Parquet for analytics? Why?
4. What validation checks would you apply to a daily CSV file?
5. What do downstream users need to know before using a file?
6. Is website clickstream data likely batch or streaming, and which formats might appear?

## Section 6: Mini Assignment

Choose one business scenario:

- E-commerce
- Banking
- Food delivery
- Marketing analytics
- Hospital management
- Video streaming

Document:

1. Possible source systems
2. Possible file or message formats
3. Why each format may appear
4. Where each format should be stored
5. Which format is best for analytics
6. Whether conversion is needed
7. Validation checks required
8. Possible data quality issues
9. Final dashboard or report
10. Business decision supported

## Answer Key

### Section 1

1. A data format is the way data is organized and stored in a file or message.
2. Formats affect reading, storage, processing, performance, cost, and usability.
3. Comma-Separated Values.
4. Key-value pairs.
5. Tags.
6. Parquet is columnar, compressed, and efficient for analytical queries.
7. Avro is compact and supports schema handling and schema evolution.
8. CSV, JSON, and XML.
9. Parquet and Avro.
10. Data inside other data.
11. A schema describes the expected structure of data.
12. Data lakes are flexible storage areas for many file types.

### Section 2

1. CSV
2. JSON
3. XML
4. Parquet
5. Avro
6. CSV
7. JSON
8. CSV or Excel-style export
9. XML
10. Parquet
11. XML
12. JSON or Avro
13. CSV, JSON, Parquet, or Avro depending on system support
14. JSON
15. JSON or Avro

### Section 3

1. CSV is often suitable.
2. JSON is common.
3. Parquet is often suitable.
4. Avro or JSON may be suitable.
5. XML may be suitable.
6. CSV is common.
7. Parquet is often suitable for analytics.
8. JSON is often suitable.
9. CSV, JSON, Parquet, or Avro may work depending on the warehouse.
10. CSV is often easiest.
11. Avro may be suitable.
12. Warehouse table or Parquet-backed analytics data may be suitable.

### Section 4

1. Missing header.
2. Wrong delimiter.
3. Invalid JSON.
4. XML tag mismatch.
5. Unexpected column name or schema mismatch.
6. Inconsistent date formats.
7. Number stored as text.
8. File too large for manual processing.
9. Schema mismatch.
10. Nested data not flattened for reporting.

