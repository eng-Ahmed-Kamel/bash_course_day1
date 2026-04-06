#!/bin/bash
echo "This script made by:"
echo "Ahmed Kamel -- Lab 2.3"
# This script copies files similar to the cp command
# It supports:
# 1. Copying one file to another file
# 2. Copying multiple files to a directory
#example usage:
# ./lab2.3.sh file1.txt file2.txt
# ./lab2.3.sh file1.txt file2.txt dir/
# Check if the number of arguments is less than 2
if [ $# -lt 2 ]; then
    echo "Usage: mycp source_file [source_files...] destination"
    exit 1
fi
# Get the last argument as destination
dest=${!#}
# Case 1: If only two arguments → copy file to file
if [ $# -eq 2 ]; then
    cp "$1" "$dest"
    echo "File copied from $1 to $dest"
# Case 2: If more than two arguments → copy multiple files to directory
else
    # Check if destination is a directory
    if [ ! -d "$dest" ]; then
        echo "Error: Destination must be a directory for multiple files."
        exit 1
    fi
    # Copy all files except the last argument
    for file in "${@:1:$#-1}"
    do
        cp "$file" "$dest"
        echo "Copied $file to $dest"
    done
fi