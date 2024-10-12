package main

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
