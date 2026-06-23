def parse(input: str) -> str:
    return input


def part1(input: str) -> int:
    return input.count("(") - input.count(")")


def part2(input: str) -> int:
    floor = 0
    for i, ch in enumerate(input, start=1):
        floor += 1 if ch == "(" else -1
        if floor == -1:
            return i
    return -1


def solve(input: str) -> tuple[int, int]:
    return (part1(parse(input)), part2(parse(input)))
