import os
import sys
import subprocess

def check_arguments():
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <input_path> <output_path>", file=sys.stderr)
        sys.exit(1)

def check_paths():
    pass

def main():
    check_arguments()

    flags = { cleanupInputPath: false };
    check_paths()