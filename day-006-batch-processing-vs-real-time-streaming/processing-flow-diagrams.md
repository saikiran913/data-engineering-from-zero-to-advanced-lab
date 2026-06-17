# Day 006 Processing Flow Diagrams

## Diagram 1: Basic Batch Processing

```text
Data Accumulates
    |
    v
Scheduled Job Starts
    |
    v
Batch is Processed
    |
    v
Result is Stored
    |
    v
Dashboard Refreshes
```

Approach: batch. This is useful when data can wait until a scheduled job runs.

## Diagram 2: Basic Streaming

```text
Event Occurs
    |
    v
Event is Published
    |
    v
Stream Receives Event
    |
    v
Event is Processed
    |
    v
Result or Alert is Produced
```

Approach: streaming. This is useful when events need quick processing.

## Diagram 3: Micro-Batch

```text
Events Arrive
    |
    v
Collect for One Minute
    |
    v
Process Small Batch
    |
    v
Update Table
    |
    v
Repeat
```

Approach: micro-batch. This processes small groups frequently.

## Diagram 4: Daily Sales Batch

```text
Order Database
    |
    v
Nightly Extraction
    |
    v
Clean and Transform
    |
    v
Daily Sales Table
    |
    v
Morning Dashboard
```

Approach: batch. This supports daily sales reporting.

## Diagram 5: Fraud Streaming

```text
Payment Event
    |
    v
Streaming Platform
    |
    v
Fraud Rules
    |
    v
Risk Score
    |
    v
Alert or Approval
    |
    v
Historical Storage
```

Approach: streaming. This supports fast fraud checks and later history.

## Diagram 6: Combined Batch and Streaming

```text
Transaction Source
    |
    +-- Streaming Path -> Immediate Fraud Alert
    |
    +-- Batch Path -> End-of-Day Reconciliation Report
```

Approach: combined. The same source supports immediate action and complete reporting.

## Diagram 7: Delivery Tracking

```text
Driver Location Event
    |
    v
Event Platform
    |
    v
Location Processing
    |
    v
Latest Location Store
    |
    v
Customer Map
```

Approach: streaming. The customer map needs frequent updates.

## Diagram 8: IoT Monitoring

```text
Machine Sensor
    |
    v
Temperature Event
    |
    v
Streaming Processor
    |
    v
Threshold Check
    |
    +-- Normal -> Store Reading
    |
    +-- Dangerous -> Generate Alert
```

Approach: streaming. Safety-related readings may need quick alerts.

