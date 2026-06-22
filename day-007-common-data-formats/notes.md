# Day 007 Notes - Common Data Formats

## What a Data Format Is

A data format is the way data is organized and stored in a file or message. The format tells tools how to read the data.

Examples include CSV, JSON, XML, Parquet, and Avro.

## Why File Formats Matter

File formats matter because they affect:

- Readability
- Storage size
- Processing speed
- Analytics performance
- Schema handling
- Data lake design
- Batch and streaming pipeline design

The same business information can be stored in many formats, but each format has strengths and limitations.

## CSV

CSV stands for Comma-Separated Values. It stores tabular data as text.

CSV is useful for simple exports, manual sharing, Excel-friendly reports, and beginner learning.

CSV is limited because it does not strongly store data types, does not handle nested data well, and can become inefficient for large analytics workloads.

## JSON

JSON stands for JavaScript Object Notation. It uses key-value pairs and can support nested data.

JSON is common in APIs, logs, web applications, mobile applications, and event tracking.

JSON is flexible, but nested JSON may need parsing and flattening before reporting.

## XML

XML stands for Extensible Markup Language. It uses tags to describe data.

XML is common in legacy systems, banking, insurance, government systems, and document exchange.

XML can support validation through schemas, but it is verbose and often larger than JSON.

## Parquet

Parquet is a columnar file format used for analytics and data lakes.

Columnar means values are organized by column. This helps analytical tools read only the columns needed for a query.

Parquet is efficient for large datasets, compression, and cloud data lake analytics. It is not normally opened manually like CSV.

## Avro

Avro is a row-based serialization format often used in pipelines and streaming systems.

Serialization means converting data into a format that can be stored or transferred between systems.

Avro is compact and supports schema evolution, which means the structure can change over time in a controlled way.

## Human-Readable Formats

Human-readable formats can be opened and inspected more easily.

Examples:

- CSV
- JSON
- XML

They are useful for learning, debugging, and manual sharing, but they are not always best for large production analytics.

## Machine-Optimized Formats

Machine-optimized formats are designed for efficient storage and processing.

Examples:

- Parquet
- Avro

They usually require tools to read, but they can be much better for large-scale systems.

## Row-Based Formats

Row-based formats store records row by row or object by object.

Examples:

- CSV
- JSON
- XML
- Avro

Row-based formats can be useful when systems process one full record at a time.

## Columnar Formats

Columnar formats store data by columns.

Parquet is the main beginner example.

Columnar storage is useful for analytics because reports often need only a few columns from a large dataset.

## Nested Data

Nested data means data inside data.

Example: an order may contain customer details and multiple item records inside one JSON object.

Nested data is common in JSON, XML, Avro, and Parquet. It often needs extra processing before dashboards can use it.

## Schema

A schema describes the structure of data.

Example:

```text
customer_id: number
customer_name: text
signup_date: date
```

Schemas help systems understand expected fields and data types.

## Schema Evolution

Schema evolution means the data structure changes over time in a controlled way.

Example: an event record starts with `customer_id` and `amount`, then later adds `currency`.

Avro is known for supporting schema evolution well.

## Compression

Compression reduces file size. Smaller files can reduce storage cost and sometimes improve processing speed.

Parquet commonly supports strong compression for analytical workloads.

## Storage Efficiency and Analytics Performance

Text formats like CSV, JSON, and XML are easier to inspect, but may be larger and slower for large analytics workloads.

Formats like Parquet are more efficient for analytics because they support compression, schema, and columnar reads.

## File Format Problems

Common problems:

- Missing CSV header
- Wrong delimiter
- Invalid JSON
- XML tag mismatch
- Schema mismatch
- Date format differences
- Numbers stored as text
- Different null representations
- Unexpected new fields

## Formats and Data Lakes

Data lakes can store many formats.

Raw zones may store CSV, JSON, XML, or Avro. Clean zones often use Parquet because it is efficient for analytics.

## Formats and ETL / ELT

ETL and ELT pipelines often convert formats.

Examples:

- CSV to Parquet
- JSON to table
- XML to structured table
- Avro event to warehouse table

## Formats and Batch / Streaming

Batch pipelines often process files such as CSV, JSON, XML, Parquet, and Avro.

Streaming pipelines often process JSON events, Avro messages, or other serialized messages.

## Azure and Google Cloud at a High Level

Azure Data Lake Storage and Google Cloud Storage can store many file formats.

Azure Data Factory, Azure Databricks, BigQuery, Dataflow, and similar tools can move or process common formats.

Tool names may change, but format knowledge remains useful.

## How Data Engineers Decide Which Format to Use

Data engineers ask:

- Is the data small or large?
- Is it tabular or nested?
- Does a business user need to open it?
- Is query performance important?
- Is compression important?
- Does the data need schema evolution?
- Is the data batch or streaming?
- Do downstream tools support the format?

