# Day 006 Practice Questions

## Section 1: Simple Questions

1. What does data processing mean?
2. What is batch processing?
3. What is streaming?
4. What is micro-batch processing?
5. What is an event?
6. What is latency?
7. What is data freshness?
8. What is event time?
9. What is processing time?
10. Why is streaming usually more complex than batch?
11. Why is batch processing still useful?
12. Can one company use both batch and streaming?

## Section 2: Batch, Streaming, Micro-Batch, or Both?

Choose the most suitable approach and explain why.

1. Monthly payroll
2. Live fraud alert
3. Daily sales dashboard
4. Food delivery location
5. Weekly marketing report
6. One-minute website metric refresh
7. Historical data migration
8. Machine overheating alert
9. End-of-day financial reconciliation
10. Live gaming activity
11. Monthly customer statement
12. Recommendation update
13. Application-error alert
14. Nightly inventory report
15. Payment monitoring and daily reporting

## Section 3: Identify the Event

For each situation, identify the event and possible event fields.

1. A customer adds a product to a cart.
2. A user logs into an app.
3. A card payment is completed.
4. A driver location changes.
5. A sensor records high temperature.
6. A video starts playing.
7. A website error occurs.
8. A customer clicks an advertisement.
9. A player completes a game level.
10. A support message is sent.

## Section 4: Understand Latency

Choose an acceptable latency and explain why.

1. Monthly payroll report
2. Daily sales dashboard
3. Fraud alert
4. Delivery tracking screen
5. Weekly executive report
6. Machine safety alert
7. Marketing campaign dashboard
8. Website error alert
9. Historical data migration
10. Recommendation update

## Section 5: Identify the Problem

Identify the likely issue.

1. An event happened at 10:00 AM but arrived at 10:10 AM.
2. The same payment event arrived twice.
3. Event B arrived before Event A, even though A happened first.
4. A dashboard still shows yesterday's values.
5. A daily input file did not arrive.
6. A scheduled job did not start.
7. Events are arriving faster than they are processed.
8. Processing delay keeps increasing.
9. An alert is triggered for a normal transaction.
10. The same batch was loaded twice.

## Section 6: Design a Simple Flow

Draw a text-based processing flow for:

1. Daily sales reporting
2. Fraud alerting
3. Food delivery location tracking
4. Monthly payroll
5. Website clickstream monitoring

## Section 7: Think Like a Data Engineer

1. What business questions would you ask before choosing batch or streaming?
2. What data quality checks would you add to a streaming fraud pipeline?
3. How would you handle duplicate events in a payment stream?
4. What monitoring checks would you add to a nightly batch job?
5. When might micro-batch be a good compromise?

## Section 8: Mini Assignment

Choose one scenario:

- E-commerce
- Banking
- Food delivery
- Marketing analytics
- IoT manufacturing
- Video streaming

Document:

1. Data generated
2. Important events
3. Required data freshness
4. Acceptable latency
5. Batch, streaming, micro-batch, or combined choice
6. Reason for the choice
7. Transformation requirements
8. Storage destination
9. Monitoring checks
10. Possible failure scenarios
11. Final dashboard, report, or alert
12. Business benefit

## Answer Key

### Section 1

1. Data processing means reading data, applying operations, and producing a useful result.
2. Batch processing means processing collected data together as a group.
3. Streaming means processing events continuously or almost continuously as they arrive.
4. Micro-batch processing means processing small groups frequently.
5. An event is a record of something that happened.
6. Latency is the delay between data creation and usable result.
7. Data freshness means how recently data was updated.
8. Event time is when the event actually happened.
9. Processing time is when the system processed the event.
10. Streaming is more complex because events can be late, duplicated, out of order, and require continuous monitoring.
11. Batch is useful for scheduled reports, payroll, reconciliation, and historical processing.
12. Yes, many companies use both.

### Section 2

1. Batch
2. Streaming
3. Batch
4. Streaming
5. Batch
6. Micro-batch or streaming
7. Batch
8. Streaming
9. Batch
10. Streaming
11. Batch
12. Streaming or micro-batch
13. Streaming
14. Batch
15. Both

### Section 3

1. Event: product added to cart. Fields: customer ID, product ID, time, quantity.
2. Event: user login. Fields: user ID, time, device, status.
3. Event: payment completed. Fields: transaction ID, amount, time, merchant.
4. Event: location changed. Fields: driver ID, order ID, time, latitude, longitude.
5. Event: high temperature reading. Fields: sensor ID, machine ID, time, temperature.
6. Event: video started. Fields: user ID, video ID, time, device.
7. Event: website error. Fields: page, error code, time, session ID.
8. Event: ad clicked. Fields: campaign ID, user/session ID, time, channel.
9. Event: game level completed. Fields: player ID, level, time, score.
10. Event: support message sent. Fields: ticket ID, user ID, time, message type.

### Section 4

1. Monthly or days may be acceptable.
2. Overnight is often acceptable.
3. Seconds or less may be needed.
4. Seconds or near real time.
5. Weekly or daily may be acceptable.
6. Very low latency.
7. Hourly, daily, or micro-batch depending on campaign needs.
8. Seconds or minutes.
9. Batch timing is usually acceptable.
10. Seconds to minutes may be useful.

