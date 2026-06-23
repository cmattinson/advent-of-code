from collections.abc import Callable
from pathlib import Path


def input_path(day: int) -> Path:
    return Path(f"inputs/day{day:02d}.txt")


def run[T, U](
    day: int,
    parser: Callable[[str], T],
    part1: Callable[[T], U],
    part2: Callable[[T], U],
) -> tuple[U, U]:
    data = parser(input_path(day).read_text().strip())
    return part1(data), part2(data)
