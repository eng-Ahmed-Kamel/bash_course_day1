#!/bin/bash
echo "This script made by:"
echo "Ahmed Kamel -- Lab 2.2"
# Define variable x
x=5
# -------- First way: Export variable --------
# Export makes the variable available to child scripts
export x
echo "Calling s2 using exported variable..."
./lab2.2s2.sh
# -------- Second way: Pass variable as argument --------
echo "Calling s2 using argument..."
./lab2.2s2.sh $x
# -------- third way: Pass variable as argument --------
# Call s2 using source so it runs in the same shell
source ./lab2.2s2.sh