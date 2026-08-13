# Day 034 Query Explanations

Day 034 uses control totals as validation evidence. Each SQL file focuses on one type of control or one stage relationship.

| File | Business Question | Source Tables | Control Type | Output Shape | Why It Matters |
|---|---|---|---|---|---|
| `count-controls.sql` | How many rows exist at each stage? | all main tables | row count | count summaries | counts are the first checkpoint |
| `distinct-key-controls.sql` | Are business keys unique? | source, stage, clean, reporting | distinct-key count | key summaries and duplicates | row counts can hide duplicates |
| `sum-controls.sql` | Do numeric totals reconcile? | stage, clean, reporting | sum | amount comparisons | sums validate important measures |
| `boundary-controls.sql` | Did date or value boundaries shift? | source, clean, reporting | min/max | boundary summaries | boundaries reveal missing or abnormal data |
| `grouped-control-totals.sql` | Do totals reconcile by group? | source, clean, reporting | grouped count/sum | grouped controls | groups reveal issues hidden by grand totals |
| `source-to-stage-reconciliation.sql` | Did source data reach stage as expected? | source and stage | count, distinct, sum | stage comparisons | source-stage differences need explanation |
| `stage-to-clean-reconciliation.sql` | Did accepted stage rows reach clean? | stage and clean | count, sum, key checks | missing and extra rows | clean output should be explainable |
| `clean-to-reporting-reconciliation.sql` | Do reporting metrics match clean data? | clean and reporting | sum and grouped count | report checks | reporting is trusted only after reconciliation |
| `accepted-review-controls.sql` | Do accepted and review rows reconcile? | stage | count and grouped count | validation summaries | no staged row should disappear |
| `control-total-summary.sql` | What is the overall status? | all main tables | summary | one row per control | helps review readiness |
| `control-total-debugging-lab.sql` | How can a control mislead us? | all main tables | diagnostic controls | issue evidence | one passing control is not proof |
| `integrated-control-total-workflow.sql` | How do controls fit together? | all main tables | integrated controls | combined evidence | shows a practical review flow |

## Important Interpretation Rules

- Define source and target populations before comparing.
- Define grain before judging count differences.
- Align filters and date ranges.
- Use grouped controls after grand totals.
- Treat documented differences differently from unexplained differences.
- Failed controls produce evidence for review; they do not fix data.

## SQL Platform Notes

Multi-column `COUNT(DISTINCT ...)`, date casting, decimal casting, and string formatting vary by platform. The examples prefer grouped checks and simple arithmetic differences.
