#!/bin/bash

name=$(basename "$1") #name of the file
subdirectory="Selection_hardLinks" #set the name of the subdirectory to be created

directory="$(dirname "$1")/" #parent directory of the file
fulldirectory="$directory$subdirectory"
mkdir -p "$fulldirectory" #create subdirectory if it does not exist

ln "$1" "$fulldirectory/$name" #hard link file into the subdirectory
