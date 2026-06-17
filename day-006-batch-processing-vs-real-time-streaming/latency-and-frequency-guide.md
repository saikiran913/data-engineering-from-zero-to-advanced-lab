# Day 006 Latency and Frequency Guide

## What is Latency?

Latency is the delay between data being created and the processed result becoming available.

Example:

```text
Order placed at 10:00 AM
Dashboard updated at 10:15 AM
Latency = about 15 minutes
```

## What is Processing Frequency?

Processing frequency means how often data is processed.

Common frequencies:

- Monthly
- Weekly
- Daily
- Hourly
- Every 15 minutes
- Every five minutes
- Every minute
- Continuous

## Latency vs Frequency

Latency and frequency are related, but they are not exactly identical.

If a pipeline runs every hour, the data may have close to one-hour latency. But delays, failures, or long processing time can increase actual latency.

Frequency is the planned schedule. Latency is the real delay experienced by users.

## Business Examples by Latency

| Use Case | Likely Update Requirement | Possible Approach | Reason |
| --- | --- | --- | --- |
| Payroll | Monthly | Batch | Payroll is periodic. |
| Monthly finance report | Monthly | Batch | Complete accuracy matters more than speed. |
| Daily sales dashboard | Daily | Batch | Overnight refresh is often enough. |
| Campaign monitoring | Hourly or every few minutes | Batch or micro-batch | Teams need fresher performance. |
| Inventory availability | Minutes or near real time | Micro-batch or streaming | Stock changes affect customer experience. |
| Delivery tracking | Seconds | Streaming | Customers need current location. |
| Fraud detection | Seconds or less | Streaming | Fast action can reduce risk. |
| Machine safety alert | Very low latency | Streaming | Safety needs quick response. |
| Website engagement dashboard | Minutes | Micro-batch or streaming | Fresh metrics help operations. |
| Recommendation system | Seconds to minutes | Streaming or micro-batch | Recent behavior can improve recommendations. |

## Data Freshness

Fresh data is recently updated data.

Stale data is old data that has not refreshed.

A dashboard should usually show a last updated time so users know how fresh the data is.

A service-level expectation is a simple promise about timing, such as "the dashboard should refresh by 8:00 AM." Delayed data means the data is later than expected.

## Choosing an Appropriate Frequency

Ask:

- How urgent is the result?
- What is the impact of delay?
- How often is source data available?
- What is the cost of frequent processing?
- How complex will monitoring become?
- Who uses the result?
- Does downstream reporting need complete or fresh data?

## Why Faster Is Not Always Better

Faster processing can create:

- Higher infrastructure usage
- Additional monitoring
- More complex failure handling
- Small business value in some cases
- Frequent incomplete data
- Confusion from constantly changing metrics

Choose speed based on business value, not trendiness.

## Practical Beginner Scenarios

| Scenario | Likely Frequency | Explanation |
| --- | --- | --- |
| Monthly payroll | Monthly | Payroll needs complete monthly data. |
| Daily sales report | Nightly | Morning reporting is often enough. |
| Fraud alert | Continuous | Suspicious payments need quick action. |
| Delivery location | Every few seconds | Customers expect fresh tracking. |
| Marketing dashboard | Hourly or daily | Campaign teams may need periodic updates. |
| Website error monitoring | Continuous or every minute | Errors may need fast investigation. |
| Inventory update | Every few minutes or streaming | Stock affects customer purchases. |
| Historical data migration | One-time or batch | It processes large old datasets. |
| Weekly executive report | Weekly | It supports planned review meetings. |
| Machine overheating alert | Continuous | Safety issues need quick response. |

