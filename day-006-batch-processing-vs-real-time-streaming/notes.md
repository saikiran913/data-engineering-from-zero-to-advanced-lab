# Day 006 Notes - Batch Processing vs Real-Time Streaming

## Data Processing

Data processing means reading data, applying operations to it, and producing a useful result. Processing can include cleaning, validation, joining, aggregation, alerting, and dashboard updates.

## Batch Processing

Batch processing collects data over a period of time and processes it together. It is useful when the business does not need immediate results.

Examples include daily sales reports, monthly payroll, weekly campaign reports, historical migration, and data warehouse refreshes.

Advantages:

- Easier to design and monitor
- Often lower cost
- Good for large historical data
- Easier to retry after failure

Limitations:

- Data can be stale
- Urgent issues may be detected late
- Large jobs can take a long time
- Failed jobs can delay many reports

## Streaming Processing

Streaming processing handles events continuously, or almost continuously, as they arrive.

Examples include fraud detection, delivery tracking, live application monitoring, IoT alerts, security alerts, and real-time recommendations.

Advantages:

- Fresh information
- Faster alerts
- Better live operational visibility
- Useful for immediate decisions

Limitations:

- More complex architecture
- More monitoring required
- Late, duplicate, and out-of-order events are common concerns
- Higher cost in many cases
- Testing and failure handling can be harder

## Processing Frequency

Processing frequency describes how often data is processed.

Examples:

- Monthly
- Weekly
- Daily
- Hourly
- Every 15 minutes
- Every minute
- Continuously

A batch can run frequently. Batch does not only mean daily.

## Latency

Latency is the delay between data being created and the processed result becoming available.

Examples:

- Payroll may allow days of latency.
- Daily sales may allow overnight latency.
- Fraud alerts may need seconds or less.
- Machine safety alerts may need very low latency.

## Events

An event is a record of something that happened.

Examples:

- User logged in
- Payment completed
- Product added to cart
- Sensor temperature recorded
- Driver location changed

## Event Time and Processing Time

Event time is when the event actually happened.

Processing time is when the system processed the event.

If a mobile app records an event at 10:00 AM but sends it at 10:05 AM, the event time is 10:00 AM and processing time is around 10:05 AM.

## Late-Arriving Events

Late-arriving events are events that reach the platform after they happened. They can happen because of network problems, offline devices, retries, outages, or application delays.

## Duplicate Events

Duplicate events happen when the same event arrives more than once. A unique event ID can help identify duplicates.

## Out-of-Order Events

Out-of-order events arrive in a different order from how they happened. Streaming systems often need to consider event time, not only arrival order.

## Micro-Batching

Micro-batching processes small groups of data frequently, such as every 30 seconds or every five minutes. It sits between traditional batch and continuous streaming.

## Common Batch Use Cases

- Daily sales reporting
- Monthly payroll
- Billing
- Customer data consolidation
- Historical data migration
- Finance reconciliation
- Large file processing

## Common Streaming Use Cases

- Fraud detection
- Delivery tracking
- IoT monitoring
- Security alerts
- Clickstream processing
- Payment monitoring
- Live application monitoring

## Why Companies Combine Both

Many companies need streaming for immediate actions and batch for complete reporting.

Example:

```text
Transaction event -> Streaming fraud alert
All daily transactions -> Batch reconciliation report
```

## Batch and Streaming ETL/ELT

ETL and ELT describe the order of extraction, loading, and transformation. Batch and streaming describe how often data is processed.

Examples:

- Batch ETL: Extract yesterday's orders, transform them, load a sales table.
- Batch ELT: Load daily raw files, transform them later in a warehouse.
- Streaming ETL/ELT: Process events continuously and store alerts or analytical results.

## Azure Services at a High Level

Batch examples:

- Azure Data Factory for scheduled pipelines
- Azure Databricks for transformations
- Azure Synapse Analytics for analytical processing
- Azure Data Lake Storage for files

Streaming examples:

- Azure Event Hubs for event streams
- Azure Stream Analytics for stream processing
- Azure Databricks Structured Streaming for streaming workloads

## Google Cloud Services at a High Level

Batch examples:

- Cloud Storage for files
- BigQuery for analytics
- Dataflow for batch processing
- Cloud Composer for orchestration

Streaming examples:

- Pub/Sub for receiving and distributing events
- Dataflow for streaming processing
- BigQuery for storing results

## Monitoring Considerations

Batch monitoring:

- Start time
- End time
- Duration
- Records processed
- Failed records
- File arrival
- Last successful run

Streaming monitoring:

- Events received per second
- Events processed per second
- Processing delay
- Backlog
- Failed events
- Duplicate events
- Last event received

## Failure Recovery Concepts

Batch recovery may involve retrying a failed job, reloading a file, or rerunning a date range.

Streaming recovery may involve restarting a consumer, replaying events, handling backlog, or correcting duplicate and late events.

## Business Requirements Determine Architecture

The correct approach depends on business needs. If a report can wait until morning, batch may be best. If a safety alert must happen quickly, streaming may be required.

The best data engineers ask business questions before choosing architecture.

