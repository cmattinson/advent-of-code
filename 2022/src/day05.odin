package main

import "core:fmt"
import "core:os"
import "core:slice"
import "core:strconv"
import "core:strings"
import "core:unicode"
import "core:unicode/utf8"

Instruction :: struct {
    count : int,
    from :  int,
    to :    int,
}

construct_stacks :: proc(layout : []string, allocator := context.allocator) -> map[int][dynamic]rune {
    stacks := make_map(map[int][dynamic]rune, allocator)

    for line in layout {
        for i := 1; i <= len(line) - 2; i += 2 {
            stack_index := ((i - 1) / 4) + 1
            _, ok := stacks[stack_index]
            char := rune(line[i])

            if !ok {
                if unicode.is_letter(char) {
                    stacks[stack_index] = make([dynamic]rune, 0, 16)
                    inject_at(&stacks[stack_index], 0, char)
                }
            } else {
                if unicode.is_letter(char) {
                    inject_at(&stacks[stack_index], 0, char)
                }
            }
        }
    }

    return stacks
}

parse_instructions :: proc(lines : []string, allocator := context.allocator) -> [dynamic]Instruction {
    instructions := make([dynamic]Instruction, allocator)

    for line in lines {
        split := strings.split(line, " ")
        defer delete(split)
        append(&instructions, Instruction{strconv.atoi(split[1]), strconv.atoi(split[3]), strconv.atoi(split[5])})
    }

    return instructions
}

process_instruction :: proc(stacks : ^map[int][dynamic]rune, instruction : Instruction) {
    for _ in 0 ..< instruction.count {
        candidate := pop(&stacks[instruction.from])
        append(&stacks[instruction.to], candidate)
    }
}

process_instruction_move_multiple :: proc(stacks : ^map[int][dynamic]rune, instruction : Instruction) {
    chunk := make([]rune, instruction.count)
    defer delete(chunk)

    for i := instruction.count - 1; i >= 0; i -= 1 {
        next := pop(&stacks[instruction.from])
        chunk[i] = next
    }

    append(&stacks[instruction.to], ..chunk[:])
}

@(private = "file")
part1 :: proc(stacks_string : []string, instructions : [dynamic]Instruction) -> []rune {
    stacks := construct_stacks(stacks_string)
    defer delete(stacks)

    for instruction in instructions {
        process_instruction(&stacks, instruction)
    }

    message := make([]rune, len(stacks))

    for i in 1 ..= len(stacks) {
        message[i - 1] = stacks[i][len(stacks[i]) - 1]
        delete(stacks[i])
    }

    return message
}

@(private = "file")
part2 :: proc(stacks_string : []string, instructions : [dynamic]Instruction) -> []rune {
    stacks := construct_stacks(stacks_string)
    defer delete(stacks)

    for instruction in instructions {
        process_instruction_move_multiple(&stacks, instruction)
    }

    message := make([]rune, len(stacks))

    for i in 1 ..= len(stacks) {
        message[i - 1] = stacks[i][len(stacks[i]) - 1]
        delete(stacks[i])
    }

    return message
}

day05 :: proc() {
    content, ok := os.read_entire_file_from_filename("./inputs/day5.txt")
    defer delete(content)

    if !ok {
        fmt.println("Error reading file")
    }

    entire_content := strings.trim(string(content), "\n")
    split := strings.split(entire_content, "\n\n")
    stack_string := split[0]
    instructions_string := split[1]
    defer delete(split)

    grid := strings.split_lines(stack_string)
    defer delete(grid)

    instruction_lines := strings.split_lines(instructions_string)
    defer delete(instruction_lines)

    instructions := parse_instructions(instruction_lines)
    defer delete(instructions)

    message := part1(grid, instructions)
    defer delete(message)

    message_string := utf8.runes_to_string(message)
    defer delete(message_string)

    message2 := part2(grid, instructions)
    defer delete(message2)

    message_string2 := utf8.runes_to_string(message2)
    defer delete(message_string2)

    fmt.println("Part 1 -", message_string)
    fmt.println("Part 2 -", message_string2)
}

