#!/bin/bash

new_line_at() {
  local input=$1
  sed -i "0,/$input/s//&\n\n/" coverLetter_GiancarloPozzo.txt
}

currentDir=$(pwd)

cd "/home/giancarlo/MEGAsync/GiancarloDropbox/Dropbox/ongoing/job/CoverLetter/coverLetterGeneral"
pdftotext coverLetter_GiancarloPozzo.pdf #convert to txt
sed -i '1,10d' coverLetter_GiancarloPozzo.txt #delete first 10 lines
sed -i '$ d' coverLetter_GiancarloPozzo.txt #delete last line (because there is a unwanted character

# tr(anslate) new lines into a space. -s(queeze) double spaces into 1 spaces
tr -s '\n' ' ' < coverLetter_GiancarloPozzo.txt > coverLetter_GiancarloPozzo1.txt
mv coverLetter_GiancarloPozzo1.txt coverLetter_GiancarloPozzo.txt

#insert new lines
new_line_at "Dear Hiring Team,"
new_line_at "future plans."
new_line_at "2021 International eAssessment Awards."
new_line_at "MedTech Actuator’s competition."
new_line_at "international conferences."
new_line_at "perfect candidate for the role."
new_line_at "capability and productivity."
new_line_at "discuss the position."
sed -i "0,/Yours sincerely,/s//&\n/" coverLetter_GiancarloPozzo.txt

# remove space at the beginning of lines
sed -i 's/^[[:space:]]*//' coverLetter_GiancarloPozzo.txt

cd "$pwd"
