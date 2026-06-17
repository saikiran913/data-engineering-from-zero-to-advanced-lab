# Day 006 Glossary

| Term | Simple Meaning | Beginner Example |
| --- | --- | --- |
| Data Processing | Reading data and producing a useful result. | Calculate daily sales from order records. |
| Batch Processing | Processing collected data as a group. | Process yesterday's orders at midnight. |
| Streaming | Processing events continuously or near continuously. | Process payment events as they happen. |
| Real-Time Processing | Processing with very low delay. | Generate a fraud alert within seconds. |
| Near Real Time | Processing quickly, but not instantly. | Update a dashboard every minute. |
| Micro-Batch | Processing small batches frequently. | Process events every 30 seconds. |
| Event | A record of something that happened. | User clicked an ad. |
| Event Stream | A continuous flow of events. | Driver location updates flowing into a platform. |
| Producer | A system that creates or sends events. | A mobile app sends location events. |
| Consumer | A system that reads or processes events. | A fraud service reads payment events. |
| Message | A single piece of data sent between systems. | One payment event message. |
| Message Broker | A system that receives and distributes messages. | Pub/Sub or Azure Event Hubs. |
| Latency | Delay between creation and usable result. | A dashboard updates five minutes after an order. |
| Processing Frequency | How often data is processed. | Nightly, hourly, every minute, or continuously. |
| Data Freshness | How recently data was updated. | A dashboard updated two minutes ago is fresher than yesterday's. |
| Stale Data | Old data that has not refreshed. | A sales dashboard still showing last week's numbers. |
| Event Time | When the event actually happened. | Payment happened at 10:00 AM. |
| Processing Time | When the system processed the event. | Payment event processed at 10:01 AM. |
| Late-Arriving Event | An event that arrives after it happened. | A phone sends offline activity later. |
| Duplicate Event | The same event arrives more than once. | A payment event is retried and sent twice. |
| Out-of-Order Event | Events arrive in a different order than they happened. | Event B arrives before Event A. |
| Backlog | Events waiting to be processed. | Thousands of events queued after a delay. |
| Throughput | Amount of data processed over time. | Events processed per second. |
| Scheduled Job | A process that runs at a planned time. | Daily sales job runs at 1:00 AM. |
| Trigger | Something that starts a process. | A file arrival starts a pipeline. |
| Streaming Pipeline | A pipeline that processes events continuously. | Payment stream to fraud alerts. |
| Batch Pipeline | A pipeline that processes grouped data. | Nightly order processing. |
| Historical Data | Past data stored for later use. | Last year's transactions. |
| Alert | A notification that something needs attention. | Machine temperature is too high. |
| Retry | Trying a failed action again. | Resend a failed event. |
| Failure Recovery | Steps to recover from problems. | Rerun a failed batch. |
| Monitoring | Watching systems for health and issues. | Track pipeline failures and delays. |
| Reprocessing | Processing data again. | Rebuild yesterday's sales table. |
| Reconciliation | Comparing data to confirm it matches. | Compare payment source and finance report totals. |
| Pub/Sub | Google Cloud service for event messaging. | Receive website click events. |
| Azure Event Hubs | Azure service for event streams. | Receive device telemetry events. |
| Dataflow | Google Cloud service for batch and streaming processing. | Process event streams or files. |
| Azure Stream Analytics | Azure service for streaming data processing. | Process live IoT events. |

