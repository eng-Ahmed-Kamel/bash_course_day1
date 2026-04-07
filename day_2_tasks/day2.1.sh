#!/bin/bash
echo "This script made by: Ahmed Kamel -- Lab 2.1"
# This script asks the user to enter a character and checks its type using a case statement.
# It identifies whether the character is an uppercase letter, lowercase letter, number, or special character
# and prints an appropriate message based on the content of the character. If the character is empty, it also handles that case.
# Example usage: ./day2.1.sh    
# Ask user to enter a character
read -p "Enter a character: " char
# Check the type of character using case
case $char in
    [A-Z])   echo "The character '$char' is an Upper Case letter."     ;;
    [a-z])   echo "The character '$char' is a Lower Case letter."    ;;
    [0-9])   echo "The character '$char' is a Number."       ;;
    "")      echo "You entered nothing."       ;;
    *)       echo "The character '$char' is a special character or symbol."       ;;
esac            
