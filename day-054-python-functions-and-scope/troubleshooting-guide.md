# Troubleshooting Guide

## `NameError` Function Not Defined

Possible causes:

- call before definition
- typo in function name

## `TypeError` Missing Required Positional Argument

The function expects an argument that was not supplied.

## Too Many Arguments

The function received more values than its parameters allow.

## Unexpected Keyword Argument

The keyword name does not match a parameter name.

## Function Prints but Variable Is None

Printing is not returning. Use `return` when the caller needs the value.

## Function Returns None Unexpectedly

Possible causes:

- no `return`
- one branch missing `return`

## Local Variable Not Available Outside Function

This is normal scope behaviour. Return the value if the caller needs it.

## Global Value Seems Unchanged

A local variable may be shadowing the module-level value.

## Wrong Value Returned

Check:

- branch logic
- parameter order
- early return

## Default Parameter Not Used as Expected

Check whether the caller supplied an overriding value.

## Function Works Once but Not Reusable

Possible hidden state or side effect may be involved. Pass inputs explicitly and return outputs.

## Main Function Not Running

Check:

```python
if __name__ == "__main__":
    main()
```

## Troubleshooting Flow

```text
1. inspect function definition
2. inspect call
3. inspect arguments
4. print/inspect inputs
5. inspect each return path
6. check local/global names
7. remove hidden dependencies
8. test one small input
```
