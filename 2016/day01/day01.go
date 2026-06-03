package day01

import (
	"fmt"
	"math"
	"strconv"
	"strings"

	"github.com/cmattinson/advent-of-code/2016/internal"
)

type Day struct{}

var _ internal.Day = (*Day)(nil)

type rotation int
type direction int

const (
	left rotation = iota + 1
	right
)

const (
	north direction = iota + 1
	south
	east
	west
)

type instruction struct {
	rotation rotation
	distance int
}

type coordinate struct {
	x, y int
}

func (c coordinate) distanceFromOrigin() int {
	return manhattenDistance(c.x, c.y, 0, 0)
}

type state struct {
	pos coordinate
	dir direction
}

func (s *state) rotate(r rotation) {
	switch r {
	case left:
		switch s.dir {
		case north:
			s.dir = west
		case west:
			s.dir = south
		case south:
			s.dir = east
		case east:
			s.dir = north
		}
	case right:
		switch s.dir {
		case north:
			s.dir = east
		case east:
			s.dir = south
		case south:
			s.dir = west
		case west:
			s.dir = north
		}
	}
}

func (s *state) walk(distance int) {
	switch s.dir {
	case north:
		s.pos.y += distance
	case south:
		s.pos.y -= distance
	case east:
		s.pos.x += distance
	case west:
		s.pos.x -= distance
	}
}

func manhattenDistance(x1, y1, x2, y2 int) int {
	return int(math.Abs(float64(x1-x2)) + math.Abs(float64(y1-y2)))
}

func parseInput(input string) []instruction {
	instructions := strings.Split(input, ", ")
	result := make([]instruction, 0, len(instructions))

	for _, inst := range instructions {
		var rotation rotation
		switch inst[0] {
		case 'L':
			rotation = left
		case 'R':
			rotation = right
		default:
			panic(fmt.Sprintf("Invalid rotation: %s", string(inst[0])))
		}
		distance, _ := strconv.Atoi(inst[1:])
		result = append(result, instruction{rotation, distance})
	}

	return result
}

func part1(instructions []instruction) int {
	state := state{pos: coordinate{x: 0, y: 0}, dir: north}

	for _, instruction := range instructions {
		state.rotate(instruction.rotation)
		state.walk(instruction.distance)
	}

	return manhattenDistance(state.pos.x, state.pos.y, 0, 0)
}

func part2(instructions []instruction) int {
	state := state{pos: coordinate{x: 0, y: 0}, dir: north}
	visited := make(map[coordinate]bool)
	visited[state.pos] = true

	for _, instruction := range instructions {
		state.rotate(instruction.rotation)

		for i := 0; i < instruction.distance; i++ {
			state.walk(1)
			if visited[state.pos] {
				return state.pos.distanceFromOrigin()
			}
			visited[state.pos] = true
		}
	}

	return -1
}

func (d Day) Solve(input string) (int, int) {
	instructions := parseInput(input)
	return part1(instructions), part2(instructions)
}
