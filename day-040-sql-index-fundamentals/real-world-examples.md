# Real-World Examples for Day 040

| # | Query pattern | Table | Columns | Frequency | Selectivity | Read/write balance | Candidate thinking | Trade-off | Review result |
|---|---|---|---|---|---|---|---|---|---|
| 1 | Exact order lookup | orders | `order_id` | High | High | Read-heavy | Strong signal | storage/write cost | strong candidate |
| 2 | Customer order history | orders | `customer_id` | High | Medium | Read-heavy | Useful repeated lookup | write overhead | possible candidate |
| 3 | Recent orders by date | orders | `order_date` | High | Medium | Read-heavy | Useful range pattern | platform dependent | possible candidate |
| 4 | Order status dashboard | orders | `order_status` | High | Low | Read-heavy | Low selectivity caution | may scan many rows | weak candidate |
| 5 | Country report | orders | `country_group` | Medium | Low | Read-heavy | Few groups | limited narrowing | weak candidate |
| 6 | Customer-order join | orders/customers | `customer_id` | High | Medium/High | Read-heavy | Join column signal | validate both sides | possible candidate |
| 7 | Product-code lookup | products | `product_code` | High | High | Read-heavy | Selective business key | key maintenance | strong candidate concept |
| 8 | High-volume ingestion | orders | `loaded_at` | High writes | Medium | Write-heavy | Be conservative | write maintenance | platform review |
| 9 | Small reference table | reference | status code | Low | Low | Mixed | May not need index | overhead | weak candidate |
| 10 | Write-heavy operational table | orders | many columns | Medium reads | Mixed | Write-heavy | Avoid many indexes | slows writes | review carefully |
| 11 | Read-heavy lookup table | customers | `customer_id` | High | High | Read-heavy | Strong lookup pattern | storage | strong candidate |
| 12 | Mixed workload | orders | `order_date` | Medium | Medium | Mixed | Balance reads and writes | maintenance | possible |
| 13 | Customer/date filter | orders | `customer_id, order_date` | High | Medium | Read-heavy | Composite pattern | column order | strong candidate concept |
| 14 | Status/date filter | orders | `order_status, order_date` | Medium | Low/Medium | Mixed | Could help some reports | low leading selectivity | possible |
| 15 | Sort-heavy date query | orders | `order_date` | Medium | Medium | Read-heavy | Sort pattern may matter | not guaranteed | possible |
| 16 | Low-cardinality flag | customers | `customer_status` | Medium | Low | Read-heavy | Weak alone | many rows per value | weak |
| 17 | Rare admin query | orders | `source_file` | Low | Low | Read-heavy | Rare and broad | permanent overhead | weak |
| 18 | Overlapping candidate | orders | `customer_id, order_date, status` | Medium | Medium | Mixed | May overlap | complexity | platform review |
| 19 | Analytical warehouse fact | orders | many | High | varies | Write-heavy | Traditional index may not fit | platform mechanisms differ | platform review |
| 20 | Primary-key lookup | customers | `customer_id` | High | High | Read-heavy | Often supported by key structures | varies | strong concept |
| 21 | Foreign-key join | orders | `customer_id` | High | Medium | Read-heavy | Join workload signal | write cost | possible |
| 22 | No-index-needed case | small table | status | Low | Low | Low writes | Table is tiny | little benefit | weak |
| 23 | Platform-review-needed case | warehouse | date columns | High | Medium | Mixed | May use clustering/pruning | vendor-specific | review platform |
| 24 | Over-indexed table | ingestion | many columns | Medium | varies | Write-heavy | Too many indexes | write/storage cost | reduce speculation |

