package main

import (
	"fmt"
	"os"
	"os/exec"
	"strconv"
	"strings"
)

// Threshold that defines different levels of warning.
const (
	WarnLimit = 0.5
	MaxLimit  = 0.8
	CritLimit = 0.9
)

// Colours to display.
const (
	WarnColour = "#FFF600"
	MaxColour  = "#FF4444"
	CritColour = "#FF0000"
)

func main() {
	defer handlePanic()

	fs := []string{"/"}
	if len(os.Args) >= 2 {
		fs = os.Args[1:]
	}

	cmd := exec.Command("/usr/bin/df", append([]string{"--output=size,used"}, fs...)...)
	bytes, err := cmd.Output()
	if err != nil {
		panic(err)
	}

	critReached := false
	maxReached := false
	warnReached := false

	lines := strings.Split(string(bytes), "\n")
	result := make([]string, 0, len(lines))
	for k, line := range lines {
		if k == 0 || line == "" {
			continue
		}
		split := strings.Fields(line)

		size, err := strconv.Atoi(split[0])
		if err != nil {
			panic(err)
		}
		usedSectors, err := strconv.Atoi(split[1])
		if err != nil {
			panic(err)
		}

		used := float64(usedSectors) / float64(size)
		usedPercent := fmt.Sprintf("%.2f%%", used*100)

		switch {
		case used > CritLimit:
			critReached = true
		case used > MaxLimit:
			maxReached = true
		case used > WarnLimit:
			warnReached = true
		}

		result = append(result, usedPercent)
	}

	display := strings.Join(result, "|")

	fmt.Println(display)
	fmt.Println(display)
	switch {
	case critReached:
		fmt.Println(CritColour)
	case maxReached:
		fmt.Println(MaxColour)
	case warnReached:
		fmt.Println(WarnColour)
	}
}

// handlePanic is a helper function that recovers and prints out the error before terminating the program.
func handlePanic() {
	if err := recover(); err != nil {
		// Make it safe in the config bar.
		fmt.Println("ERROR\nERROR\n#FF0000\n", err)
		// Pass it on.
		panic(err)
	}
}
