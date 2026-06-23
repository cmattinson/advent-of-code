from pathlib import Path

from syrupy.assertion import SnapshotAssertion
from src import day03

INPUT = Path(__file__).parent / "inputs" / "day03.txt"
input = INPUT.read_text()


def test_solve_snapshot(snapshot: SnapshotAssertion) -> None:
    result = day03.solve(input)
    assert result == snapshot
