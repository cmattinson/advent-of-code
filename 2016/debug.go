package main

import (
	"fmt"
	"math"
	"os"
	"strconv"
	"strings"
)

type Rotation int
type Direction int

const (
	Left Rotation = iota
	Right
)

const (
	North Direction = iota
	South
	East
	West
)

type Instruction struct {
	rotation Rotation
	distance int
}

type State struct {
	x, y int
	dir  Direction
}

func parseInput(input string) []Instruction {
	instructions := strings.Split(input, ", ")
	result := make([]Instruction, 0, len(instructions))

	for _, instruction := range instructions {
		var rotation Rotation
		switch instruction[0] {
		case 'L':
			rotation = Left
		case 'R':
			rotation = Right
		default:
			panic(fmt.Sprintf("Invalid rotation: %s", string(instruction[0])))
		}
		distance, _ := strconv.Atoi(instruction[1:])
		result = append(result, Instruction{rotation, distance})
	}

	return result
}

func (s *State) rotate(r Rotation) {
	switch r {
	case Left:
		switch s.dir {
		case North:
			s.dir = West
		case West:
			s.dir = South
		case South:
			s.dir = East
		case East:
			s.dir = North
		}
	case Right:
		switch s.dir {
		case North:
			s.dir = East
		case East:
			s.dir = South
		case South:
			s.dir = West
		case West:
			s.dir = North
		}
	}
}

func (s *State) walk(distance int) {
	switch s.dir {
	case North:
		s.y += distance
	case South:
		s.y -= distance
	case East:
		s.x += distance
	case West:
		s.x -= distance
	}
}

func manhattenDistance(x1, y1, x2, y2 float64) int {
	return int(math.Abs(x1-x2) + math.Abs(y1-y2))
}

func main() {
	// Read from file to compare
	bytes, _ := os.ReadFile("inputs/day01.txt")
	input := string(bytes)

	instructions := parseInput(input)
	state := State{x: 0, y: 0, dir: North}

	fmt.Printf("Total instructions: %d\n\n", len(instructions))
	fmt.Printf("Starting at (%d, %d) facing %s\n\n", state.x, state.y, directionString(state.dir))

	for i, instruction := range instructions {
		state.rotate(instruction.rotation)
		state.walk(instruction.distance)

		if i == len(instructions)-1 || (i+1)%20 == 0 {
			fmt.Printf("Step %d: %s -> pos (%d,%d), facing %s\n", i+1, instructionString(instruction), state.x, state.y, directionString(state.dir))
		}
	}

	distance := manhattenDistance(float64(state.x), float64(state.y), 0.0, 0.0)
	fmt.Printf("\nFinal position: (%d, %d)\n", state.x, state.y)
	fmt.Printf("Manhattan distance: %d\n", distance)
}

func instructionString(i Instruction) string {
	switch i.rotation {
	case Left:
		return fmt.Sprintf("L%d", i.distance)
	case Right:
		return fmt.Sprintf("R%d", i.distance)
	}
	return ""
}

func directionString(d Direction) string {
	switch d {
	case North:
		return "North"
	case South:
		return "South"
	case East:
		return "East"
	case West:
		return "West"
	}
	return ""
}
