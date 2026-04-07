#!/bin/bash
echo "This script made by: Ahmed Kamel -- Lab 1.3"
# Ask user to enter the grade
read -p "Enter the student's grade (0-100): " grade
# Check if input is a number between 0 and 100
if ! [[ "$grade" =~ ^[0-9]+$ ]] || [ "$grade" -lt 0 ] || [ "$grade" -gt 100 ]; then
    echo "Invalid grade. Please enter a number between 0 and 100."
    exit 1
fi
# Determine letter grade
if [ "$grade" -ge 90 ]; then
    letter="A"
elif [ "$grade" -ge 80 ]; then
    letter="B"
elif [ "$grade" -ge 70 ]; then
    letter="C"
elif [ "$grade" -ge 60 ]; then
    letter="D"
else
    letter="F"
fi
echo "The grade $grade corresponds to letter grade: $letter"