#!/bin/bash

option=$1
fullfile=$2
basefile=$3

mkdir -p logs

[ "$(ls -A logs)" ] && cp logs/* . # if log not empty then copy

#subdirectories
for i in $(ls -d */)
do
    if [[ "$i" == "logs/" ]] ; then continue
    fi
    [ -d $i/logs ] && [ "$(ls -A $i/logs)" ] && cp $i/logs/* $i/. 
done


#compilation
pdflatex $option $fullfile

#move logs if there are problem when * is expanded and there is more than one aux file, then use the solution with ls, as done below
[ -f *.aux  ] && mv *.aux logs/ # if *.aux esists then move
[ -f *.bcf  ] && mv *.bcf logs/
[ -f *.log  ] && mv *.log logs/
[ -f *.out  ] && mv *.out logs/
[ -f *.run.xml  ] && mv *.run.xml logs/
[ -f *.toc  ] && mv *.toc logs/

[ -f *.tex.bbl  ] && mv *.tex.bbl logs/ #first the double extension
[ -f *.bbl  ] && mv *.bbl logs/ #then the single extension

[ -f *.tex.blg  ] && mv *.tex.blg logs/
[ -f *.blg  ] && mv *.blg logs/

#subdirectories
for i in $(ls -d */ | tr -d "/")
do
    if [[ "$i" == "logs" ]] ; then continue
    fi
    if ls $i/*.aux      &> /dev/null; then mkdir -p $i/logs && mv $i/*.aux     $i/logs/; fi
    if ls $i/*.bcf      &> /dev/null; then mkdir -p $i/logs && mv $i/*.bcf     $i/logs/; fi
    if ls $i/*.log      &> /dev/null; then mkdir -p $i/logs && mv $i/*.log     $i/logs/; fi
    if ls $i/*.out      &> /dev/null; then mkdir -p $i/logs && mv $i/*.out     $i/logs/; fi
    if ls $i/*.run.xml  &> /dev/null; then mkdir -p $i/logs && mv $i/*.run.xml $i/logs/; fi
    if ls $i/*.toc      &> /dev/null; then mkdir -p $i/logs && mv $i/*.toc     $i/logs/; fi
    if ls $i/*.tex.bbl  &> /dev/null; then mkdir -p $i/logs && mv $i/*.tex.bbl $i/logs/; fi
    if ls $i/*.bbl      &> /dev/null; then mkdir -p $i/logs && mv $i/*.bbl     $i/logs/; fi
    if ls $i/*.tex.blg  &> /dev/null; then mkdir -p $i/logs && mv $i/*.tex.blg $i/logs/; fi
    if ls $i/*.blg      &> /dev/null; then mkdir -p $i/logs && mv $i/*.blg     $i/logs/; fi
done



# [ -f *.synctex.gz ] && mv *.synctex.gz logs/ # file used: click on the a point in the tex file redirect to the same point of the pdf file and viceversa  

#for cases with double extension eg *.tex.bbl you can also use
#[ -f *.bbl  ] && mv *.bbl logs/ #instead of this
#if compgen -G "*.bbl" > /dev/null; then mv *.bbl logs/ ; fi #this
#[ -f *.blg  ] && mv *.blg logs/
#if compgen -G "*.blg" > /dev/null; then mv *.blg logs/ ; fi


