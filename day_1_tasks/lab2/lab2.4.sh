#!/bin/bash
# This script changes the directory
# If no argument is provided → go to the user's home directory
# If an argument is provided → go to the specified directory
#Important note: If you run this script normally (e.g., ./lab2.4.sh),
# it will change the directory only for the duration of the script. 
#Once the script finishes, you will be back to your original directory in the terminal.
#To change the current shell directory, you must run it with:
#source ./lab2.4.sh
#===========================================================
echo "This script made by:"
echo "Ahmed Kamel -- Lab 2.4"
#example usage:
# ./lab2.4.sh          # goes to home directory
# ./lab2.4.sh /path/to/directory  # goes to the specified directory
# Check if no arguments were passed
if [ $# -eq 0 ]; then
    # Change to home directory
    cd "$HOME"
else
    # Change to the directory given as argument
    cd "$1"
fi
# Print the current directory after change
pwd