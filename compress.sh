#!/bin/bash

# usage
# ./compress_PDF.sh input.pdf compress_input.pdf 

input_file=$1
output_file=$2

#modify to get a file less then another threshold
threshold=10000000 # 1000000 = 1 MB

# TODO find the best starting point
starting_value=30




#size of the input
size_input=$(stat -c %s "$input_file")

#if size of input is already smaller than threshold, print and exit
if (( size_input < threshold )); then
echo "The size of $input_file is $(stat -c %s $input_file | numfmt --to=iec) and it is already smalle than the threshold $threshold ($(numfmt --to=iec $threshold))"
echo "You may want to decrease the threshold $threshold in the source code, getting a lower quality output"
exit 0
fi


# run the command with the current value of option
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dColorImageResolution=$starting_value -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$output_file $input_file

#size of the output
size=$(stat -c %s "$output_file")

option_value=$starting_value

#if size is bigger than threshold print and exit
if (( size >= threshold )); then

    echo -n "trying -dColorImageResolution=$option_value"

    while (( size >= threshold )); do
        option_value=$((option_value - 10))
        
        gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dColorImageResolution=$option_value -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$output_file $input_file
        
        size=$(stat -c %s "$output_file")
        echo -n ", $option_value"
    done

    #fine-grain option_value
    while (( size < threshold )); do
        option_value=$((option_value + 1))
        
        gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dColorImageResolution=$option_value -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$output_file $input_file
        
        size=$(stat -c %s "$output_file")
        echo -n ", $option_value"
    done

    # go back to the previous option_value such that size < threshold and compress with this option
    option_value=$((option_value - 1))
    
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dColorImageResolution=$option_value -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$output_file $input_file
    
    echo -e "\n"

    echo "done! $input_file file has been minimally compressed to be less than the threshold $threshold ($(numfmt --to=iec $threshold)). Now $output_file has a size of $(stat -c %s $output_file | numfmt --to=iec) (or $(stat -c %s $output_file) bytes)."
    echo ""
    echo "The command to compress is:"
    echo "gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dColorImageResolution=$option_value -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$output_file $input_file"

exit 0
fi


echo -n "trying -dColorImageResolution=$option_value"

while (( size < threshold )); do
    option_value=$((option_value + 10))
    
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dColorImageResolution=$option_value -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$output_file $input_file
    
    size=$(stat -c %s "$output_file")
    echo -n ", $option_value"
done

#fine-grain option_value
while (( size >= threshold )); do
    option_value=$((option_value - 1))
    
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dColorImageResolution=$option_value -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$output_file $input_file
    
    size=$(stat -c %s "$output_file")
    echo -n ", $option_value"
done

echo -e "\n"

echo "done! $input_file file has been minimally compressed to be less than the threshold $threshold ($(numfmt --to=iec $threshold)). Now $output_file has a size of $(stat -c %s $output_file | numfmt --to=iec) (or $(stat -c %s $output_file) bytes)."
echo ""
echo "The command to compress is:"
echo "gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dColorImageResolution=$option_value -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$output_file $input_file"



