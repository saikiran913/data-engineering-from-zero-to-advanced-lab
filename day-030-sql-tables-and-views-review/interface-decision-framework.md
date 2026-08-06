# Interface Decision Framework

## Question 1: Must the Rows Be Stored?

If yes, consider a table-like stored interface.

## Question 2: Must the Logic Be Reused Across Statements?

If yes, consider a view or stored table depending on persistence needs.

## Question 3: Is the Logic Only Needed Inside One Statement?

Consider a CTE or subquery.

## Question 4: Is History Required?

Stored historical rows may be necessary.

## Question 5: Is Current Source Logic Sufficient?

A view may be suitable when live source logic is acceptable.

## Question 6: Is the Consumer a Dashboard or Report?

Consider a stable reporting interface.

## Question 7: Is the Source Grain Correct?

Clean or aggregate first.

## Question 8: Is a New Interface Necessary?

A simple query may be enough.

## Decision Table

| Requirement | Likely Starting Option | Main Risk | Required Validation |
|---|---|---|---|
| preserve raw history | raw table | losing audit history | row count and duplicate review |
| reusable clean logic | view or clean table | hidden business rules | key and null checks |
| one-query transformation | CTE | overbuilding | row and total checks |
| small embedded filter | subquery | unreadable nesting | sample check |
| stable dashboard output | reporting table or view | consumer mismatch | grain and total validation |
| no repeated need | simple query | unnecessary interface | row count check |

## Reusable Design Template

| Item | Notes |
|---|---|
| Business question |  |
| Source grain |  |
| Output grain |  |
| Persistence need |  |
| Reuse need |  |
| History need |  |
| Freshness need |  |
| Consumers |  |
| Dependencies |  |
| Interface choice |  |
| Key |  |
| Audit columns |  |
| Validation checks |  |
| Known limitations |  |
| Owner |  |
| Review date |  |
