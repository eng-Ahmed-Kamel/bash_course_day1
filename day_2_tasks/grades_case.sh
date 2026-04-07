#!/bin/bash
echo "This script made by: Ahmed Kamel -- Lab 1.1"
# This script asks the user to enter a student's grade (0-100) and determines the corresponding letter grade using a case statement.
# It first checks if the input is a valid number between 0 and 100. If the input is valid, it uses a case statement to assign a letter grade based on the numeric grade
# and prints the result. If the input is invalid, it displays an error message and exits.
# Example usage: ./grades_case.sh

# Ask user to enter the grade
read -p "Enter the student's grade (0-100): " grade
# Check if input is a number between 0 and 100
if ! [[ "$grade" =~ ^[0-9]+$ ]] || [ "$grade" -lt 0 ] || [ "$grade" -gt 100 ]; then
    echo "Invalid grade. Please enter a number between 0 and 100."
    exit 1
fi
# Determine letter grade using case
case $grade in
    9[0-9]|100)
        letter="A"
        ;;
    8[0-9])
        letter="B"
        ;;
    7[0-9])
        letter="C"
        ;;
    6[0-9])
        letter="D"
        ;;
    *)
        letter="F"
        ;;
esac

echo "The grade $grade corresponds to letter grade: $letter"