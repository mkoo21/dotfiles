package main

import (
	"errors"
	"fmt"
	"os"
	"regexp"
)

func CheckArgs(numArgs int) error {
	// Basic args check
	if len(os.Args) != numArgs+1 {
		re := regexp.MustCompile(`\/([^\/]*)$`) // parse filename from path
		ownname := re.FindStringSubmatch(os.Args[0])[1]
		return errors.New(fmt.Sprintf("Usage: %s <input-path> <output-path>\n", ownname))
	}
	return nil
}
