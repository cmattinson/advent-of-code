def parse(line: str) -> tuple[int, int, int]:
    result = line.split("x")
    return int(result[0]), int(result[1]), int(result[2])


def calculate_surface_area(l: int, w: int, h: int) -> int:
    smallest = min(l * w, w * h, h * l)
    return 2 * l * w + 2 * w * h + 2 * h * l + smallest


def get_area(line: str) -> int:
    parsed = parse(line)
    return calculate_surface_area(parsed[0], parsed[1], parsed[2])


def part1(lines: list[str]) -> int:
    result = 0
    for line in lines:
        result += get_area(line)
    return result


def get_bow_length(line: str) -> int:
    (l, w, h) = parse(line)
    smallest_perimeter = min(l + l + w + w, w + w + h + h, h + h + l + l)
    return l * w * h + smallest_perimeter


def part2(lines: list[str]) -> int:
    result = 0
    for line in lines:
        result += get_bow_length(line)
    return result


def solve(input: str) -> tuple[int, int]:
    lines = input.splitlines()
    return (part1(lines), part2(lines))
