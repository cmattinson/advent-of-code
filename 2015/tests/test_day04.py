from src import day04

from syrupy.assertion import SnapshotAssertion


def test_solve_snapshot(snapshot: SnapshotAssertion) -> None:
    result = day04.solve("yzbqklnj")
    assert result == snapshot
