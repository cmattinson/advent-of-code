package main

import "core:fmt"
import "core:os"
import "core:slice"
import "core:strconv"
import "core:strings"

@(private = "file")
part1 :: proc(lines : []string) -> int {
    directories := construct_directories(lines)
    defer delete(directories)

    sum := 0

    for directory in directories {
        if directories[directory] <= 100000 {
            sum += directories[directory]
        }
    }

    return sum
}

@(private = "file")
part2 :: proc(lines : []string) -> int {
    return 0
}

day08 :: proc() {
    content, ok := os.read_entire_file_from_filename("./inputs/day8-example.txt")
    defer delete(content)

    if !ok {
        fmt.println("Error reading file")
    }

    lines := strings.split_lines(strings.trim(string(content), "\n"))
    defer delete(lines)

    fmt.println("Part 1 -", part1(lines))
    fmt.println("Part 2 -", part2(lines))
}

