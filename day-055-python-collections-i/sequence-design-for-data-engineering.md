# Sequence Design for Data Engineering

## Use List When

- collection changes
- order matters
- duplicates are allowed

## Use Tuple When

- fixed positional structure is needed
- record should not be reassigned
- immutable interface is useful

## Sequence Contract

For each collection define:

- expected item meaning
- order
- allowed types
- whether empty is allowed
- whether duplicates are allowed
- whether mutation is expected

## Homogeneous Versus Mixed Sequences

Homogeneous lists are easier to reason about because every item has the same meaning.

Mixed record tuples can be valid when positions are documented.

## Order Dependence

If order matters, document it.

## Empty Collection Handling

Decide whether an empty sequence is allowed.

## Index Safety

Check length or design inputs carefully before accessing fixed positions.

## Mutation Policy

State whether a list is expected to change.

## Data Engineering Examples

- sources list
- validation results
- fixed row tuple
- pipeline steps
- batch labels
