package main

import "core:fmt"
import "core:os"
import "core:slice"
import "core:strings"

make_rune_set :: proc(runes : string) -> map[rune]struct{} {
    seen := make(map[rune]struct{}, len(runes))

    for r in runes {
        if _, exists := seen[r]; !exists {
            seen[r] = {}
        }
    }

    return seen
}

get_index :: proc(str : string, length : int) -> int {
    for i := length; i < len(str); i += 1 {
        window := str[i - length:i]
        unique_runes := make_rune_set(window)
        defer delete(unique_runes)

        if (len(unique_runes) == length) {
            return i
        }
    }

    return 0
}

@(private = "file")
part1 :: proc(str : string) -> int {
    return get_index(str, 4)
}

@(private = "file")
part2 :: proc(str : string) -> int {
    return get_index(str, 14)
}

day06 :: proc() {
    content, ok := os.read_entire_file_from_filename("./inputs/day6.txt")
    defer delete(content)

    if !ok {
        fmt.println("Error reading file")
    }

    str := strings.trim(string(content), "\n")

    fmt.println("Part 1 -", part1(str))
    fmt.println("Part 2 -", part2(str))
}
