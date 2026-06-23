from pathlib import Path

from syrupy.assertion import SnapshotAssertion

from src import day03

INPUT = Path(__file__).parent / "inputs" / "day03.txt"
DATA = INPUT.read_text()


def test_solve_snapshot(snapshot: SnapshotAssertion) -> None:
    result = day03.solve(DATA)
    assert result == snapshot
