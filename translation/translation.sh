#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <input_text_file>"
  exit 1
fi

input_file="$1"
output_directory="output_chunks"

# Create output directory if not exists
mkdir -p "$output_directory"

# Function to split text based on rules
split_text() {
  local input="$1"
  local output_dir="$2"
  local max_words=1300
  local max_chars=4000
  local chunk_number=1
  local current_chunk_words=0
  local current_chunk_chars=0
  local current_chunk=""
  local current_line=0
  local line_number=0
  local total_lines=$(wc -l < "$input_file")
  local start_time=$(date +%s)
  local init_time=$(date +%s)
  local new_estimated_completion_time=0
  
  while IFS= read -r line; do
    ((line_number++))
    current_line=$((current_line + 1))

    # Calculate progress percentage
    progress=$((current_line * 100 / total_lines))

    # Calculate the percentage of completion
    local percentage=$((line_number * 100 / total_lines))
    
    end_time=$(date +%s)
elapsed_time=$((end_time - start_time))

# Calculate estimated time of completion
if [ "$line_number" -gt 0 ]; then
  remaining_lines=$((total_lines - line_number))
  estimated_completion_time=$((remaining_lines * elapsed_time / line_number))
else
  estimated_completion_time=0
fi

if ((line_number % 100 == 0)); then
    # Reset every 100 lines avoiding too low values of estimated_completion_time
    new_estimated_completion_time=0
fi
    
# Reset new_estimated_completion_time every 3 sec avoiding too low values of estimated_completion_time
    now_time=$(date +%s)
    
    if ((now_time - init_time >= 3)); then
        
        new_estimated_completion_time=0

        # Update the start time for the next iteration
        init_time=$now_time
    fi


if [ "$estimated_completion_time" -lt "$new_estimated_completion_time" ] || [ "$new_estimated_completion_time" -eq 0 ]; then
    new_estimated_completion_time=$estimated_completion_time
fi



# Get the current date in seconds since the epoch
current_time=$(date +%s)

# Calculate the estimated completion time by adding the estimated_completion_time
completion_time=$((current_time + new_estimated_completion_time))

# Convert the completion time back to a human-readable format
formatted_completion_time=$(date -d "@$completion_time" "+%Y-%m-%d %H:%M:%S")


    echo -ne "\rProcessing line $line_number of $total_lines. Completed $percentage%. Remaining $new_estimated_completion_time sec. Estimated completion time $formatted_completion_time          "


    # Check for maximum words condition
    if [ "$current_chunk_words" -ge "$max_words" ]; then
      # Save the current chunk
      echo -e "$current_chunk" > "$output_dir/chunk_$chunk_number.txt"
      ((chunk_number++))
      current_chunk=""
      current_chunk_words=0
      current_chunk_chars=0
    fi

    # Check for maximum characters condition
    if [ "$current_chunk_chars" -ge "$max_chars" ]; then
      # Save the current chunk
      echo -e "$current_chunk" > "$output_dir/chunk_$chunk_number.txt"
      ((chunk_number++))
      current_chunk=""
      current_chunk_words=0
      current_chunk_chars=0
    fi
 
    local count=0
    
    # Check if line is a title
    for (( i=0; i<${#line} && i<150; i++ )); do
        # Check if the character is a capital letter
        if [[ ${line:$i:1} == [[:upper:]] ]]; then
            # Increment the counter
            ((count++))
        fi
    done
    
    local threshold=$(echo $line | wc -m)
    threshold=$((threshold / 2))
    
    local title="False"
    if ((count > threshold)); then
        title="True"
    fi
        
    # Check for break conditions
    if [[ "$line" == "* * *" || $title == "True"  ]]; then
      if [ "$current_chunk_words" -gt 0 ]; then
        # Save the current chunk
        echo -e "$current_chunk" > "$output_dir/chunk_$chunk_number.txt"
        ((chunk_number++))
        current_chunk=""
        current_chunk_words=0
        current_chunk_chars=0
      fi
    fi

    # Append line to the current chunk
    current_chunk+="$line\n"
    ((current_chunk_words += $(echo "$line" | wc -w)))
    ((current_chunk_chars += $(echo -n "$line" | wc -c)))
  done < "$input"

  # Save the last chunk
  if [ "$current_chunk_words" -gt 0 ]; then
    echo -e "$current_chunk" > "$output_dir/chunk_$chunk_number.txt"
  fi
}

# Execute the split_text function
split_text "$input_file" "$output_directory"

# combine the file so you can compare with the original one
for ((i=1; i<=346; i++)); do
    head -n -1 $output_directory/chunk_$i.txt >> $output_directory/combined_file.txt
done

diff $output_directory/combined_file.txt $input_file

echo "   All done"

