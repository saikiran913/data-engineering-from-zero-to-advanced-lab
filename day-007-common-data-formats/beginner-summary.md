# Day 007 Beginner Summary

A data format is the way data is organized and stored in a file or message. Data engineers need to understand formats because data moves between many systems. A source system may export a CSV file, an API may return JSON, an older enterprise system may send XML, a data lake may store Parquet, and a streaming pipeline may use Avro.

CSV stands for Comma-Separated Values. It stores simple tabular data in rows and columns, with values separated by commas. CSV is easy to read, easy to open in spreadsheet tools, and useful for small business reports or beginner learning. However, CSV does not strongly store data types, does not support nested data well, and is not ideal for very large analytics workloads.

JSON stands for JavaScript Object Notation. It stores data using key-value pairs, such as `"customer_id": 101`. JSON is common in APIs, web applications, mobile applications, logs, and event tracking. It is human-readable and supports nested data, which means data can contain other data inside it. The challenge is that nested JSON often needs parsing and flattening before it can be used in reports.

XML stands for Extensible Markup Language. XML stores data using tags, such as `<customer_id>101</customer_id>`. XML is older than JSON in many modern systems, but it is still important in enterprise integrations, banking, insurance, government systems, configuration files, and document exchange. XML is readable and self-descriptive, but it can be verbose and larger than lighter formats.

Parquet is a columnar file format commonly used for analytics and data lakes. Columnar means values are organized by column instead of simple row-by-row text. This is useful when a query needs only a few columns from a large dataset. Parquet supports compression and schema information, which can reduce storage cost and improve query performance. Parquet is not usually opened manually like CSV. It is normally read by data tools.

Avro is a row-based serialization format often used in data pipelines and streaming systems. Serialization means converting data into a format that can be stored or transferred between systems. Avro is compact and supports schema evolution, which means the structure of data can change over time in a controlled way. Avro is useful in event pipelines, but it is not beginner-friendly for manual reading.

Some formats are human-readable, such as CSV, JSON, and XML. These are useful for learning, debugging, and manual inspection. Other formats are machine-optimized, such as Parquet and Avro. These are harder to read directly, but they are usually better for large-scale production systems.

CSV, JSON, XML, and Avro are generally row-based or record-oriented. Parquet is columnar. Columnar storage is especially useful for analytics because reports often read selected columns, such as country and sales amount, rather than every field in every row.

Data formats connect directly with data lakes and warehouses. A data lake can store many raw formats, including CSV, JSON, XML, Parquet, and Avro. Clean analytical data in a data lake is often stored as Parquet. A data warehouse may load data from these formats and store the results in tables for reporting.

Formats also connect with batch and streaming. Batch pipelines often process files such as daily CSV exports, JSON logs, monthly XML files, and Parquet datasets. Streaming pipelines often process JSON events, Avro messages, or other serialized messages.

Before Day 008, remember this: no format is always best. CSV is simple, JSON is flexible, XML is still common in enterprise systems, Parquet is strong for analytics, and Avro is useful for compact event exchange. Data engineers choose formats based on size, structure, readability, performance, storage cost, schema needs, and downstream users.

