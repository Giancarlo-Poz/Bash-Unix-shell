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



    echo -ne "\rProcessing line $line_number of $total_lines. Completed $percentage%. Remaining $estimated_completion_time sec. Estimated completion time $(date -d@$estimated_completion_time)"
 
    
    # Check for break conditions
    if [[ "$line" == "* * *" || $(echo "$line" | awk '{ print length }') -gt $(($max_chars/2)) ]]; then
      if [ "$current_chunk_words" -gt 0 ]; then
        # Save the current chunk
        echo -e "$current_chunk" > "$output_dir/chunk_$chunk_number.txt"
        ((chunk_number++))
        current_chunk=""
        current_chunk_words=0
        current_chunk_chars=0
      fi
    fi

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
echo "   All done"

