# Safe Collaboration Habits

## Keep Branches Focused

A branch should have one clear purpose.

## Start From Known Main State

Check the current branch and status before creating feature work.

## Make Small Commits

Small commits make review and merging easier.

## Write Clear Messages

Commit messages should explain why the change exists.

## Compare Before Merge

Use branch comparison to confirm the feature contains intended work only.

## Validate After Merge

Merged code still needs checks. Automatic merge does not guarantee correct logic.

## Communicate Overlapping Files

If two people edit the same SQL or documentation, communicate early.

## Avoid Long-Lived Branches Conceptually

Long-lived branches can become harder to merge because they drift from the default branch.

## Do Not Commit Secrets

Branches do not protect secrets. Sensitive values should never enter repository history.

## Do Not Mix Unrelated Refactors

Unrelated formatting and business-rule changes should usually be separate.

## Document Business-Rule Changes

When SQL logic changes, update validation notes when relevant.

## Keep SQL and Validation Notes Aligned

Documentation helps explain technical changes.

## Conflict Ownership

The resolver must understand the business logic. Do not mechanically select one side.

## Future Remote Collaboration

Remote branches, pull requests, review, push, and pull are later topics. Day 048 stays local.
