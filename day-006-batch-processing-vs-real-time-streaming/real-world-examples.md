# Day 006 Real-World Examples

## Example 1: E-commerce Daily Sales Reporting

| Topic | Details |
| --- | --- |
| Business situation | An online store needs a daily sales dashboard. |
| Data generated | Orders, payments, product IDs, customer IDs, order times. |
| Required processing speed | Overnight is usually acceptable. |
| Approach | Batch processing. |
| Reason | The sales team can review yesterday's complete data in the morning. |
| Simplified data flow | Order database -> Nightly batch -> Clean sales table -> Dashboard. |
| Transformation examples | Remove duplicates, calculate sales, group by product. |
| Storage destination | Data warehouse. |
| Final output | Daily sales dashboard. |
| Possible data quality issue | Duplicate orders. |
| Possible failure scenario | Nightly job fails and dashboard does not refresh. |
| Business decision supported | Stock planning and sales tracking. |

## Example 2: Banking Fraud Monitoring

| Topic | Details |
| --- | --- |
| Business situation | A bank needs to detect suspicious card payments quickly. |
| Data generated | Payment events, card ID, amount, merchant, location, event time. |
| Required processing speed | Seconds or less may be needed. |
| Approach | Streaming. |
| Reason | Waiting until tomorrow could allow more suspicious activity. |
| Simplified data flow | Payment event -> Stream -> Fraud rules -> Alert -> History. |
| Transformation examples | Validate amount, compare location, calculate risk score. |
| Storage destination | Alert store and historical transaction storage. |
| Final output | Fraud alert and risk dashboard. |
| Possible data quality issue | Duplicate payment event. |
| Possible failure scenario | Streaming consumer stops. |
| Business decision supported | Investigate or block suspicious activity. |

## Example 3: Food Delivery Location Tracking

| Topic | Details |
| --- | --- |
| Business situation | Customers want to see delivery location updates. |
| Data generated | Driver location events, order ID, timestamp, latitude, longitude. |
| Required processing speed | Seconds or near real time. |
| Approach | Streaming. |
| Reason | A stale map creates a poor customer experience. |
| Simplified data flow | Driver app -> Location event -> Stream -> Latest location store -> Customer map. |
| Transformation examples | Validate coordinates, keep latest location, remove duplicates. |
| Storage destination | Latest location store and historical storage. |
| Final output | Customer tracking screen. |
| Possible data quality issue | Out-of-order location events. |
| Possible failure scenario | Driver app loses network connection. |
| Business decision supported | Improve delivery visibility and support operations. |

## Example 4: Marketing Campaign Reporting

| Topic | Details |
| --- | --- |
| Business situation | A marketing team reviews ad performance. |
| Data generated | Clicks, impressions, spend, conversions, campaign IDs. |
| Required processing speed | Hourly or daily is often acceptable. |
| Approach | Batch or micro-batch. |
| Reason | Campaign reporting usually does not require second-by-second updates. |
| Simplified data flow | Ad platforms -> API/file extract -> Batch transform -> Campaign dashboard. |
| Transformation examples | Standardize campaign names, calculate click-through rate. |
| Storage destination | Data warehouse. |
| Final output | Campaign performance report. |
| Possible data quality issue | Inconsistent campaign names. |
| Possible failure scenario | API export fails. |
| Business decision supported | Adjust campaign budget. |

## Example 5: Streaming-Platform Recommendations

| Topic | Details |
| --- | --- |
| Business situation | A platform wants to recommend content based on recent viewing. |
| Data generated | Video started, video completed, search events, likes. |
| Required processing speed | Near real time or micro-batch may be useful. |
| Approach | Streaming or micro-batch. |
| Reason | Recommendations improve when recent activity is considered. |
| Simplified data flow | Watch event -> Stream -> User activity update -> Recommendation system. |
| Transformation examples | Update watch history, group by genre, calculate recent interest. |
| Storage destination | User activity store and analytical warehouse. |
| Final output | Updated recommendations. |
| Possible data quality issue | Repeated watch events. |
| Possible failure scenario | Event backlog delays recommendations. |
| Business decision supported | Improve user engagement. |

## Example 6: IoT Factory Sensor Monitoring

| Topic | Details |
| --- | --- |
| Business situation | A factory monitors machine temperature. |
| Data generated | Sensor ID, temperature, event time, machine ID. |
| Required processing speed | Seconds or lower for safety cases. |
| Approach | Streaming. |
| Reason | Dangerous conditions need quick alerts. |
| Simplified data flow | Sensor -> Temperature event -> Stream processor -> Threshold check -> Alert. |
| Transformation examples | Validate reading, compare with threshold, flag dangerous values. |
| Storage destination | Monitoring database and historical storage. |
| Final output | Safety alert and machine dashboard. |
| Possible data quality issue | Sensor sends invalid reading. |
| Possible failure scenario | Sudden traffic increase creates backlog. |
| Business decision supported | Stop or inspect machine quickly. |

## Example 7: Monthly Employee Payroll

| Topic | Details |
| --- | --- |
| Business situation | A company calculates employee salaries monthly. |
| Data generated | Attendance, leave, salary, bonus, deduction data. |
| Required processing speed | Monthly schedule is acceptable. |
| Approach | Batch processing. |
| Reason | Payroll is periodic and needs complete data. |
| Simplified data flow | HR systems -> Monthly batch -> Payroll calculations -> Payroll report. |
| Transformation examples | Calculate salary, apply deductions, validate employee status. |
| Storage destination | Payroll database and reporting warehouse. |
| Final output | Payroll report. |
| Possible data quality issue | Missing attendance records. |
| Possible failure scenario | Scheduled payroll job fails. |
| Business decision supported | Pay employees accurately. |

## Example 8: Website Clickstream Monitoring

| Topic | Details |
| --- | --- |
| Business situation | A website tracks visitor activity and errors. |
| Data generated | Page views, clicks, search terms, errors, session IDs. |
| Required processing speed | Minutes or seconds depending on need. |
| Approach | Micro-batch or streaming. |
| Reason | Teams may want fresh metrics but not always instant processing. |
| Simplified data flow | Website events -> Event stream -> Process every minute -> Metrics dashboard. |
| Transformation examples | Count visits, group by page, detect error spikes. |
| Storage destination | Event store and analytics warehouse. |
| Final output | Website engagement dashboard or alert. |
| Possible data quality issue | Missing session ID. |
| Possible failure scenario | Processing delay causes stale metrics. |
| Business decision supported | Improve website performance and user experience. |

