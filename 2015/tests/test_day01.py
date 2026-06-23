from pathlib import Path

from syrupy.assertion import SnapshotAssertion
from src import day01

INPUT = Path(__file__).parent / "inputs" / "day01.txt"
input = INPUT.read_text()


def test_solve_snapshot(snapshot: SnapshotAssertion) -> None:
    result = day01.solve(input)
    assert result == snapshot
