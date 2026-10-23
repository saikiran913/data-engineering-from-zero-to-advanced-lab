"""Compute bounded delays and illustrate repeated side-effect risk in memory."""


def delay_after_failure(attempt: int, max_attempts: int, base_delay: int, max_delay: int) -> int | None:
    if type(max_attempts) is not int or max_attempts < 1:
        raise ValueError("max_attempts must be positive")
    if not 1 <= attempt <= max_attempts:
        raise ValueError("attempt must be within the policy")
    if base_delay < 0 or max_delay < 0:
        raise ValueError("delays must be non-negative")
    if attempt == max_attempts:
        return None
    return min(max_delay, base_delay * 2 ** (attempt - 1))


def main() -> None:
    max_attempts = 3
    for attempt in range(1, max_attempts + 1):
        delay = delay_after_failure(attempt, max_attempts, base_delay=2, max_delay=3)
        print(f"failed_attempt={attempt} next_delay_seconds={delay}")
    print("These are calculations only; no waiting occurs. Success means no next delay.")

    values = [2, 3]
    print(f"pure_sum_first={sum(values)} pure_sum_repeated={sum(values)}")
    side_effects: list[str] = []
    for _ in range(2):
        side_effects.append("synthetic_output")
    print(f"repeated_append_effect_count={len(side_effects)}")
    print("An in-memory illustration does not prove exactly-once behavior for external operations.")


if __name__ == "__main__":
    main()
