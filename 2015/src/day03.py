def part1(chars: list[str]) -> int:
    x = 0
    y = 0

    coordinate_set = {(x, y)}

    for char in chars:
        match char:
            case ">":
                x += 1
            case "<":
                x -= 1
            case "^":
                y += 1
            case "v":
                y -= 1
            case _:
                pass
        coordinate_set.add((x, y))

    return len(coordinate_set)


def part2(chars: list[str]) -> int:
    santa_x = 0
    santa_y = 0
    robo_x = 0
    robo_y = 0

    santa = True

    coordinate_set = {(santa_x, santa_y), (robo_x, robo_y)}

    for char in chars:
        match (char, santa):
            case ">", True:
                santa_x += 1
            case "<", True:
                santa_x -= 1
            case "^", True:
                santa_y += 1
            case "v", True:
                santa_y -= 1
            case ">", False:
                robo_x += 1
            case "<", False:
                robo_x -= 1
            case "^", False:
                robo_y += 1
            case "v", False:
                robo_y -= 1
            case _:
                pass
        if santa:
            coordinate_set.add((santa_x, santa_y))
        else:
            coordinate_set.add((robo_x, robo_y))
        santa = not santa

    return len(coordinate_set)


def solve(input: str) -> tuple[int, int]:
    chars = list(input)
    return (part1(chars), part2(chars))
