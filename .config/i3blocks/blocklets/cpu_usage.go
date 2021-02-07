package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
	"time"
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

	ticker := time.NewTicker(5 * time.Second)
	lastEntry := readProcStat()
	for {
		<-ticker.C
		nextEntry := readProcStat()
		diff := make([]float64, len(nextEntry))
		total := 0.0
		for k := range diff {
			diff[k] = nextEntry[k] - lastEntry[k]
			total += diff[k]
		}
		busy := 1 - diff[3]/total

		display := " " + fmt.Sprintf("%5.2f%%", busy*100)
		switch {
		case busy > CritLimit:
			printInColour(display, CritColour)
		case busy > MaxLimit:
			printInColour(display, MaxColour)
		case busy > WarnLimit:
			printInColour(display, WarnColour)
		default:
			fmt.Println(display)
		}

		lastEntry = nextEntry
	}
}

func readProcStat() []float64 {
	bytes, err := ioutil.ReadFile("/proc/stat")
	if err != nil {
		panic(err)
	}
	line := strings.Split(string(bytes), "\n")[0]
	result := []float64{}
	for _, v := range strings.Split(line, " ") {
		if v == "" || v == "cpu" {
			continue
		}
		value, err := strconv.ParseFloat(v, 64)
		if err != nil {
			panic(err)
		}
		result = append(result, value)
	}
	return result
}

// printInColour prints the message in the provided colour.
func printInColour(message string, colour string) {
	fmt.Printf(`<span foreground="%s">%s</span>`+"\n", colour, message)
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
