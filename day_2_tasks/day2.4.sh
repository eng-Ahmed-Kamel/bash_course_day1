#!/bin/bash
echo "This script made by: Ahmed Kamel -- Lab 2.4"
# This script creates a backup of all files in a specified directory using the find command.
# It takes the directory path as an argument, changes to that directory, creates a backup directory with a timestamp, and 
# then uses find to copy only the files (not directories) to the backup
# Example usage: ./day2.4.sh  /home/ozi/bash_course/day_2_tasks
path=$1
# Change to the home directory
cd $path
# Create a backup directory if it doesn't exist
backup_dir="backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$backup_dir"
# Use find to copy only files to the backup directory
find . -maxdepth 1 -type f -exec cp {} "$backup_dir" \;
echo "Backup of files has been created in the directory: $backup_dir"   