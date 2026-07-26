# Common LAG and LEAD Mistakes

| Mistake | Why It Matters | Safer Approach |
| --- | --- | --- |
| No `ORDER BY` inside `OVER` | Previous and next are undefined | Always define sequence |
| Wrong ordering column | Comparisons follow wrong order | Use business date, timestamp, or sequence |
| Wrong ordering direction | Backward and forward meaning flips | Confirm ascending or descending rule |
| Missing `PARTITION BY` | Unrelated entities are compared | Partition by customer, product, region, or transaction |
| Wrong partition key | Sequence resets incorrectly | Match the business entity |
| Duplicate timestamps without tie-breaker | Order is ambiguous | Add documented secondary ordering |
| Assuming display order controls `LAG` | Outer sorting is not window sequence | Check window `ORDER BY` |
| Treating boundary nulls as errors | First or last row normally has no neighbour | Label boundary rows |
| Replacing null with zero blindly | Missing history can look like a real zero | Preserve null for review when unsure |
| Division by zero | Percentage change can fail or mislead | Use `CASE` |
| Comparing wrong grain | Changes may be meaningless | Confirm one row represents the right event |
| Text dates not properly typed | Ordering can be wrong | Use real date/timestamp types in practice |
| Detecting changes before deduplication | Duplicate versions can create false changes | Clean or order versions carefully |
| Late-arriving data changes sequence | Historical order can shift | Validate load time and business time |
| Assuming change means error | Change can be valid | Review business context |
| Assuming no change means valid | Missing data may hide changes | Validate completeness |
| Filtering window alias at same level | Many platforms reject it | Filter in a CTE |
| Using `LAG` when next row is needed | Wrong neighbour | Use `LEAD` |
| Using `LEAD` when previous row is needed | Wrong neighbour | Use `LAG` |
| Ignoring null comparison values | Changes can become unknown | Add review flags |
