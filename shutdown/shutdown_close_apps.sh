#!/bin/bash

#pgrep -i chrome
#if [ $? -eq 0 ]; then
#    nameChrome=$( pgrep chrome | head -n1 ) # chrome has many pids
#    startTimeCloseChrome=$(date +%s)
#    printf "\n| $(date '+%H:%M:%S') closing Chrome... " >> ~/scriptsLog.log
#    wmctrl -c chrome ; tail --pid=$nameChrome -f /dev/null ; now=$(date +%s) ; printf "Chrome closed in $(( $now - $startTimeCloseChrome )) sec.\n|" >> ~/scriptsLog.log
#fi

# if Chrome is open then close it gracefully
pgrep -if google/chrome; #chrome pid
if [ $? -eq 0 ]; then #check if last command exited correctly (PID found)
    startTimeCloseChrome=$(date +%s)
    printf "\n| $(date '+%H:%M:%S') closing Chrome... " >> ~/scriptsLog.log
    chrome_processes=$(wmctrl -l | awk '/Chrome/ {print strtonum($1)}')
    for p in $chrome_processes; do wmctrl -i -c $p; done;
    chrome_processes=$(wmctrl -l | awk '/Chrome/ {print strtonum($1)}')
    for p in $chrome_processes; do wmctrl -i -c $p; done;
    tail --pid=$(pgrep -i chrome) -f /dev/null
    now=$(date +%s) 
    printf " Chrome closed in $(( $now - $startTimeCloseFirefox )) sec.\n|" >> ~/scriptsLog.log
fi


# if Firefox is open then close it gracefully
pgrep -if firefox; #FF pid (I added f option: check this)
if [ $? -eq 0 ]; then #check if last command exited correctly (PID found)
    startTimeCloseFirefox=$(date +%s)
    printf "\n| $(date '+%H:%M:%S') closing Firefox... " >> ~/scriptsLog.log
    firefox_processes=$(wmctrl -l | awk '/Firefox/ {print strtonum($1)}')
    for p in $firefox_processes; do wmctrl -i -c $p; done;
    #do it again in case a FF process prevent another FF process to close, eg you cannot close FF is you don't close password window first 
    firefox_processes=$(wmctrl -l | awk '/Firefox/ {print strtonum($1)}')
    for p in $firefox_processes; do wmctrl -i -c $p; done;
    # tail terminates after process ID with PID dies
    tail --pid=$(pgrep -if firefox) -f /dev/null
    # calculating time
    now=$(date +%s) 
    printf " Firefox closed in $(( $now - $startTimeCloseFirefox )) sec.\n|" >> ~/scriptsLog.log
fi
#printf " $(date '+%H:%M:%S') Firefox instructions finished\n|" >> ~/scriptsLog.log


# Remove all exept last 3 backup files done by simple tab groups
stg_bk_dir=$(find /home/giancarlo/Downloads/STG-backup*/ -type d)

## print "remove following files" only if there are files to be removed
for bk_dir in $stg_bk_dir;  
do
    file_to_be_deleted=$(find $bk_dir -type f | sort -t $'\t' -g | head -n -3 | cut -d $'\t' -f 2-)
    if [ -n "$file_to_be_deleted" ]; then
      printf "\n| $(date '+%H:%M:%S') remove following files\n" >> ~/scriptsLog.log
      break
    fi
done

## print the filenames to be removed and remove them
for bk_dir in $stg_bk_dir; 
do    
    find $bk_dir -type f -printf '%T@\t%p\n' | sort -t $'\t' -g | head -n -3 | cut -d $'\t' -f 2- | sed -e 's/^/| | /' >> ~/scriptsLog.log 
    find $bk_dir -type f -printf '%T@\t%p\n' | sort -t $'\t' -g | head -n -3 | cut -d $'\t' -f 2- | xargs -d'\n' rm -f
done


# find /home/giancarlo/Downloads/TabSessionManager-Backup/ -type f -printf '%T@\t%p\n' | sort -t $'\t' -g | head -n -2 | cut -d $'\t' -f 2- | xargs -d'\n' rm -f # leave only 2 files
# find /home/giancarlo/Downloads/TabSessionManager-Backup/ -type f -printf '%T@\t%p\n' | sort -t $'\t' -g | head -n -2 | cut -d $'\t' -f 2- | sed "s/\ /\\\ /g" | xargs rm -f

#find /home/giancarlo/Downloads/STG-backups-FF-*/ -type f -printf '%T@\t%p\n' | # lists all files in STG backup directory. They are printed out with timestamps
#sort -t $'\t' -g | # sorts the lines based on timestamp (oldest on top)
#head -n -3 | # prints out the top lines, up to the last 3 lines
#cut -d $'\t' -f 2- | # removes the timestamps
#sed "s/\ /\\\ /g" | # substitute white spaces " " with slashed withe spaces "\ "
#xargs -d'\n' rm -f # runs rm for every selected file. the \n delimites the different files

