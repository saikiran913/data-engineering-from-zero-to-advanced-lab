"""Show fixed numeric and date parsing expectations without real-time inputs."""

from datetime import date


def main() -> None:
    amount = float(" 12.5 ")
    order_date = date.fromisoformat("2024-02-29")
    assert amount == 12.5
    assert order_date == date(2024, 2, 29)
    print(f"amount={amount} order_date={order_date.isoformat()}")
    # Invalid text should be checked with pytest.raises in the test suite.


if __name__ == "__main__":
    main()
