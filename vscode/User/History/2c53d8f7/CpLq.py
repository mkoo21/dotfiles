import os
import sys
import subprocess

def check_arguments():
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <input_path> <output_path>", file=sys.stderr)
        sys.exit(1)

def check_paths(opts):
    if os.path.isdir(opts.inputPath)

def main():
    check_arguments()

    opts = { 
        "cleanupInputPath": False,
        "inputPath": sys.argv[1],
        "outputPath": sys.argv[2],
    }
    check_paths(opts)