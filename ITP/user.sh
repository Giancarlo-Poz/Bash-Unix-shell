#!/bin/bash

# Variable 
# Must be an element of real numbers (or an element of a subset of real numbers)
variable=$1


# These falues are defined here but read by another file
# Change only the right hand side according to your specification
# Do not change the left hand side
variable_min=30
variable_max=100


# Function. Can be whatever you want (eg. compress a pdf)
input_file=$2
output_file="compressed_${input_file}"

gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dColorImageResolution=$variable -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$output_file $input_file


# Output
# Must be an element of real numbers (or an element of a subset of real numbers)
size=$(stat -c %s "$output_file")
echo $size
