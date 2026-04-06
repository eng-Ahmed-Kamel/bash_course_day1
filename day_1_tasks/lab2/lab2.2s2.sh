#!/bin/bash
# -------- First way: Access exported variable --------
echo "Value of x using exported variable: $x"
# -------- Second way: Access argument --------
echo "Value of x using argument: $1"
# -------- third way: source argument --------
# Print the value of x from s1
echo "Value of x using source: $x"