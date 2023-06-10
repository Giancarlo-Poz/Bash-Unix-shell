#!/bin/bash

(uxterm -e " echo '          START SHUTDOWN' ; sleep 2 ") &


printf "$(date '+%Y/%m/%d  %H:%M:%S  %Z(%:::z)') start shutdown scripts\n|" >> ~/scriptsLog.log

. ~/Dropbox/script/shutdown_close_apps.sh

. ~/MEGAsync/GiancarloDropbox/Dropbox/script/shutdown_do.sh

printf "\n| $(date '+%H:%M:%S') shutdown now\n\n\n" >> ~/scriptsLog.log


shutdown now
