import os
import sys
import subprocess

def check_arguments():
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <input_path> <output_path>", file=sys.stderr)
        sys.exit(1)

def check_paths(opts):
    input_path = opts["inputPath"]
    # directories need to be archived prior
    if os.path.isdir(input_path):
         tar_out_path = f"{input_path}.tar.gz"
         command = ["tar", "-czf", tar_out_path, input_path]
         res = subprocess.run(command)


if __name__ == "__main__":
    check_arguments()

    opts = { 
        "cleanupInputPath": False,
        "inputPath": sys.argv[1],
        "outputPath": sys.argv[2],
    }
    check_paths(opts)