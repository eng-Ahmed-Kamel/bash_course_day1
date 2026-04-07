#!/bin/bash
echo "This script made by: Ahmed Kamel -- Lab 2.2"
# This script asks the user to enter a string and checks its type using a case statement.
# It identifies whether the string contains uppercase letters, lowercase letters, numbers, or special characters,
# and prints an appropriate message based on the content of the string. If the string is empty, it also handles that case.
# Example usage: ./day2.2.sh

# Ask user to enter a string
echo "Enter a string: "
read  input

case "$input" in
    "")
        echo "You entered nothing."
        ;;
    *[A-Za-z]*[0-9]*|*[0-9]*[A-Za-z]*)
        echo "The string '$input' is a Mix of Letters and Numbers."
        ;;
    *[A-Z]*[a-z]*|*[a-z]*[A-Z]*)
        echo "The string '$input' is a Mix of Upper and Lower Case letters."
        ;;
    *[A-Z]*)
        echo "The string '$input' contains Upper Case letters."
        ;;
    *[a-z]*)
        echo "The string '$input' contains Lower Case letters."
        ;;
    *[0-9]*)
        echo "The string '$input' is a Number."
        ;;
    *)
        echo "The string '$input' is a special character or symbol."
        ;;
esac