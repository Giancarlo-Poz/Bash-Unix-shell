#!/bin/bash

# Output directory
output_dir="output"
mkdir -p "$output_dir"

# Function to check the word and character count of a file
check_limits() {
    local file="$1"
    local word_limit=$2
    local char_limit=$3

    words=$(wc -w < "$file")
    chars=$(wc -m < "$file")

    if [ "$words" -ge "$word_limit" ] || [ "$chars" -ge "$char_limit" ]; then
        return 1  # Exceeded limits
    else
        return 0  # Within limits
    fi
}

# Loop through each chunk file
current_file_index=1
current_output_file="$output_dir/joined_file_$current_file_index.txt"
word_limit=1300
char_limit=5000


index=1

while (($index <= 346)); do

    for ((i=$index; i <= 346; i++)); do
        head -n -1 chunk_$i.txt >> $current_output_file
        
        if ! check_limits "$current_output_file" "$word_limit" "$char_limit"; then
            break
        fi
    done
    
    if ((index == i)); then
        echo "error, maybe chunk_$idx.txt is longer than limits"
        exit 1
    fi


    # reset current_output_file

    echo "" > $current_output_file

    # fill until i-1
    for ((idx=$index; idx<i; idx++)); do
        head -n -1 chunk_$idx.txt >> $current_output_file
    done

    index=$i

    ((current_file_index++))
    current_output_file="$output_dir/joined_file_$current_file_index.txt"

done


