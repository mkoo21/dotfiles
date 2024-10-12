package main // change this later; this is only main for now out of expedience

import (
	"errors"
	"fmt"
	"log"
	"os"
	"os/exec"
	"regexp"
	// "path/filepath"
)

type EncryptOpts struct {
	CleanupInputPath bool
}

func checkArgs() error {
	// Basic args check
	if len(os.Args) != 3 {
		re := regexp.MustCompile(`\/([^\/]*)$`)
		ownname := re.FindStringSubmatch(os.Args[0])[1]
		return errors.New(fmt.Sprintf("Usage: %s <input-path> <output-path>\n", ownname))
	}
	return nil
}

func checkPaths(opts *EncryptOpts) (string, error) {
	inputPath := os.Args[1]
	// outputPath := os.Args[2]
	encryptPath := inputPath

	// check existence
	inputInfo, err := os.Stat(inputPath)
	if os.IsNotExist(err) {
		return "", errors.New(fmt.Sprintf("Input path %s does not exist", inputPath)), nil
	}
	if inputInfo.IsDir() {
		tarOutPath := fmt.Sprintf("%s.tar.gz", inputPath)
		cmd := exec.Command("tar", "-czf", tarOutPath, inputPath)
		err := cmd.Run()
		if err != nil {
			return "", err
		}
		encryptPath = tarOutPath
		opts.CleanupInputPath = true
	}

	return encryptPath, nil

}

func encrypt(inPath string, outPath string, opts *EncryptOpts) error {
	cmd := exec.Command("gpg", "--symmetric", "--output", outPath, inPath)
	_, err := cmd.CombinedOutput()
	if err != nil {
		return err
	}

	if opts.CleanupInputPath {
		os.Remove(inPath)
	}
	return nil
}

func main() {
	err := checkArgs()
	if err != nil {
		log.Fatal(err)
		os.Exit(1)
	}
	opts := EncryptOpts{
		CleanupInputPath: false,
	}
	inputPath, err := checkPaths(&opts)
	if err != nil {
		log.Fatal(err)
		os.Exit(1)
	}

	outputPath := os.Args[2]
	err = encrypt(inputPath, outputPath, &opts)
	if err != nil {
		log.Fatal(err)
		os.Exit(1)
	}

}
