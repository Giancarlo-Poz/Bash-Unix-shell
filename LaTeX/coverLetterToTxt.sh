#!/bin/bash

currentDir=$(pwd)

cd "/home/giancarlo/MEGAsync/GiancarloDropbox/Dropbox/ongoing/job/CoverLetter/coverLetterGeneral"
pdftotext coverLetter_GiancarloPozzo.pdf #convert to txt
sed -i '1,10d' coverLetter_GiancarloPozzo.txt #delete first 10 lines
sed -i '$ d' coverLetter_GiancarloPozzo.txt #delete last line (because there is a unwanted character

#delete all new lines
tr -d '\n' < coverLetter_GiancarloPozzo.txt > coverLetter_GiancarloPozzo1.txt
mv coverLetter_GiancarloPozzo1.txt coverLetter_GiancarloPozzo.txt

cd "$pwd"
