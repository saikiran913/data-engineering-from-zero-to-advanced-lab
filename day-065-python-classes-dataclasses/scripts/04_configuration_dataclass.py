"""Use safe per-instance list defaults and a frozen configuration."""

from dataclasses import dataclass, field


@dataclass
class SourceConfig:
    name: str
    enabled: bool = True
    tags: list[str] = field(default_factory=list)


@dataclass(frozen=True)
class ValidationConfig:
    allowed_statuses: tuple[str, ...]
    minimum_amount: float = 0.0


def main():
    orders = SourceConfig("orders")
    events = SourceConfig("events")
    orders.tags.append("daily")
    rules = ValidationConfig(("READY", "COMPLETED"))
    print("Orders tags:", orders.tags)
    print("Events tags:", events.tags)
    print("Independent lists:", orders.tags is not events.tags)
    print("Frozen rules:", rules)


if __name__ == "__main__":
    main()
