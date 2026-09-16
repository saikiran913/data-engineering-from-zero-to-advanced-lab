"""Day 054: local and module-level scope."""

default_status = "UNKNOWN"


def build_status_message(status):
    """Use an explicit parameter instead of hidden global state."""
    local_message = f"Status received: {status}"
    return local_message


def show_shadowing_example():
    """Demonstrate that a local name can shadow a module-level name."""
    default_status = "LOCAL"
    return default_status


message = build_status_message("READY")
shadowed_value = show_shadowing_example()

print("Module-level default_status:", default_status)
print("Returned message:", message)
print("Local shadowed value:", shadowed_value)
