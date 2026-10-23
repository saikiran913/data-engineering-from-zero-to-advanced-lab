"""Retry only a synthetic transient failure, with an enforced attempt bound."""


class TransientOperationError(Exception):
    """A simulated temporary failure that may be safe to retry."""


class SimulatedStage:
    def __init__(self, failures_before_success: int) -> None:
        self.failures_before_success = failures_before_success
        self.calls = 0

    def __call__(self) -> str:
        self.calls += 1
        if self.calls <= self.failures_before_success:
            raise TransientOperationError("synthetic stage temporarily unavailable")
        return "ready"


def retry_stage(operation: SimulatedStage, max_attempts: int) -> tuple[str, int]:
    if type(max_attempts) is not int or max_attempts < 1:
        raise ValueError("max_attempts must be a positive integer")
    for attempt in range(1, max_attempts + 1):
        try:
            return operation(), attempt
        except TransientOperationError:
            if attempt == max_attempts:
                raise
    raise AssertionError("retry loop ended without an outcome")


def main() -> None:
    recovering = SimulatedStage(failures_before_success=1)
    value, attempt = retry_stage(recovering, max_attempts=3)
    print(f"result={value} success_attempt={attempt} total_calls={recovering.calls}")

    exhausted = SimulatedStage(failures_before_success=3)
    try:
        retry_stage(exhausted, max_attempts=3)
    except TransientOperationError as exc:
        print(f"result=FAILED attempts={exhausted.calls} reason={exc}")

    class PermanentStage:
        calls = 0

        def __call__(self) -> str:
            self.calls += 1
            raise ValueError("synthetic configuration is invalid")

    permanent = PermanentStage()
    try:
        retry_stage(permanent, max_attempts=3)
    except ValueError as exc:
        print(f"result=FAILED nonretryable_calls={permanent.calls} reason={exc}")


if __name__ == "__main__":
    main()
