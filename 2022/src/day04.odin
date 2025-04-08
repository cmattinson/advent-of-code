package main

import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"

Assignment :: struct {
    min : int,
    max : int,
}

parse_assignments :: proc(line : string) -> (Assignment, Assignment) {
    split := strings.split(line, ",")
    defer delete(split)
    split1 := strings.split(split[0], "-")
    defer delete(split1);split2 := strings.split(split[1], "-")
    defer delete(split2)

    return Assignment {
        strconv.atoi(split1[0]),
        strconv.atoi(split1[1]),
    }, Assignment{strconv.atoi(split2[0]), strconv.atoi(split2[1])}
}

assignments_fully_overlap :: proc(assign1 : Assignment, assign2 : Assignment) -> bool {
    return(
        assign1.min <= assign2.min && assign1.max >= assign2.max ||
        assign2.min <= assign1.min && assign2.max >= assign1.max \
    )
}

assignments_overlap :: proc(assign1 : Assignment, assign2 : Assignment) -> bool {
    latest_start := max(assign1.min, assign2.min)
    earliest_end := min(assign1.max, assign2.max)

    return latest_start <= earliest_end
}

@(private = "file")
part1 :: proc(lines : []string) -> int {
    sum := 0

    for line in lines {
        if assignments_fully_overlap(parse_assignments(line)) {
            sum += 1
        }
    }

    return sum
}

@(private = "file")
part2 :: proc(lines : []string) -> int {
    sum := 0

    for line in lines {
        if assignments_overlap(parse_assignments(line)) {
            sum += 1
        }
    }

    return sum
}

day04 :: proc() {
    content, ok := os.read_entire_file_from_filename("./inputs/day4.txt")
    defer delete(content)

    if !ok {
        fmt.println("Error reading file")
    }

    lines := strings.split_lines(strings.trim(string(content), "\n"))
    defer delete(lines)

    fmt.println("Part 1 -", part1(lines))
    fmt.println("Part 2 -", part2(lines))
}

