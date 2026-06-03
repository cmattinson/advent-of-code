package day02

import (
	"testing"
)

func TestSolve(t *testing.T) {
	d := Day{}
	result, _ := d.Solve("ULL\nRRDDD\nLURDL\nUUUUD\n")

	if got, want := result, 1985; got != want {
		t.Errorf("Expected %d, got %d", want, got)
	}
}
