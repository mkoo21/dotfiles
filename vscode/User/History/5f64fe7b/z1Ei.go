package main // change this later; this is only main for now out of expedience

import (
	"log"
	"os"
)

func main() {
	err := CheckArgs(2)
	if err != nil {
		log.Fatal(err)
		os.Exit(1)
	}
}
