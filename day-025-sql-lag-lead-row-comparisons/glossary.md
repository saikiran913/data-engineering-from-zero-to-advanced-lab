# Glossary

| Term | Simple Meaning | Beginner Example |
| --- | --- | --- |
| Boundary row | First or last row in a sequence | First payment status |
| Change amount | Difference between current and neighbour | Current sales minus previous sales |
| Change detection | Finding changed values | Status changed from failed to success |
| Current row | Row currently being evaluated | Today's sales row |
| Date gap | Missing or irregular date interval | Missing daily sales date |
| Default value | Replacement when no neighbour exists | `LAG(value, 1, 0)` |
| Duplicate ordering value | Same sequence or timestamp appears twice | Two events with sequence 2 |
| Event sequence | Ordered event number | Website event sequence |
| First row | First row in a partition | First event for a user |
| Grain | What one row represents | One status event |
| `LAG` | Returns a previous-row value | Previous sales |
| Last row | Last row in a partition | Final payment status |
| Late-arriving data | Older business event loaded later | Old order date loaded after newer orders |
| `LEAD` | Returns a next-row value | Next payment status |
| Neighbour row | Previous or next row | Prior product price |
| Next row | Following row in sequence | Next event |
| Null boundary | Expected null at first or last row | First `LAG` value |
| Offset | Number of rows backward or forward | Offset 2 |
| Ordering column | Column defining row order | `status_sequence` |
| `OVER` | Defines the window | `LAG(...) OVER (...)` |
| Partition | Independent sequence group | One transaction |
| `PARTITION BY` | Creates sequence groups | `PARTITION BY product_id` |
| Percentage change | Change divided by previous value | Price increase percentage |
| Previous row | Earlier row in sequence | Previous status |
| Review flag | Label for investigation | `SEQUENCE_GAP` |
| Row-to-row comparison | Comparing current row with neighbour | Current vs previous amount |
| Sequence gap | Missing sequence number | 1 then 3 |
| Status change | Status differs from previous status | Pending to success |
| Tie-breaker | Extra ordering column | `version_number` |
| Window function | Function over ordered rows | `LAG` or `LEAD` |
