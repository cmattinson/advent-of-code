package day02

import (
	"strings"

	"github.com/cmattinson/advent-of-code/2016/internal"
)

type Day struct{}

var _ internal.Day = (*Day)(nil)

type position struct {
	x, y int
}

func (p *position) move(direction string) {
	switch direction {
	case "U":
		p.y = max(p.y-1, 0)
	case "D":
		p.y = min(p.y+1, 2)
	case "L":
		p.x = max(p.x-1, 0)
	case "R":
		p.x = min(p.x+1, 2)
	}
}

func part1(instructions []string) int {
	pos := position{x: 1, y: 1}
	result := make([]int, 0, len(instructions))

	var keypad = [3][3]int{
		{1, 2, 3},
		{4, 5, 6},
		{7, 8, 9},
	}

	for _, instruction := range instructions {
		moves := strings.SplitSeq(instruction, "")

		for move := range moves {
			pos.move(move)
		}

		result = append(result, keypad[pos.y][pos.x])
	}

	code := 0
	for _, digit := range result {
		code = code*10 + digit
	}

	return code
}

func part2(instructions []string) int {
	var keypad = [5][5]any{
		{-1, -1, 1, -1, -1},
		{-1, 2, 3, 4, -1},
		{5, 6, 7, 8, 9},
		{-1, "A", "B", "C", -1},
		{-1, -1, "D", -1, -1},
	}

	pos := position{x: 0, y: 2}
	result := make([]string, 0, len(instructions))

	for _, instructions := range instructions {
		moves := strings.SplitSeq(instructions, "")

		for move := range moves {
			pos.move(move)
		}

		result = append(result, keypad[pos.y][pos.x].(string))
	}

	return strings.Join(result, "")

}

func (d Day) Solve(input string) (int, int) {
	instructions := internal.Lines(input)
	return part1(instructions), part2(input)
}
