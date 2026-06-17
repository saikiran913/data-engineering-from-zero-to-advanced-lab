# Day 005 Real-World Examples

## Example 1: E-commerce Daily Sales ETL

| Area | Details |
| --- | --- |
| Business situation | An online store needs a daily sales dashboard. |
| Source systems | Orders database, payments database, product database. |
| Extracted data | Orders, payment status, product details, customer IDs. |
| Transformations performed | Remove duplicates, standardize dates, calculate order value, exclude failed payments. |
| Final destination | Sales table in a data warehouse. |
| ETL or ELT | ETL may be suitable. |
| Reason | The final sales table should be clean before reporting. |
| Final report or dashboard | Daily sales dashboard. |
| Business decision supported | Stock planning and sales performance tracking. |
| Possible data quality issue | Duplicate orders may inflate revenue. |

## Example 2: Banking Transaction Reporting

| Area | Details |
| --- | --- |
| Business situation | A bank needs transaction summaries for reporting. |
| Source systems | Transaction database, account database, payment systems. |
| Extracted data | Transaction amount, account ID, payment status, transaction date. |
| Transformations performed | Validate dates, remove invalid records, group transactions by day, calculate totals. |
| Final destination | Reporting warehouse. |
| ETL or ELT | ETL may be suitable. |
| Reason | Sensitive and invalid data may need checks before final loading. |
| Final report or dashboard | Transaction reporting dashboard. |
| Business decision supported | Monitor payment trends and operational risk. |
| Possible data quality issue | Missing transaction dates can affect daily reports. |

## Example 3: Marketing Campaign ELT

| Area | Details |
| --- | --- |
| Business situation | A marketing team wants performance from several ad platforms. |
| Source systems | Ad platform APIs, email platform exports, website tracking logs. |
| Extracted data | Clicks, impressions, spend, campaign names, conversions. |
| Transformations performed | Standardize campaign names, calculate click-through rate, group by channel. |
| Final destination | Cloud warehouse campaign tables. |
| ETL or ELT | ELT may be suitable. |
| Reason | Raw platform data can be loaded first and transformed later for different reporting needs. |
| Final report or dashboard | Marketing performance dashboard. |
| Business decision supported | Increase or reduce campaign budget. |
| Possible data quality issue | Campaign names may be inconsistent across platforms. |

## Example 4: Food Delivery Order Analytics

| Area | Details |
| --- | --- |
| Business situation | A delivery company wants to understand order delays. |
| Source systems | Order database, delivery tracking API, payment system, support logs. |
| Extracted data | Order times, restaurant IDs, delivery partner IDs, payment status, delivery status. |
| Transformations performed | Calculate delivery duration, standardize city names, remove duplicate events. |
| Final destination | Operations warehouse. |
| ETL or ELT | Either approach may be appropriate. |
| Reason | Structured order data may use ETL, while event logs may use ELT. |
| Final report or dashboard | Delivery operations dashboard. |
| Business decision supported | Improve staffing and reduce delays. |
| Possible data quality issue | Missing delivery completion time can break delay calculations. |

## Example 5: Hospital Appointment Reporting

| Area | Details |
| --- | --- |
| Business situation | A hospital wants reports on appointments and waiting time. |
| Source systems | Appointment system, patient system, billing system. |
| Extracted data | Appointment dates, department, doctor ID, patient ID, appointment status. |
| Transformations performed | Standardize department names, calculate wait time, group appointments by department. |
| Final destination | Hospital reporting warehouse. |
| ETL or ELT | ETL may be suitable. |
| Reason | Data should be carefully cleaned and validated before reporting. |
| Final report or dashboard | Hospital operations dashboard. |
| Business decision supported | Improve scheduling and staffing. |
| Possible data quality issue | Duplicate appointments may overstate demand. |

## Example 6: Streaming Watch-History Analysis

| Area | Details |
| --- | --- |
| Business situation | A streaming platform wants to analyze watch behavior. |
| Source systems | App event logs, content catalog database, subscription database. |
| Extracted data | Watch events, user IDs, video IDs, watch duration, device type. |
| Transformations performed | Remove incomplete events, calculate watch time, group by show and region. |
| Final destination | Analytics warehouse and content performance tables. |
| ETL or ELT | ELT may be suitable. |
| Reason | Large raw event logs can be loaded first and transformed later. |
| Final report or dashboard | Content performance dashboard. |
| Business decision supported | Plan content recommendations and investments. |
| Possible data quality issue | Repeated event loads may double-count watch time. |

## Example 7: Human Resources Employee Reporting

| Area | Details |
| --- | --- |
| Business situation | A company wants employee headcount and department reports. |
| Source systems | HR system, payroll system, attendance system. |
| Extracted data | Employee ID, department, join date, salary band, attendance records. |
| Transformations performed | Standardize department names, classify active employees, calculate monthly attendance. |
| Final destination | HR reporting warehouse. |
| ETL or ELT | ETL may be suitable. |
| Reason | Cleaned and controlled data is useful before reports are created. |
| Final report or dashboard | HR headcount and attendance dashboard. |
| Business decision supported | Workforce planning and department staffing. |
| Possible data quality issue | Inactive employees may be counted as active if status is wrong. |

