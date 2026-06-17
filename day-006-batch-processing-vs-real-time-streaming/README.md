# Day 006 - Batch Processing vs Real-Time Streaming

## Learning Goal

By the end of Day 006, you will understand what data processing means, what batch processing means, what real-time streaming means, what latency means, what events are, and why companies choose different processing styles for different business needs.

You will also understand micro-batch processing, why streaming systems are usually more complex, and how batch and streaming connect with ETL and ELT pipelines.

## Connection to Day 005

Day 005 introduced ETL and ELT.

ETL means Extract, Transform, Load. ELT means Extract, Load, Transform. These pipelines can process data in different ways:

- Scheduled batch processing
- Continuous or near-real-time streaming
- Micro-batch processing

Day 006 focuses on when and how frequently data is processed.

## What is Data Processing?

Data processing means reading data, applying operations to it, and producing a useful result.

Common processing operations include:

- Cleaning records
- Removing duplicates
- Validating values
- Calculating totals
- Joining datasets
- Grouping transactions
- Detecting unusual activity
- Updating a dashboard

```text
Raw Data
    |
    v
Processing
    |
    v
Useful Data
```

## Why Processing Time Matters

Different business situations need different processing speeds.

- A monthly finance report can wait.
- A daily sales dashboard may update overnight.
- A payment fraud alert may need a response in seconds.
- A delivery tracking screen needs frequent updates.
- A recommendation system may react to current user activity.

Faster processing usually adds complexity and cost. Streaming is useful, but it is not automatically better than batch processing.

## What is Batch Processing?

Batch processing means collecting data over a period of time and processing the collected data together as one group, called a batch.

Examples:

- Process yesterday's sales every night.
- Calculate employee salaries every month.
- Update a weekly performance report.
- Process a daily CSV file.
- Generate monthly bank statements.
- Refresh a dashboard every morning.

```text
Data Arrives During the Day
    |
    v
Data Accumulates
    |
    v
Scheduled Processing Starts
    |
    v
All Collected Data is Processed
    |
    v
Report or Table is Updated
```

## Simple Batch Example

An online shopping company may use batch processing for daily sales reporting.

1. Customers place orders throughout the day.
2. Orders are stored in the operational database.
3. At midnight, a pipeline extracts that day's orders.
4. The pipeline cleans and transforms the records.
5. Daily sales totals are calculated.
6. Results are loaded into a warehouse.
7. The sales dashboard is refreshed the next morning.

This is suitable for batch processing because the business does not need every order to appear on the sales dashboard within seconds.

## Common Batch Processing Schedules

Batch processing can run:

- Every 15 minutes
- Every hour
- Every night
- Every week
- Every month
- When a file arrives
- When another pipeline finishes

A batch does not always mean once per day. It means data is processed in groups.

## Advantages of Batch Processing

- Simpler to design
- Easier to monitor
- Often less expensive
- Suitable for large accumulated datasets
- Useful when immediate results are not required
- Easier to retry after failure
- Good for scheduled reporting
- Suitable for historical processing
- Easier for beginners to understand

## Limitations of Batch Processing

- Data may not be immediately available.
- Dashboards can show older information.
- Urgent events may not be detected quickly.
- A failed large batch may delay downstream reports.
- Large batches may take longer to process.
- Processing windows may become difficult as data grows.

## What is Real-Time Streaming?

Streaming means processing data continuously, or almost continuously, as new events are created.

Records do not always wait for a large scheduled batch.

Examples:

- Card payment fraud monitoring
- Food delivery location tracking
- Live website activity
- Stock-market event feeds
- IoT sensor monitoring
- Real-time recommendations
- Security alert monitoring
- Live gaming events

```text
Event Created
    |
    v
Event Sent Immediately
    |
    v
Streaming System Receives Event
    |
    v
Event is Processed
    |
    v
Alert, Table, or Dashboard is Updated
```

## What is an Event?

An event is a record of something that happened.

Examples:

- Customer clicked an advertisement.
- User logged into an application.
- Customer completed a payment.
- Sensor recorded a temperature.
- Driver location changed.
- Product was added to a basket.
- Video was started.
- Machine generated an error.

Beginner event example:

```text
Event type: product_added_to_cart
Customer ID: 1001
Product ID: P205
Event time: 2026-06-17 10:15:30
Quantity: 2
```

