"""Day 062: clear parameters, defaults, and keyword calls."""


def classify_amount(amount, minimum_amount=0):
    """Return whether amount meets the caller-provided minimum."""
    return amount >= minimum_amount


def build_label(source_name, environment, prefix="pipeline"):
    """Return a stable label from required and optional parameters."""
    return f"{prefix}:{environment}:{source_name}"


def collect_errors(errors=None):
    """Create a new list when no list is supplied; avoid errors=[]."""
    return [] if errors is None else list(errors)


print(classify_amount(25, 10))
print(classify_amount(amount=5, minimum_amount=10))
print(build_label("orders", environment="training"))
print(build_label("orders", environment="training", prefix="daily"))
print(collect_errors())
