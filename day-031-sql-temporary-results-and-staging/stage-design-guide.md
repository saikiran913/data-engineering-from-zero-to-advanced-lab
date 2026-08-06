# Stage Design Guide

## Start With the Business Question

Ask what the stage is supposed to prepare, validate, or hand off.

## Define the Source Layer and Grain

Write the input object and what one input row represents.

## Decide Whether an Intermediate Step Is Needed

Use a CTE when one query needs readable steps. Consider a staging-table concept only when repeated downstream use, auditability, or handoff requirements justify it.

## Define Stage Purpose and Grain

Each stage should have one clear purpose and one clear output grain.

## Define Accepted and Review Criteria

Accepted records continue. Review records remain available with a reason.

## Preserve Audit Columns

Keep source and timing fields when they support investigation.

## Define Validation Checkpoints

Include counts, keys, nulls, duplicates, totals, dates, and status distributions as needed.

## Define Downstream Handoff

Document who or what receives the stage output and what conditions must be met.

## Avoid Too Many Stages and One Giant Stage

Too many tiny stages are noisy. One huge stage is hard to debug. Choose stages that clarify real work.

## Reusable Stage-Design Template

| Item | Notes |
|---|---|
| Stage name |  |
| Business purpose |  |
| Source object |  |
| Source grain |  |
| Output grain |  |
| Business key |  |
| Selected columns |  |
| Transformations |  |
| Accepted rules |  |
| Review rules |  |
| Audit columns |  |
| Validation checks |  |
| Downstream consumer |  |
| Known limitations |  |
| Owner |  |
| Review date |  |
