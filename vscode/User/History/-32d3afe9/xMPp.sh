#!/usr/bin/zsh

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <input_path> <output_path>"
  exit 1
fi


check_paths() {
  
}

tar_path() {
  # if input is directory
  tar -cf $1 
}

echo "$1.tar"

