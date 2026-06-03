package main

import "core:fmt"
import "core:os"
import "core:slice"
import "core:strconv"
import "core:strings"

File :: struct {
    name :         string,
    size :         int,
    is_directory : bool,
    contents :     [dynamic]File,
}

FileSystem :: struct {
    root : File,
}

create_file :: proc(name : string, size : int, is_directory : bool) -> File {
    return File{name = name, size = size, is_directory = is_directory, contents = make([dynamic]File)}
}

construct_hierarchy :: proc(lines : []string) -> map[string]int {
    directories := make(map[string]int)
    dir_stack := make([dynamic]string)
    defer delete(dir_stack)

    for line in lines {
        current_dir := len(dir_stack) > 0 ? dir_stack[len(dir_stack) - 1] : ""
        split := strings.split(strings.trim(line, "$ "), " ")
        defer delete(split)

        switch split[0] {
            case "cd":
                if split[1] == ".." {
                    fmt.println("Exiting directory", current_dir, "into directory", dir_stack[len(dir_stack) - 2])
                    pop(&dir_stack)
                } else {
                    fmt.println("Changing into directory", split[1])
                    if _, exists := directories[split[1]]; !exists {
                        directories[split[1]] = 0
                    }

                    append(&dir_stack, split[1])
                }
            case "ls":
                fmt.println("Listing files in", current_dir)
                break
            case "dir":
                fmt.println(current_dir, "contains directory", split[1])
                break
            case:
                size := strconv.atoi(split[0])
                if len(dir_stack) == 1 {
                    directories[current_dir] += size
                } else {
                    for directory in dir_stack {
                        directories[directory] += size

                    }
                }
        }
    }

    fmt.println(directories)

    return directories
}

construct_directories :: proc(lines : []string) -> map[string]int {
    directories := make(map[string]int)
    dir_stack := make([dynamic]string)
    defer delete(dir_stack)

    for line in lines {
        current_dir := len(dir_stack) > 0 ? dir_stack[len(dir_stack) - 1] : ""
        split := strings.split(strings.trim(line, "$ "), " ")
        defer delete(split)

        switch split[0] {
            case "cd":
                if split[1] == ".." {
                    fmt.println("Exiting directory", current_dir, "into directory", dir_stack[len(dir_stack) - 2])
                    pop(&dir_stack)
                } else {
                    fmt.println("Changing into directory", split[1])
                    if _, exists := directories[split[1]]; !exists {
                        directories[split[1]] = 0
                    }

                    append(&dir_stack, split[1])
                }
            case "ls":
                fmt.println("Listing files in", current_dir)
                break
            case "dir":
                fmt.println(current_dir, "contains directory", split[1])
                break
            case:
                size := strconv.atoi(split[0])
                if len(dir_stack) == 1 {
                    directories[current_dir] += size
                } else {
                    for directory in dir_stack {
                        directories[directory] += size

                    }
                }
        }
    }

    fmt.println(directories)

    return directories
}

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

day07 :: proc() {
    content, ok := os.read_entire_file_from_filename("./inputs/day7-example.txt")
    defer delete(content)

    if !ok {
        fmt.println("Error reading file")
    }

    lines := strings.split_lines(strings.trim(string(content), "\n"))
    defer delete(lines)

    fmt.println("Part 1 -", part1(lines))
    fmt.println("Part 2 -", part2(lines))
}
