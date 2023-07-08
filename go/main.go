package main

import (
	"bufio"
	"fmt"
	"os"
)

func main() {
	file := os.Args[1]
	instructions, _ := os.ReadFile(file)
	tape := [30000]byte{}
	ptr := 0
	inputs := []byte{}
	bracketPairs := map[int]int{}

	unmatchedPairs := []int{}
	for index, bracket := range instructions {
		if string(bracket) == "[" {
			unmatchedPairs = append(unmatchedPairs, index)
		} else if string(bracket) == "]" {
			start := unmatchedPairs[len(unmatchedPairs)-1]
			unmatchedPairs = append(unmatchedPairs[:len(unmatchedPairs)-1], unmatchedPairs[len(unmatchedPairs):]...)
			bracketPairs[start] = index
			bracketPairs[index] = start
		}
	}

	for codePointer := 0; codePointer <= len(instructions)-1; codePointer++ {
		switch string(instructions[codePointer]) {
		case "+":
			if tape[ptr] == 255 {
				tape[ptr] = 0
			} else {
				tape[ptr]++
			}
		case "-":
			if tape[ptr] == 0 {
				tape[ptr] = 255
			} else {
				tape[ptr]--
			}
		case "<":
			if ptr == 0 {
				ptr = len(tape) - 1
			} else {
				ptr--
			}
		case ">":
			if ptr == len(tape)-1 {
				ptr = 0
			} else {
				ptr++
			}
		case ".":
			fmt.Printf("%c", tape[ptr])
		case ",":
			if len(inputs) < 1 {
				reader := bufio.NewReader(os.Stdin)
				input, _ := reader.ReadBytes('\n')
				inputs = append(input[:len(input)-1], input[len(input):]...)
			}

			tape[ptr] = inputs[0]
			inputs = append(inputs[:0], inputs[1:]...)
		case "[":
			if tape[ptr] == 0 {
				codePointer = bracketPairs[codePointer]
			}
		case "]":
			if tape[ptr] != 0 {
				codePointer = bracketPairs[codePointer]
			}
		}
	}
}
