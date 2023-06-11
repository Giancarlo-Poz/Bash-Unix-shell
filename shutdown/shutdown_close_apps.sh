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




