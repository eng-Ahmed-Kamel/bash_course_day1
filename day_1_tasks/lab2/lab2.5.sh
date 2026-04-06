#!/bin/bash
# This script lists directory contents
# If no argument is provided → list the current directory
# If an argument is provided → list the specified directory
#===========================================================
echo "This script made by:"
echo "Ahmed Kamel -- Lab 2.5"
#example usage:
# ./lab2.5.sh          # lists current directory
# ./lab2.5.sh /path/to/directory  # lists the specified directory
# Check if no arguments were passed
if [ $# -eq 0 ]; then
    # List current directory
    ls
else
    # List the directory given as argument
    ls "$1"
fi