package main

import "core:fmt"
import "core:math"
import "core:os"
import "core:strconv"
import "core:strings"

sum_group :: proc(group : []string) -> int {
    total := 0

    for num in group {
        total += strconv.atoi(num)
    }

    return total
}

find_top_three :: proc(calories : [dynamic]int) -> [3]f32 {
    largest1 := math.NEG_INF_F32
    largest2 := math.NEG_INF_F32
    largest3 := math.NEG_INF_F32

    for i in calories {
        fl := f32(i)

        if fl > largest1 {
            largest3 = largest2
            largest2 = largest1
            largest1 = fl
        } else if fl > largest2 {
            largest3 = largest2
            largest2 = fl
        } else if fl > largest3 {
            largest3 = fl
        }
    }

    return [3]f32{largest1, largest2, largest3}
}

@(private = "file")
part1 :: proc(groups : []string) -> int {
    max_of_groups := 0

    for group in groups {
        lines := strings.split_lines(group)
        defer delete(lines)

        sum := sum_group(lines)

        if sum > max_of_groups {
            max_of_groups = sum
        }
    }

    return max_of_groups
}

@(private = "file")
part2 :: proc(groups : []string) -> int {
    frequency := make([dynamic]int)
    defer delete(frequency)

    for group, index in groups {
        lines := strings.split_lines(group)
        defer delete(lines)

        append(&frequency, sum_group(lines))
    }

    top3 := find_top_three(frequency)

    sum := 0
    for num in top3 {
        sum += int(num)
    }

    return sum
}

day01 :: proc() {
    content, ok := os.read_entire_file_from_filename("./inputs/day1.txt")
    defer delete(content)

    if !ok {
        fmt.println("Error reading file")
    }

    split := strings.split(string(content), "\n\n")
    defer delete(split)

    fmt.println("Part 1 -", part1(split))
    fmt.println("Part 2 -", part2(split))
}

