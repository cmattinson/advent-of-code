def parse(line: str) -> tuple[int, int, int]:
    result = line.split("x")
    return int(result[0]), int(result[1]), int(result[2])


def calculate_surface_area(length: int, width: int, height: int) -> int:
    smallest = min(length * width, width * height, height * length)
    return 2 * length * width + 2 * width * height + 2 * height * length + smallest


def get_area(line: str) -> int:
    parsed = parse(line)
    return calculate_surface_area(parsed[0], parsed[1], parsed[2])


def part1(lines: list[str]) -> int:
    return sum(get_area(line) for line in lines)


def get_bow_length(line: str) -> int:
    (length, width, height) = parse(line)
    smallest_perimeter = min(
        length + length + width + width,
        width + width + height + height,
        height + height + length + length,
    )
    return length * width * height + smallest_perimeter


def part2(lines: list[str]) -> int:
    return sum(get_bow_length(line) for line in lines)


def solve(input: str) -> tuple[int, int]:
    lines = input.splitlines()
    return (part1(lines), part2(lines))
