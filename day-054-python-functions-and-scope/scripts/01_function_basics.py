"""Day 054: function basics."""


def show_pipeline_name():
    """Display a simple pipeline name."""
    print("daily_orders")


def show_source_name(source_name):
    """Display a source name passed by the caller."""
    print(f"Source: {source_name}")


show_pipeline_name()
show_source_name("orders")
