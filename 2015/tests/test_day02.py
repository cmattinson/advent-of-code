from pathlib import Path

from syrupy.assertion import SnapshotAssertion
from src import day02

INPUT = Path(__file__).parent / "inputs" / "day02.txt"
input = INPUT.read_text()


def test_solve_snapshot(snapshot: SnapshotAssertion) -> None:
    result = day02.solve(input)
    assert result == snapshot
