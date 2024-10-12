#!/usr/bin/zsh

input=$1
output=$2
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <input_path> <output_path>"
  exit 1
fi


check_paths() {
  if [ -e $output ]; then
    echo "Output path $2 already exists"
    exit 1
  elif [ ! -e $input ]; then
    echo "Input path $1 is not a file or directory"
    exit 1
  fi
}

encrypt() {
  # if input is directory
  tar -cf $1 
}


check_paths $1 $2

