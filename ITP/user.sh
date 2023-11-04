#!/bin/bash

# Variable 
# Must be an element of real numbers (or an element of a subset of real numbers)
variable=$1

# Change only the value (right hand side) according to your specification
# Do not change the variable name (left hand side)
variable_min=30
variable_max=100


# TO DO CHECK posix compliance? is it the right first try according to ITP?
# Do not change
first_try=$(( ($variable_max - $variable_min)/2 )) # TO CHANGE
variable=${variable:-$first_try}


# Function. Can be whatever you want (eg. compress a pdf)
input_file=$2
output_file="compressed_${input_file}"

gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dColorImageResolution=$variable -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$output_file $input_file


# Output
# Do not change the variable name (left hand side)
# Must be an element of real numbers (or an element of a subset of real numbers)
output=$(stat -c %s "$output_file")

# Do not change the following line
echo $variable_min $variable_max $output
