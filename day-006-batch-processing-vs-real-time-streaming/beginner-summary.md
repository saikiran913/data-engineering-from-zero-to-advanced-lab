# Day 006 Beginner Summary

Data processing means taking raw data, applying useful operations to it, and producing a result that people or systems can use. Processing may include cleaning records, removing duplicates, validating values, calculating totals, joining datasets, detecting unusual activity, or updating dashboards.

Batch processing means collecting data over a period of time and processing it together as one group. For example, an online store may collect orders throughout the day and process them at midnight. The pipeline can clean the orders, calculate daily sales, load the result into a data warehouse, and refresh the dashboard in the morning. Batch processing is useful when the business does not need immediate results.

Streaming means processing data continuously, or almost continuously, as new events are created. An event is a record of something that happened, such as a payment completed, a product added to a basket, a driver location changed, or a machine temperature recorded. Streaming is useful when a company needs to react quickly, such as detecting payment fraud, tracking food delivery, monitoring machines, or showing live website activity.

Micro-batch processing sits between traditional batch and streaming. Instead of processing once per day or continuously for every event, micro-batch processing collects small groups of data and processes them frequently. For example, a system may process website events every minute or update operational metrics every five minutes.

Latency means the delay between data being created and the processed result becoming available. If an order happens at 10:00 AM and the dashboard shows it at 10:15 AM, the latency is about 15 minutes. Different businesses accept different latency. Monthly payroll can wait. A daily sales report may update overnight. A fraud alert may need to happen in seconds.

Batch processing has many advantages. It is usually simpler to design, easier to monitor, often less expensive, and good for large historical datasets. It is also easier for beginners to understand. However, batch processing has limitations. Data may not be available immediately, dashboards may show older information, urgent events may be detected too late, and failed large batches can delay many reports.

Streaming also has important advantages. It makes information available quickly, supports alerts, helps teams react to current activity, and is useful for monitoring systems, devices, and user behavior. But streaming is usually more complex. Events may arrive late, arrive more than once, or arrive out of order. Streaming systems also need continuous monitoring, careful failure handling, and often more infrastructure.

Batch processing remains important because not every problem needs real-time processing. A monthly finance report, payroll process, historical migration, or daily warehouse refresh may work perfectly well as a batch job. Choosing streaming only because it sounds modern can increase cost and complexity without adding business value.

Many companies use both batch and streaming. For example, a bank may use streaming to check each transaction quickly for fraud, but also use batch processing at the end of the day for reconciliation and compliance reports. The same source data can support immediate action and complete reporting.

Data engineers manage these choices. They understand the business requirement, choose the processing style, design ingestion, apply transformations, store results, monitor pipelines, handle failures, manage duplicates, and make sure downstream teams receive useful data.

They also help explain freshness expectations to business users. A dashboard that updates once per day is not wrong if the business agreed to daily reporting. A fraud alert that arrives late is a bigger concern because the business need is urgent. This is why clear expectations about latency and frequency matter before building the pipeline.

Before Day 007, remember this: batch, micro-batch, and streaming are different ways to process data over time. None is always best. The correct choice depends on business urgency, acceptable latency, cost, complexity, source data pattern, and the value of faster information.
