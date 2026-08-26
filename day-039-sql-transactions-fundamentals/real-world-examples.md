# Real-World Examples for Day 039

| # | Business scenario | Related steps | Atomicity need | Pre-change checks | Post-change checks | Commit condition | Rollback condition | Main risk |
|---|---|---|---|---|---|---|---|---|
| 1 | Two-account transfer concept | Decrease one balance and increase another | High | both accounts exist, total captured | total preserved | two rows changed correctly | total mismatch | partial transfer |
| 2 | Order status and review flag | Status completed and flag cleared | High | target orders exist | status and flag match | both fields correct | one field wrong | inconsistent order state |
| 3 | Customer status and audit state | Change status and audit marker | Medium | customer key exists | audit evidence present | status and audit align | audit missing | weak traceability |
| 4 | Parent-child correction | Correct parent and child keys | High | parent and child exist | no orphan remains | relationship valid | orphan remains | broken relationship |
| 5 | Reference-data correction | Fix one status label | Medium | count affected values | allowed values remain | expected count matches | unexpected value remains | reporting mismatch |
| 6 | Two-table key correction | Correct related keys | High | duplicate and orphan checks | relationship validates | no orphan rows | key mismatch | partial relationship |
| 7 | One independent row change | Change one note | Low | exact key exists | one row affected | row count is one | multiple rows affected | broad filter |
| 8 | Read-only report | Run a report SELECT | None | validate filters | compare totals | no write needed | not applicable | unnecessary transaction |
| 9 | Bulk correction risk | Many rows affected | High | count exact population | row count matches | controlled population | unexpected count | too broad update |
| 10 | Autocommit risk | Tool commits each statement | High | verify platform behaviour | confirm transaction mode | behaviour understood | unknown mode | premature commit |
| 11 | Expected one row but multiple match | Weak filter | High | count target rows | exact row changed | count equals one | count above one | unintended rows |
| 12 | Source key missing | Transfer source absent | High | source key exists | no change if missing | source valid | source missing | invalid start |
| 13 | Target key missing | Transfer target absent | High | target key exists | no change if missing | target valid | target missing | invalid target |
| 14 | Post-check total mismatch | Totals differ | High | capture before total | compare after total | difference zero | non-zero difference | data loss |
| 15 | Unrelated row changed | Extra row changed | High | snapshot unrelated rows | compare unchanged rows | no extra changes | unrelated difference | side effect |
| 16 | Commit too early | Commit before checks | High | define checks | validate before commit | checks pass first | failed check after commit | recovery burden |
| 17 | Rollback after failed validation | Validation fails before commit | High | rollback condition defined | failed check found | do not commit | validation failed | inconsistent data |
| 18 | Rollback after commit misconception | Commit already accepted | None | understand platform | recovery plan needed | not a rollback case | committed error | false confidence |
| 19 | Transaction too broad | Many unrelated changes | Medium | split scope | validate each unit | focused scope | unrelated failure | operational risk |
| 20 | No transaction needed | Read-only validation | None | run SELECT safely | no after-state change | not applicable | not applicable | overengineering |

