#!/bin/bash

# Variable
x_best=$1

# Function (compress a pdf)
input_file=$2
output_file="compressed_${input_file}"

gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dColorImageResolution=$x_best -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$output_file $input_file

# Output
size=$(stat -c %s "$output_file")
echo $size
