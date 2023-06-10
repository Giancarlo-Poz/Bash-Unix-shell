#!/bin/bash

# compile with pdfLaTexIm all the .tex files in the subdirectories of the working directory. Useful when you change the LatexSetting directory

# remember no spaces in file's and directory's names: find . -name '* *'

cores=4
masterDir=$(pwd)

for folder in $(find . -mindepth 1 -maxdepth 1 -type d); do # loop over subfolders
  cd "$folder"
  for file in $(find . -type f -name "*.tex"); do 
    echo "pdfLaTexIm $file"

    ( /home/giancarlo/Dropbox/script/LaTeX/pdfLaTeXim "$file" >/dev/null  &&  echo "    pdfLaTexIm $file DONE" ) &  # run in background pdflatex

    cd "$masterDir"

    while [ $(jobs -rp | wc -l) -ge $cores ]; do
      wait -n # wait until one of the subprocesses is completed
    done
  
  done
done

wait

