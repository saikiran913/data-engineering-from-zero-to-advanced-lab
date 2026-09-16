# Collection Choice Guide

| Need | Best beginner choice |
| --- | --- |
| Ordered changing sequence | list |
| Fixed positional record | tuple |
| Named fields / lookup | dictionary |
| Unique values / membership | set |

Choose based on meaning. Use a list when order or duplicates matter. Use a tuple for a small, fixed positional record. Use a dictionary when names make a record clearer. Use a set when uniqueness and membership matter.

Do not convert blindly. List to set loses duplicate counts and order. Tuple to dictionary needs reliable key meaning. Extracting dictionary values alone loses field names. A one-row-per-order structure and a one-row-per-order-item structure can both be dictionaries but have different business grain.

Before processing, ask: Do I need order? Can values repeat? Do fields need names? Can a field be missing? What keys are required? How will I validate the shape?
