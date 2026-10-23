# Day 065 Notes

```text
data only                 → dictionary / dataclass
behaviour only            → function
related state + behaviour → class
```

A **class** defines a blueprint. An **object** is an instance created from it. A **dataclass** is a compact class suited to a stable record or configuration shape. None is automatically better than a dictionary or function; choose the simplest useful form.

```text
raw values → record object → validation or transformation method → downstream use
```

An instance holds its own attributes. A method may read those attributes through `self`. Keep methods focused, make state changes deliberate, and validate business rules explicitly. Data can still flow through generator stages from Day 064; an object is one possible representation of each record.
