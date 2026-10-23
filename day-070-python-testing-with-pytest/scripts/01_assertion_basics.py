"""Use meaningful built-in assertions before introducing pytest discovery."""


def main() -> None:
    amounts = [10, 0, 5]
    assert sum(amounts) == 15
    assert len(amounts) == 3
    assert all(amount >= 0 for amount in amounts)
    print("Three expectations passed: total, count, and non-negative invariant.")
    # Intentionally failing assertions are shown only in the lesson text.


if __name__ == "__main__":
    main()
