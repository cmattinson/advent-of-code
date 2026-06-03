package day01

import (
	"testing"
)

func TestSolve(t *testing.T) {
	d := Day{}

	tests := []struct {
		input  string
		expect int
	}{
		{"R2, L3", 5},
		{"R2, R2, R2", 2},
		{"R5, L5, R5, R3", 12},
	}

	for _, test := range tests {
		t.Run(test.input, func(t *testing.T) {
			value, _ := d.Solve(test.input)
			if value != test.expect {
				t.Errorf("Expected %d, got %d", test.expect, value)
			}
		})
	}
}
