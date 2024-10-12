#!/usr/bin/zsh

input=$1
output=$2
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <input_path> <output_path>"
  exit 1
fi


check_paths() {
  if [ -e $output ]; then
    echo "Output path $output already exists"
    exit 1
  elif [ ! -e $input ]; then
    echo "Input path $input is not a file or directory"
    exit 1
  fi
}

encrypt() {
  # tar input if it is a directory
  if [ -d $input ]; then
    # tar -zcf "$input.tar" "$input"
    # input="$input.tar"
  fi
  echo $input

  # gpg --output "$output.gpg" --symmetric --cipher-algo AES256 $input
}


check_paths
encrypt

