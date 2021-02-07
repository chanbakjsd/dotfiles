package main

import (
	"bufio"
	"fmt"
	"os"
	"os/exec"
	"time"
)

// Configuration options for the script.
const (
	AlertColour  = "#FFFFFF"
	DisplayLimit = 170
	Pace         = 100 * time.Millisecond
	FlickerCount = 5
)

func main() {
	defer handlePanic()

	output := make(chan string)
	go fetchJournalLog(output)

	ticker := time.NewTicker(Pace)
	line := "Waiting for journalctl..."
	flicker := FlickerCount*2 + 1 // Don't blink at start.
	scroll := -1
	for {
		select {
		case line = <-output:
			flicker = 0
			scroll = -1
			for len(line) < DisplayLimit {
				line += " "
			}
			if len(line) > DisplayLimit {
				// Just 10 spaces for padding during scroll.
				line += "          "
			}
			continue
		case <-ticker.C:
		}

		// Blink the text FlickerCount times.
		if flicker < FlickerCount*2 {
			flicker++

			text := line
			if len(text) > DisplayLimit {
				text = text[:DisplayLimit]
			}

			if flicker%2 == 1 {
				printAlert(text)
			} else {
				fmt.Println(text)
			}
			continue
		}

		if len(line) <= DisplayLimit {
			// No scroll if it's under DisplayLimit.
			continue
		}

		scroll++
		scroll %= len(line)
		if scroll+DisplayLimit <= len(line) {
			// Safe to just print a snippet.
			fmt.Println(line[scroll : scroll+DisplayLimit])
			continue
		}

		// Print the rest of the string.
		text := line[scroll:]
		// And wrap around.
		remainingSpace := len(line) - scroll
		text += line[:DisplayLimit-remainingSpace]
		fmt.Println(text)
	}
}

// fetchJournalLog blocks and listens to `journalctl -f`, feeding lines into the provided channel.
func fetchJournalLog(output chan<- string) {
	defer handlePanic()

	// NOTE: Maybe rewrite this at some point to use `-o json`?
	//       Don't see a point... yet however.
	cmd := exec.Command("/usr/bin/journalctl", "-f")
	stdout, err := cmd.StdoutPipe()
	if err != nil {
		panic(err)
	}
	if err := cmd.Start(); err != nil {
		panic(err)
	}

	bufferedOut := bufio.NewReader(stdout)

	for {
		line, err := bufferedOut.ReadString('\n')
		if err != nil {
			panic(err)
		}
		output <- line[:len(line)-1] // Remove the newline
	}
}

// printAlert prints the text in AlertColour.
func printAlert(alertText string) {
	fmt.Printf(`<span background="%s">%s</span>`+"\n", AlertColour, alertText)
}

// handlePanic is a helper function that recovers and prints out the error before terminating the program.
func handlePanic() {
	if err := recover(); err != nil {
		printAlert("Error: " + fmt.Sprint(err))
		os.Exit(1)
	}
}
