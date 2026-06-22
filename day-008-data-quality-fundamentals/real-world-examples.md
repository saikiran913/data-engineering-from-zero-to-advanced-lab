# Day 008 Real-World Examples

## Example 1: E-commerce Duplicate Order Issue

| Topic | Details |
| --- | --- |
| Business situation | Sales dashboard shows daily revenue. |
| Data involved | Orders, payments, order amount. |
| Quality issue | Same order appears twice. |
| Why it matters | Revenue may be overreported. |
| Possible validation check | Duplicate check on `order_id`. |
| Possible root cause | Pipeline rerun loaded the same file twice. |
| Possible action by data engineer | Remove duplicate order, add unique key check, document issue. |
| Final dashboard/report impact | Sales dashboard may show inflated revenue. |
| Business decision affected | Stock planning and sales performance decisions. |

## Example 2: Banking Missing Transaction Amount Issue

| Topic | Details |
| --- | --- |
| Business situation | Bank prepares transaction reporting. |
| Data involved | Transaction ID, account ID, amount, date. |
| Quality issue | Transaction amount is missing. |
| Why it matters | Totals and balances may be wrong. |
| Possible validation check | Null check on transaction amount. |
| Possible root cause | Source system failed to send amount field. |
| Possible action by data engineer | Quarantine record and alert source system owner. |
| Final dashboard/report impact | Transaction report may be incomplete. |
| Business decision affected | Finance reporting and audit review. |

## Example 3: Marketing Campaign Country Mismatch Issue

| Topic | Details |
| --- | --- |
| Business situation | Marketing team compares campaign performance by country. |
| Data involved | Campaign ID, country, clicks, cost, conversions. |
| Quality issue | Country appears as `UK`, `U.K.`, and `United Kingdom`. |
| Why it matters | Reports split one country into multiple groups. |
| Possible validation check | Accepted values or standardization check. |
| Possible root cause | Different ad platforms use different country names. |
| Possible action by data engineer | Create standard country mapping. |
| Final dashboard/report impact | Country-level performance becomes unreliable. |
| Business decision affected | Marketing budget allocation. |

## Example 4: Food Delivery Missing Delivery Status Issue

| Topic | Details |
| --- | --- |
| Business situation | Operations team tracks delayed deliveries. |
| Data involved | Order ID, delivery status, delivery time. |
| Quality issue | Delivery status is missing. |
| Why it matters | Team cannot tell whether the order was delivered, cancelled, or delayed. |
| Possible validation check | Null check on delivery status. |
| Possible root cause | Delivery tracking API failed. |
| Possible action by data engineer | Alert team, reload data, or mark records for review. |
| Final dashboard/report impact | Late delivery metrics may be incorrect. |
| Business decision affected | Delivery staffing and restaurant follow-up. |

## Example 5: Hospital Appointment Date Issue

| Topic | Details |
| --- | --- |
| Business situation | Hospital reports daily appointments. |
| Data involved | Appointment ID, patient ID, appointment date, department. |
| Quality issue | Appointment date format is invalid. |
| Why it matters | Appointments may appear on the wrong day or fail processing. |
| Possible validation check | Date format check. |
| Possible root cause | Source system changed date format. |
| Possible action by data engineer | Update parsing rule after confirming with source team. |
| Final dashboard/report impact | Appointment counts may be wrong. |
| Business decision affected | Staffing and scheduling. |

## Example 6: Streaming Platform Duplicate Watch Event Issue

| Topic | Details |
| --- | --- |
| Business situation | Streaming platform tracks watch time. |
| Data involved | Event ID, user ID, video ID, watch duration. |
| Quality issue | Same watch event arrives twice. |
| Why it matters | Watch time may be double-counted. |
| Possible validation check | Duplicate event ID check. |
| Possible root cause | Event retry after network delay. |
| Possible action by data engineer | Use event ID to remove duplicates. |
| Final dashboard/report impact | Content popularity may be overstated. |
| Business decision affected | Content promotion and recommendation planning. |

## Example 7: Payroll Incorrect Employee ID Issue

| Topic | Details |
| --- | --- |
| Business situation | Company calculates monthly payroll. |
| Data involved | Employee ID, salary, attendance, department. |
| Quality issue | Employee ID is incorrect or missing. |
| Why it matters | Salary may be assigned to the wrong person or fail processing. |
| Possible validation check | Required field and referential integrity check. |
| Possible root cause | Manual data entry mistake. |
| Possible action by data engineer | Quarantine record and request correction. |
| Final dashboard/report impact | Payroll report may be incomplete. |
| Business decision affected | Salary processing and workforce reporting. |

## Example 8: Website Analytics Stale Dashboard Issue

| Topic | Details |
| --- | --- |
| Business situation | Website team monitors daily traffic. |
| Data involved | Page views, clicks, sessions, event time. |
| Quality issue | Dashboard last updated three days ago. |
| Why it matters | Team may make decisions using old activity data. |
| Possible validation check | Freshness check. |
| Possible root cause | Scheduled pipeline failed. |
| Possible action by data engineer | Investigate failure, rerun pipeline, alert users. |
| Final dashboard/report impact | Website metrics are stale. |
| Business decision affected | Content and performance decisions. |

