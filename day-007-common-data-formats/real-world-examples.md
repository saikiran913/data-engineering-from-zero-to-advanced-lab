# Day 007 Real-World Examples

## Example 1: E-commerce Order CSV Export

| Topic | Details |
| --- | --- |
| Business situation | An online store exports daily order data for reporting. |
| Data format used | CSV |
| Why this format may be used | It is simple, tabular, and easy to open in spreadsheet tools. |
| Sample fields | order_id, customer_id, order_date, amount, status |
| Where data is stored | Raw data lake folder or shared reporting location. |
| How a data engineer may process it | Validate headers, clean dates, convert amounts to numbers, load into a warehouse. |
| Possible data quality issue | Missing header or wrong delimiter. |
| Final reporting or analytics use | Daily sales dashboard. |
| Business decision supported | Track revenue and order volume. |

## Example 2: API Response in JSON

| Topic | Details |
| --- | --- |
| Business situation | A payment system sends payment status through an API. |
| Data format used | JSON |
| Why this format may be used | APIs commonly use JSON because it is flexible and readable. |
| Sample fields | payment_id, order_id, status, amount, timestamp |
| Where data is stored | Raw JSON storage, then warehouse tables after processing. |
| How a data engineer may process it | Parse JSON, extract fields, flatten nested sections, validate payment status. |
| Possible data quality issue | Missing field or invalid JSON. |
| Final reporting or analytics use | Payment success dashboard. |
| Business decision supported | Investigate failed payments. |

## Example 3: Banking XML File Exchange

| Topic | Details |
| --- | --- |
| Business situation | A bank exchanges transaction or statement data with another enterprise system. |
| Data format used | XML |
| Why this format may be used | XML is common in older and enterprise integrations. |
| Sample fields | account_id, transaction_id, amount, transaction_date |
| Where data is stored | Secure file storage or raw data lake zone. |
| How a data engineer may process it | Validate tags, parse XML, convert selected fields into structured tables. |
| Possible data quality issue | Opening and closing tags do not match. |
| Final reporting or analytics use | Transaction reconciliation report. |
| Business decision supported | Confirm transaction totals and support audit. |

## Example 4: Data Lake Storing Parquet Files

| Topic | Details |
| --- | --- |
| Business situation | A company stores large cleaned sales datasets for analytics. |
| Data format used | Parquet |
| Why this format may be used | It is efficient, compressed, and good for column-based analytical queries. |
| Sample fields | date, country, product_id, sales_amount |
| Where data is stored | Clean zone of a data lake. |
| How a data engineer may process it | Convert raw CSV or JSON into Parquet, organize files, validate schema. |
| Possible data quality issue | Schema mismatch between files. |
| Final reporting or analytics use | Sales analytics and warehouse external tables. |
| Business decision supported | Understand performance by country and product. |

## Example 5: Streaming Pipeline Using Avro

| Topic | Details |
| --- | --- |
| Business situation | A streaming system sends transaction events between services. |
| Data format used | Avro |
| Why this format may be used | It is compact and supports schema evolution. |
| Sample fields | event_id, transaction_id, amount, event_time |
| Where data is stored | Streaming platform and historical event storage. |
| How a data engineer may process it | Read messages with schema, validate event fields, load results into analytical storage. |
| Possible data quality issue | Producer and consumer expect different schema versions. |
| Final reporting or analytics use | Transaction monitoring and event history. |
| Business decision supported | Monitor payment activity and system reliability. |

## Example 6: Marketing Platform Campaign Export

| Topic | Details |
| --- | --- |
| Business situation | A marketing platform exports campaign performance daily. |
| Data format used | CSV or JSON |
| Why this format may be used | CSV is common for manual exports; JSON is common for API exports. |
| Sample fields | campaign_id, impressions, clicks, cost, conversions |
| Where data is stored | Raw marketing folder in a data lake. |
| How a data engineer may process it | Standardize campaign names, calculate click-through rate, load campaign table. |
| Possible data quality issue | Numbers stored as text or missing campaign ID. |
| Final reporting or analytics use | Marketing performance dashboard. |
| Business decision supported | Adjust campaign budget. |

## Example 7: Website Clickstream Events

| Topic | Details |
| --- | --- |
| Business situation | A website tracks user activity such as page views and clicks. |
| Data format used | JSON events |
| Why this format may be used | JSON supports flexible event fields and nested properties. |
| Sample fields | event_id, event_type, page_url, user_id, event_time |
| Where data is stored | Event stream, raw data lake, or analytics warehouse after processing. |
| How a data engineer may process it | Parse events, remove duplicates, flatten nested fields, group activity by page. |
| Possible data quality issue | Duplicate event IDs or missing event time. |
| Final reporting or analytics use | Website engagement dashboard. |
| Business decision supported | Improve website experience and content placement. |

## Example 8: Hospital Document and Reporting Data

| Topic | Details |
| --- | --- |
| Business situation | A hospital manages appointments, forms, reports, and operational dashboards. |
| Data format used | XML, CSV, PDF, and Parquet depending on the source and use case. |
| Why this format may be used | Enterprise systems may export XML, reports may export CSV, and analytics data may be stored as Parquet. |
| Sample fields | appointment_id, department, appointment_date, status |
| Where data is stored | Raw data lake and reporting warehouse. |
| How a data engineer may process it | Parse XML, validate CSV files, convert cleaned appointment data to Parquet or tables. |
| Possible data quality issue | Inconsistent department names or unexpected file structure. |
| Final reporting or analytics use | Appointment and waiting-time dashboard. |
| Business decision supported | Improve scheduling and department staffing. |

