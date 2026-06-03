package main

import (
	"flag"
	"fmt"
	"os"
	"strings"

	"github.com/cmattinson/advent-of-code/2016/day01"
	"github.com/cmattinson/advent-of-code/2016/day02"
	"github.com/cmattinson/advent-of-code/2016/internal"
)

func main() {
	dayFlag := flag.Int("day", 0, "Day number to run")
	exampleFlag := flag.Bool("example", false, "Run with example input")
	flag.Parse()

	if *dayFlag == 0 {
		fmt.Println("Usage: go run cmd/aoc/main.go -day=1 [--example]")
		os.Exit(1)
	}

	filename := fmt.Sprintf("inputs/day%02d.txt", *dayFlag)
	if *exampleFlag {
		filename = fmt.Sprintf("inputs/day%02d-example.txt", *dayFlag)
	}

	input, err := os.ReadFile(filename)
	if err != nil {
		fmt.Printf("Error reading input file %s: %v\n", filename, err)
		os.Exit(1)
	}

	inputStr := string(input)

	var day internal.Day
	switch *dayFlag {
	case 1:
		day = day01.Day{}
	case 2:
		day = day02.Day{}
	default:
		fmt.Printf("Day %d not implemented\n", *dayFlag)
		os.Exit(1)
	}

	part1, part2 := day.Solve(strings.TrimSpace(inputStr))
	fmt.Printf("Part 1: %d\n", part1)
	fmt.Printf("Part 2: %d\n", part2)
}
