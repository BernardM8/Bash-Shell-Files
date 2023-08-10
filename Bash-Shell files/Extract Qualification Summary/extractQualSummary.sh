#!/bin/bash

# Specify the directory path where the .docx files are located
directory="/home/files"

# Create an output file to store the extracted qualification summaries
output_file="Output.docx"

# Initialize the output file
echo "" > "$output_file"

# Loop through the .docx files in the directory
for file in "$directory"/*.docx; do
extracted_text=$(unzip -p "$file" word/document.xml | sed -e 's/<\/w:p>/\n/g; s/<[^>]\{1,\}>//g; s/[^[:print:]\n]\{1,\}//g')

  #Filter between Qualification summary and Techical skills
  filtered_text=$(echo "$extracted_text" | sed -n -e '/QUALIFICATION SUMMARY/,/TECHNICAL SKILLS/p' | grep -v 'QUALIFICATION SUMMARY\|TECHNICAL SKILLS')
  
  
  # Append the filtered text to the output file
  echo "$filtered_text"
  echo "$filtered_text" >> "$output_file"
done


awk '!seen[$0]++' "$output_file" > "${output_file}.tmp"
mv "${output_file}.tmp" "$output_file"


echo "Extraction completed. The qualification summaries have been saved to $output_file."

