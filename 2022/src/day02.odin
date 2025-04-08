package main

import "core:fmt"
import "core:os"
import "core:strings"

@(private = "file")
part1 :: proc(player : int, opponent : int) -> int {
    shape_score := player + 1
    outcome_score := ((4 + player - opponent) % 3) * 3

    return shape_score + outcome_score
}

@(private = "file")
part2 :: proc(opponent_score : int, desired_result : int) -> int {
    return (3 + opponent_score + (desired_result - 1)) % 3
}

day02 :: proc() {
    content, ok := os.read_entire_file_from_filename("./inputs/day2.txt")
    defer delete(content)

    if !ok {
        fmt.println("Error reading file")
    }

    lines := strings.split_lines(string(content))
    defer delete(lines)

    p1, p2 : int = 0, 0
    for line in lines {
        if len(line) == 0 {
            break
        }

        me := int(line[2] - 'X')
        them := int(line[0] - 'A')

        p1 += part1(me, them)
        p2 += part1(part2(them, me), them)
    }

    fmt.println("Part 1 -", p1)
    fmt.println("Part 2 -", p2)
}

