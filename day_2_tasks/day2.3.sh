#!/bin/bash
echo "This script made by: Ahmed Kamel -- Lab 2.3"
# This script adds execute permission to all files and directories in a specified directory using the find command.
# It takes the directory path as an argument, changes to that directory, and then uses find to add execute permission to all files and directories.
# Note: Be cautious when running this script, as it will make all files and directories executable, which may not be desirable in all cases.
# Example usage: ./day2.3.sh /home/ozi/bash_course/day_2_tasks
path=$1
# Change to the home directory
cd $path 
# Use find to give execute permission to all files and directories
find . -type f -exec chmod +x {} \;
find . -type d -exec chmod +x {} \;
echo "Execute permission has been added to all files and directories in your home directory."   
