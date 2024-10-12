#!/usr/bin/zsh

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <input_path> <output_path>"
  exit 1
fi


check_paths() {
  if [ -e $2 ]; then
    echo "Output path $2 already exists"
    exit 1
  elif [ ! -e $1 ]
    echo "Input path $1 is not a file or directory"
    exit 1
  fi

  # if [ -d "$1" ]; then
  #   tar -zcf "$1.tar" "$1"
  # fi
}

tar_path() {
  # if input is directory
  tar -cf $1 
}


check_paths $1 $2

