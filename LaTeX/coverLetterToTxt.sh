#!/bin/bash

currentDir=$(pwd)

cd "/home/giancarlo/MEGAsync/GiancarloDropbox/Dropbox/ongoing/job/CoverLetter/coverLetterGeneral"
pdftotext coverLetter_GiancarloPozzo.pdf #convert to txt
sed -i '1,10d' coverLetter_GiancarloPozzo.txt #delete first 10 lines
sed -i '$ d' coverLetter_GiancarloPozzo.txt #delete last line (because there is a unwanted character

# tr(anslate) new lines into a space. -s(queeze) double spaces into 1 spaces
tr -s '\n' ' ' < coverLetter_GiancarloPozzo.txt > coverLetter_GiancarloPozzo1.txt
mv coverLetter_GiancarloPozzo1.txt coverLetter_GiancarloPozzo.txt

#insert new lines
#sed -i 's/Dear Hiring Team,/&\n\n/g' coverLetter_GiancarloPozzo.txt
#sed -i '0,/Dear Hiring Team, /s//&\n\n/' coverLetter_GiancarloPozzo.txt
#sed -i 's/substring/&\n\n/g' file.txt

#future plans.

cd "$pwd"
