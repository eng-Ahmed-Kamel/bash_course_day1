#!/bin/bash
# This script lists directory contents similar to the ls command
# It supports the following options:
# -l : list in long format
# -a : list all entries including hidden files
# -d : if the argument is a directory, list only its name
# -i : print inode number
# -R : recursively list subdirectories
# If no directory is provided → list the current directory
#===========================================================
echo "This script made by:"
echo "Ahmed Kamel -- Lab 2.6"
# Example usage:
# ./lab2.6.sh                   # list current directory
# ./lab2.6.sh /etc              # list /etc directory
# ./lab2.6.sh -l                # long format of current directory
# ./lab2.6.sh -l /etc           # long format of /etc directory
# ./lab2.6.sh -a                # show hidden files in current directory
# ./lab2.6.sh -a /etc           # show hidden files in /etc directory
# ./lab2.6.sh -d /etc           # list only the name of /etc directory
# ./lab2.6.sh -i                # show inode numbers in current directory
# ./lab2.6.sh -i /etc           # show inode numbers in /etc directory
# ./lab2.6.sh -R                # recursively list current directory
# ./lab2.6.sh -R /etc           # recursively list /etc directory
# Default directory is current directory
dir="."
# Check if the last argument is a directory
if [ -d "${!#}" ]; then
    dir="${!#}"
fi
# Initialize empty option variable
option=""
# Process options
while getopts "ladiR" opt
do
    case $opt in
        l) option="$option -l" ;;
        a) option="$option -a" ;;
        d) option="$option -d" ;;
        i) option="$option -i" ;;
        R) option="$option -R" ;;
        *) echo "Invalid option"; exit 1 ;;
    esac
done
# Run ls with the selected option(s)
ls $option "$dir"