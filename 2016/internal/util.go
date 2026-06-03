package internal

import "strings"

func Lines(input string) []string {
	return strings.Split(strings.TrimSpace(input), "\n")
}
