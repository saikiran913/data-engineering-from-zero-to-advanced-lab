# Glossary

| Term | Simple Meaning | Beginner Example |
| --- | --- | --- |
| Ascending order | Lowest values first | `ORDER BY total_sales ASC` |
| Bottom-per-group | Lowest ranked record in each group | Lowest sales day per region |
| Business grain | What one business row represents | One customer per period |
| Dense rank | Rank with no gaps after ties | `1, 2, 2, 3` |
| Descending order | Highest values first | `ORDER BY total_sales DESC` |
| Deterministic ordering | Ordering with stable tie-breakers | Sales then customer ID |
| `DENSE_RANK` | Ranking function with shared ranks and no gaps | Dense leaderboard |
| Global rank | Rank across all rows | Overall top customer |
| Group-based analysis | Comparing rows inside groups | Products within categories |
| Null ranking value | Missing ranking measure | Blank total sales |
| Ordering measure | Column used to rank | `performance_score` |
| `OVER` | Defines the window | `RANK() OVER (...)` |
| Partition | Logical ranking group | Country or category |
| `PARTITION BY` | Creates ranking groups | `PARTITION BY country` |
| Ranking | Assigning positions to rows | Rank products by sales |
| Ranking function | Function that assigns row positions | `RANK` |
| Ranking grain | What one ranked row represents | One product-period row |
| Rank gap | Skipped number after ties | `1, 2, 2, 4` |
| `RANK` | Ranking function that creates gaps after ties | Competition-style rank |
| Review flag | Indicator that a row needs checking | Null score review |
| Row number | Unique sequence number | `ROW_NUMBER` |
| `ROW_NUMBER` | Ranking function with unique numbers | One winner per group |
| Skipped rank | Missing rank after a tie | Rank 3 skipped |
| Tie | Equal ordering values | Two products with same sales |
| Tie-breaker | Extra ordering rule | `customer_id` |
| Tie policy | Business rule for ties | Keep all tied winners |
| Top-per-group | Highest ranked row or rows in each group | Top campaign per channel |
| Window | Rows used by the function | Department group |
| Window function | Calculates per row over a window | `RANK()` |
| Window ordering | Ordering inside `OVER` | Rank highest first |