Streaming systems process many such events over time.

## Simple Streaming Example

A banking fraud-monitoring system may use streaming.

1. A customer makes a card payment.
2. A transaction event is created.
3. The event is sent to a streaming platform.
4. Rules check the amount, location, timing, and previous activity.
5. A suspicious transaction may trigger an alert.
6. The risk team can investigate quickly.

Waiting until the next day would be unsuitable because suspicious payments may need quick action.

## Advantages of Real-Time Streaming

- Information becomes available quickly.
- Urgent issues can be detected sooner.
- Dashboards can show fresher data.
- Customer experiences can respond to current behaviour.
- Operational teams can react quickly.
- Useful for monitoring systems and devices.
- Supports alerts and immediate decisions.

## Limitations of Real-Time Streaming

- More complex architecture
- More difficult monitoring
- Events may arrive late or out of order
- Duplicate events may occur
- Failures must be handled continuously
- Infrastructure may cost more
- Business rules must process events reliably
- Testing can be more difficult
- Not every business problem needs real-time processing

Real-time streaming should not be chosen only because it sounds modern.

## What is Latency?

Latency is the delay between data being created and the processed result becoming available.

Examples:

- One-day latency
- One-hour latency
- Five-minute latency
- Ten-second latency
- Sub-second latency

| Business Requirement | Example Acceptable Latency |
| --- | --- |
| Monthly payroll report | Days or hours |
| Daily sales report | Overnight |
| Marketing campaign monitoring | Minutes or hours |
| Delivery location update | Seconds |
| Fraud alert | Seconds or less |
| Machine safety alert | Very low latency |

"Real time" can mean different things for different businesses.

## Batch vs Real-Time Streaming

| Feature | Batch Processing | Real-Time Streaming |
| --- | --- | --- |
| Processing style | Processes grouped data | Processes events continuously or near continuously |
| When data is processed | On a schedule or trigger | As events arrive |
| Typical latency | Minutes, hours, days, or months | Seconds, sub-seconds, or near real time |
| Data volume handling | Good for large accumulated data | Good for continuous event flow |
| Complexity | Lower | Higher |
| Cost | Often lower | Often higher |
| Monitoring difficulty | Easier | Harder |
| Failure handling | Retry a batch | Handle failures continuously |
| Common use cases | Reports, payroll, reconciliation | Alerts, tracking, monitoring |
| Dashboard freshness | Periodic refresh | Fresher updates |
| Best suited for | Non-urgent processing | Time-sensitive processing |
| Example business case | Daily sales dashboard | Fraud alert |
| Example tools | Data Factory, Databricks, BigQuery, Dataflow | Event Hubs, Pub/Sub, Stream Analytics, Dataflow |
| Beginner difficulty | Easier | Harder |

## What is Micro-Batch Processing?

Micro-batch processing collects very small batches and processes them frequently.

Examples:

- Process new data every 30 seconds.
- Process website events every minute.
- Refresh operational metrics every five minutes.

```text
Events Arrive
    |
    v
Collect for a Short Period
    |
    v
Process Small Batch
    |
    v
Update Result
    |
    v
Repeat
```

Micro-batching sits between traditional batch and continuous streaming.

| Approach | Example Frequency | Simple Meaning |
| --- | --- | --- |
| Traditional batch | Nightly or monthly | Process larger groups on a schedule |
| Micro-batch | Every minute or five minutes | Process small groups frequently |
| Continuous streaming | As events arrive | Process events continuously |

## Batch, Micro-Batch, and Streaming

### Traditional Batch

Process accumulated data at scheduled intervals.

### Micro-Batch

Process small groups of data frequently.

### Continuous Streaming

Process events continuously as they arrive.

The boundaries can vary depending on the platform and business use case.

## Event Time vs Processing Time

Event time means when the event actually happened.

Processing time means when the system processed the event.

Example:

```text
A mobile device records an event at 10:00 AM.
The device temporarily loses internet access.
The event reaches the platform at 10:05 AM.

Event time = 10:00 AM
Processing time = approximately 10:05 AM
```

Late-arriving data can matter because business reports may need to reflect when events happened, not only when they arrived.

## Late-Arriving Events

Streaming events can arrive late because of:

