package main

import "core:fmt"
import "core:os"
import "core:strings"

get_priority :: proc(letter : rune) -> int {
    int_rep := int(letter)
    return int_rep >= 97 ? int_rep - 96 : int_rep - 38
}

create_letter_set :: proc(str : string) -> map[rune]struct{} {
    set := make(map[rune]struct{})

    for r in str {
        set[r] = {}
    }

    return set
}

get_duplicate_letter :: proc(comp1 : string, comp2 : string) -> (int, bool) {
    set1 := create_letter_set(comp1)
    defer delete(set1)

    for rune in comp2 {
        if rune in set1 {
            return get_priority(rune), true
        }
    }

    return -1, false
}

get_common_element :: proc(elem1 : string, elem2 : string, elem3 : string) -> (int, bool) {
    set1 := create_letter_set(elem1)
    defer delete(set1)

    set2 := create_letter_set(elem2)
    defer delete(set2)

    set3 := create_letter_set(elem3)
    defer delete(set3)

    for r in set1 {
        if r in set2 && r in set3 {
            return get_priority(r), true
        }
    }

    return -1, false
}

@(private = "file")
part1 :: proc(lines : []string) -> int {
    sum := 0

    for line in lines {
        length := len(line)
        midpoint := length / 2
        compartment1 := line[0:midpoint]
        compartment2 := line[midpoint:length]

        priority, ok := get_duplicate_letter(compartment1, compartment2)

        if !ok {
            fmt.println("Error getting duplicate letter")
            return -1
        }

        sum += priority
    }

    return sum
}

@(private = "file")
part2 :: proc(lines : []string) -> int {
    sum := 0

    for i := 0; i < len(lines) - 2; i += 3 {
        priority, ok := get_common_element(lines[i], lines[i + 1], lines[i + 2])

        if !ok {
            fmt.println("Error getting common priority")
            return -1
        }

        sum += priority
    }

    return sum
}

day03 :: proc() {
    content, ok := os.read_entire_file_from_filename("./inputs/day3.txt")
    defer delete(content)

    if !ok {
        fmt.println("Error reading file")
    }

    lines := strings.split_lines(strings.trim(string(content), "\n"))
    defer delete(lines)

    fmt.println("Part 1 -", part1(lines))
    fmt.println("Part 2 -", part2(lines))
}
