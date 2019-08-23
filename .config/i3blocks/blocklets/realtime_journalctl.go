package main

import (
	"bufio"
	"fmt"
	"os"
	"os/exec"
	"strings"
	"time"
)

const (
	WRAP_LENGTH            = 150
	REPEAT_SPACING         = 10
	ANIMATION_INTERVAL     = 100 * time.Millisecond
	BLINK_INTERVAL         = 5
	ALERT_BACKGROUND_COLOR = "#FFFFFF"
)

var currentLine []rune

func errorAndQuit(reason string) {
	fmt.Printf("<span background=\"%s\">Internal Error: %s</span>\n", ALERT_BACKGROUND_COLOR, reason)
	os.Exit(1)
}

func main() {
	journal := exec.Command("/usr/bin/journalctl", "-f")
	pipe, err := journal.StdoutPipe()
	reader := bufio.NewReader(pipe)
	if err != nil {
		errorAndQuit("Journalctl stdout pipe cannot be read: " + err.Error())
	}
	err = journal.Start()
	if err != nil {
		errorAndQuit("Journalctl command cannot be run: " + err.Error())
	}

	currentLine = []rune("Started listening to journalctl on " + time.Now().String())
	go streamLine()

	for {
		line, err := reader.ReadString('\n')
		if err != nil {
			errorAndQuit("IO Error: " + err.Error())
		}
		if strings.HasPrefix(line, "-- Logs begin at ") {
			continue
		}
		currentLine = []rune(line[:len(line)-1])
	}
}

func streamLine() {
	lastLine := currentLine
	loop := 0
	for {
		if !equal(lastLine, currentLine) {
			lastLine = currentLine
			loop = 0
		}
		//Actual looping code
		var displayText string
		for i := 0; i < WRAP_LENGTH; i++ {
			//Loop is kinda eh but it works.
			location := (loop + i) % (len(lastLine) + REPEAT_SPACING)
			if location >= len(lastLine) {
				displayText += " "
			} else {
				displayText += string(lastLine[location])
			}
		}
		if loop < BLINK_INTERVAL*4 && (loop%(BLINK_INTERVAL*2) < BLINK_INTERVAL) {
			fmt.Printf("<span background=\"%s\">%s</span>\n", ALERT_BACKGROUND_COLOR, displayText)
		} else {
			fmt.Println(displayText)
		}
		loop++
		time.Sleep(ANIMATION_INTERVAL)
	}
}

func equal(a, b []rune) bool {
	if len(a) != len(b) {
		return false
	}
	for i, v := range a {
		if b[i] != v {
			return false
		}
	}
	return true
}