- Network problems
- Offline mobile devices
- Application delays
- System outages
- Retry mechanisms

The data platform must decide how to handle late events.

## Duplicate Events

The same event may be delivered more than once.

Example: a payment system retries sending a transaction event after not receiving confirmation.

Data engineers may use a unique event ID to identify and remove duplicates.

## Out-of-Order Events

Events may not arrive in the same order in which they happened.

Example: Event B happened after Event A, but Event B arrived first.

Streaming systems must consider event time and ordering.

## Full Batch Pipeline Example

```text
Order Database
    |
    v
Nightly Extraction
    |
    v
Raw Storage
    |
    v
Clean Orders
    |
    v
Daily Sales Aggregation
    |
    v
Data Warehouse
    |
    v
Morning Dashboard
```

This pipeline extracts orders at night, prepares daily sales totals, and refreshes the dashboard for the next morning.

## Full Streaming Pipeline Example

```text
Payment Event
    |
    v
Streaming Platform
    |
    v
Validation
    |
    v
Fraud Rules
    |
    v
Alert
    |
    v
Real-Time Monitoring Dashboard
    |
    v
Historical Storage
```

This pipeline processes payment events quickly, creates alerts when needed, and stores history for later reporting.

## Combining Batch and Streaming

Companies often use both approaches.

Fraud-monitoring example:

```text
Streaming path:
Transaction event -> Immediate fraud check -> Alert

Batch path:
All transactions from the day -> Daily reconciliation -> Finance and compliance report
```

The same business system may need streaming for immediate action and batch for complete reporting.

## Lambda and Kappa Architecture at a Very High Level

### Lambda Architecture

Lambda Architecture may use:

- One batch-processing path
- One real-time-processing path
- A serving layer that combines results

It can be powerful, but it may create duplicate logic and complexity.

### Kappa Architecture

Kappa Architecture focuses mainly on a streaming path and may replay stored events when reprocessing is needed.

Beginners do not need to memorize these architecture details yet. Just know that they describe ways to organize batch and streaming systems.

## Batch and Streaming in Azure

Batch-oriented services and uses:

- Azure Data Factory for scheduled pipelines
- Azure Databricks for batch transformations
- Azure Synapse Analytics for analytical processing
- Azure Data Lake Storage for files

Streaming-oriented services and uses:

- Azure Event Hubs for receiving event streams
- Azure Stream Analytics for processing streaming data
- Azure Databricks Structured Streaming for stream processing
- Power BI for selected near-real-time reporting scenarios

## Batch and Streaming in Google Cloud

Batch-oriented services and uses:

- Cloud Storage for files
- BigQuery for analytical processing
- Dataflow for batch processing
- Cloud Composer for workflow orchestration

Streaming-oriented services and uses:

- Pub/Sub for receiving and distributing events
- Dataflow for streaming processing
- BigQuery for storing analytical results
- Looker or Looker Studio for reporting

Cloud tools may evolve, but the core batch and streaming concepts remain important.

## Common Real-World Batch Use Cases

- Daily sales reporting
- Monthly payroll
- Customer data consolidation
- Marketing campaign reporting
- Billing
- Historical data migration
- Monthly finance reconciliation
- Data warehouse refresh
- Machine-learning model training datasets
- Large file processing

## Common Real-World Streaming Use Cases

- Fraud detection
- IoT monitoring
- Delivery tracking
- Live application monitoring
- Security alerts
- Clickstream processing
- Real-time recommendations
- Payment monitoring
- Machine failure alerts
- Online gaming events

## How to Choose Between Batch and Streaming

Ask:

1. How quickly does the business need the result?
2. What happens if the result is delayed?
3. Is the data continuous or file-based?
4. Is an immediate alert required?
5. Can the business accept hourly or daily updates?
6. How complex can the system be?
7. What budget and skills are available?
8. How should failures be handled?
9. Is complete accuracy more important than immediate speed?
10. Does the same use case need both approaches?

| Requirement | Likely Approach |
| --- | --- |
| Daily dashboard | Batch |
| Monthly payroll | Batch |
| Fraud alert | Streaming |
| Live delivery location | Streaming |
| Five-minute website metrics | Micro-batch or streaming |
| Historical migration | Batch |
| End-of-day reconciliation | Batch |

