package main

import (
	"fmt"
	"os/exec"
	"sort"
	"strconv"
	"strings"
)

// Limits that define different levels of warnings.
const (
	WarnLimit = 10
	CritLimit = 5
)

// Colours to display.
const (
	WarnColour = "#FFF600" // WarnLimit degrees under max temperature.
	MaxColour  = "#FF4444" // Over max degrees.
	CritColour = "#FF0000" // CritLimit degrees under critical temperature.
)

func main() {
	defer handlePanic()

	cmd := exec.Command("/usr/bin/sensors", "-u")

	outputBytes, _ := cmd.Output()
	output := string(outputBytes)

	critReached := false
	maxReached := false
	warnReached := false
	current := -1.0
	max := -1.0
	crit := -1.0

	currentList := []float64{}

	registerEntry := func() {
		if current == -1 {
			current = -1
			max = -1
			crit = -1
			return
		}
		if current > crit-CritLimit {
			critReached = true
		}
		if current > max {
			maxReached = true
		}
		if current > max-WarnLimit {
			warnReached = true
		}
		currentList = append(currentList, current)
		current = -1
		max = -1
		crit = -1
	}

	for _, v := range strings.Split(output, "\n") {
		if !strings.HasPrefix(v, "  ") {
			registerEntry()
			continue
		}

		split := strings.Split(v, ": ")
		var err error
		switch {
		case strings.HasSuffix(split[0], "_input"):
			current, err = strconv.ParseFloat(split[1], 64)
		case strings.HasSuffix(split[0], "_max"):
			max, err = strconv.ParseFloat(split[1], 64)
		case strings.HasSuffix(split[0], "_crit"):
			crit, err = strconv.ParseFloat(split[1], 64)
		}

		if err != nil {
			panic(err)
		}
	}
	registerEntry()

	sort.Float64s(currentList)
	highest := currentList[len(currentList)-1]
	fmt.Printf("%.1f°C\n", highest)
	fmt.Printf("%.1f°C\n", highest)

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
