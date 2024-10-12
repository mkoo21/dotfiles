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

func checkArgs() error {
	// Basic args check
	if len(os.Args) != 3 {
		re := regexp.MustCompile(`\/([^\/]*)$`)
		ownname := re.FindStringSubmatch(os.Args[0])[1]
		return errors.New(fmt.Sprintf("Usage: %s <input-path> <output-path>\n", ownname))
	}
	return nil
}

func checkPaths() (string, error) {
	inputPath := os.Args[1]
	// outputPath := os.Args[2]
	encryptPath := inputPath

	// check existence
	inputInfo, err := os.Stat(inputPath)
	if os.IsNotExist(err) {
		return "", errors.New(fmt.Sprintf("Input path %s does not exist", inputPath))
	}
	// outputInfo, err := os.Stat(outputPath)
	// if outputInfo != nil {
	// 	return "", errors.New(fmt.Sprintf("Output path %s already exists", outputPath))
	// }

	// if input is directory it must be tarred first (double check if gpg cleans up after itself, too)
	if inputInfo.IsDir() {
		tarOutPath := fmt.Sprintf("%s.tar.gz", inputPath)
		cmd := exec.Command("tar", "-czf", tarOutPath, inputPath)
		err := cmd.Run()
		if err != nil {
			return "", err
		}
		encryptPath = tarOutPath
	}

	return encryptPath, nil

}

func encrypt(inPath string, outPath string) error {

}

func main() {
	err := checkArgs()
	if err != nil {
		log.Fatal(err)
		os.Exit(1)
	}
	inputPath, err := checkPaths()
	if err != nil {
		log.Fatal(err)
		os.Exit(1)
	}

	outputPath := os.Args[2]
	err = encrypt(inputPath, outputPath)
	if err != nil {
		log.Fatal(err)
		os.Exit(1)
	}

	// Get the path from the arguments
	// path := os.Args[1]

	// // Check if the path exists
	// info, err := os.Stat(path)
	// if os.IsNotExist(err) {
	// 	fmt.Printf("Error: Path '%s' does not exist\n", path)
	// 	os.Exit(1)
	// } else if err != nil {
	// 	fmt.Printf("Error checking path: %v\n", err)
	// 	os.Exit(1)
	// }

	// // Determine if it's a file or directory
	// if info.IsDir() {
	// 	fmt.Printf("'%s' is a directory\n", path)
	// } else {
	// 	fmt.Printf("'%s' is a file\n", path)
	// }

	// // Now let's assume we want to run a system binary like 'gpg'
	// // Example: run 'gpg --version' to check if it's installed and working
	// cmd := exec.Command("gpg", "--version")
	// output, err := cmd.CombinedOutput()
	// if err != nil {
	// 	log.Fatalf("Error running gpg: %v", err)
	// }

	// fmt.Printf("\n'gpg --version' output:\n%s\n", output)
}