This table gives general guidance, not an absolute rule.

## Common Beginner Confusions

1. Batch processing is not outdated.
2. Streaming is not automatically better.
3. Real-time systems still store historical data.
4. A batch can run every few minutes.
5. Streaming data can still be transformed and loaded.
6. A dashboard labelled live may still have some latency.
7. Micro-batch and streaming are not always identical.
8. Streaming events may arrive late, twice, or out of order.
9. Batch and streaming can exist in the same architecture.
10. Business requirements should determine the approach.
11. Faster processing may increase cost and complexity.
12. Data quality checks are required in both approaches.

## Role of a Data Engineer

| Responsibility | Batch Example | Streaming Example |
| --- | --- | --- |
| Source understanding | Understand daily order table | Understand payment events |
| Data ingestion | Extract nightly data | Receive continuous events |
| Transformation | Clean daily batch | Validate each event |
| Scheduling | Run every night | Keep stream running continuously |
| Validation | Check row counts | Check event structure |
| Duplicate handling | Remove repeated batch records | Remove duplicate events |
| Failure recovery | Retry failed batch | Restart consumer or replay events |
| Monitoring | Track job duration | Track lag and failed events |
| Storage | Load warehouse tables | Store alerts and event history |
| Latency management | Meet dashboard deadline | Keep alert delay low |
| Documentation | Document schedule and rules | Document event fields and logic |
| Supporting downstream teams | Provide daily reports | Provide alerts and fresh metrics |

## Beginner Analogy: Laundry

Batch processing: collect clothes throughout the week and wash them together on Sunday.

Streaming: wash each item soon after it becomes dirty.

Micro-batch: wash a small collection every evening.

Washing every item immediately would be unnecessary in many homes, just as real-time processing is unnecessary for many datasets.

## Beginner Analogy: Public Transport

Batch: a bus waits until the scheduled departure time and carries several passengers together.

Streaming: a taxi leaves when an individual passenger requests a journey.

Micro-batch: a small shuttle departs every few minutes with a small group.

These options differ in frequency, efficiency, cost, and speed.

## What Can Go Wrong?

Common batch problems:

- Scheduled job does not start.
- Source file does not arrive.
- Batch takes too long.
- Duplicate batch is loaded.
- Target table is unavailable.
- Dashboard misses its refresh deadline.

Common streaming problems:

- Events are delayed.
- Duplicate events arrive.
- Events arrive out of order.
- Streaming consumer stops.
- Traffic suddenly increases.
- Malformed events enter the stream.
- Alerts are triggered incorrectly.
- Data is processed but not stored.

## Monitoring Metrics at a Beginner Level

For batch:

- Start time: when the job begins.
- End time: when the job finishes.
- Duration: how long the job ran.
- Number of records processed: how many records were handled.
- Number of failed records: how many records had problems.
- Expected file arrival: whether the input file arrived.
- Last successful run: the most recent successful pipeline run.

For streaming:

- Events received per second: how many events arrive.
- Events processed per second: how many events are handled.
- Processing delay: how far processing is behind.
- Failed events: events that could not be processed.
- Duplicate events: repeated events.
- Backlog: waiting events not processed yet.
- Last event received: most recent event arrival time.

## Key Takeaways

- Data processing turns raw data into useful results.
- Batch processing handles collected data in groups.
- Streaming processes events continuously or near continuously.
- Micro-batch processes small groups frequently.
- An event is a record of something that happened.
- Latency is the delay between creation and usable result.
- Batch is useful for scheduled reports and large historical processing.
- Streaming is useful for urgent alerts and live monitoring.
- Streaming is usually more complex than batch.
- Batch processing is not outdated.
- Faster processing can cost more and require more monitoring.
- Events can arrive late, duplicate, or out of order.
- Many companies use both batch and streaming.
- Business requirements should determine the approach.
- Data engineers manage ingestion, processing, storage, quality, and monitoring.

## Next Day Preview

Day 007 will explain Data Formats used by Data Engineers, including CSV, JSON, Parquet, Avro, and XML.

## Navigation

- Previous: [Day 005 - ETL and ELT](../day-005-etl-and-elt/)
- Next: Day 007 - Common Data Formats - Coming Soon
- [Back to Main Learning Path](../README.md)

