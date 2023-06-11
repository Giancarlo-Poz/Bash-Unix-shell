#!/bin/bash

(uxterm -e " echo -e "\a" ; echo '          START REBOOT' ; sleep 2 ") &

. ~/Dropbox/script/shutdown_close_apps.sh

printf "$(date '+%Y/%m/%d  %H:%M:%S  %Z(%:::z)') reboot machine\n|" >> ~/scriptsLog.log

shutdown -r now
