# Day 007 Glossary

| Term | Simple Meaning | Beginner Example |
| --- | --- | --- |
| Data Format | The way data is organized and stored. | Customer data stored as CSV or JSON. |
| File Format | The structure used inside a file. | `.csv`, `.json`, `.xml`, `.parquet`, `.avro`. |
| CSV | Comma-Separated Values; simple tabular text data. | `customer_id,customer_name,country` |
| Delimiter | Character used to separate values. | Comma in a CSV file. |
| Header Row | First row that usually contains column names. | `order_id,amount,date` |
| Row | One record in tabular data. | One customer record. |
| Column | One field in tabular data. | `country` or `amount`. |
| Record | One complete item of data. | One order or one customer. |
| JSON | Format using key-value pairs. | `{ "order_id": 5001 }` |
| Key-Value Pair | A field name and its value. | `"country": "India"` |
| Object | Group of key-value pairs in JSON. | Customer object with ID and name. |
| Array | List of values or objects. | List of order items. |
| Nested Data | Data inside other data. | Order contains customer and items. |
| XML | Tag-based data format. | `<amount>2500</amount>` |
| Tag | Label used in XML. | `<customer_id>` |
| Opening Tag | Start of an XML element. | `<country>` |
| Closing Tag | End of an XML element. | `</country>` |
| Schema | Description of expected structure. | `amount` should be a number. |
| Schema Evolution | Controlled change in data structure over time. | Add a new `currency` field. |
| Serialization | Converting data for storage or transfer. | Convert an event into Avro. |
| Deserialization | Reading serialized data back into usable form. | Read Avro event into fields. |
| Parquet | Columnar format used for analytics. | Sales data stored in a data lake. |
| Columnar Format | Data stored by columns. | Read only country and amount columns. |
| Row-Based Format | Data stored by records or rows. | CSV stores one record per line. |
| Avro | Compact serialized format for pipelines. | Event message with schema. |
| Compression | Reducing file size. | Parquet files use compression. |
| Encoding | Way characters are represented. | UTF-8 text encoding. |
| Null Value | Missing or unknown value. | Blank country field. |
| Data Lake | Storage area for many data formats. | Raw CSV, JSON, and Parquet files. |
| Raw Zone | Area for original data. | API JSON stored as received. |
| Clean Zone | Area for cleaned data. | Cleaned Parquet dataset. |
| File Validation | Checking a file before processing. | Confirm expected columns exist. |
| Parsing | Reading a format and extracting fields. | Extract values from JSON. |
| API Response | Data returned by an API. | Payment status JSON response. |
| Log File | File recording system events. | Website activity logs. |
| Event Message | Message describing something that happened. | Product added to cart event. |

