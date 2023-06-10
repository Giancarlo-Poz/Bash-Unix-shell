#!/bin/bash

# set normal background
echo "dash /home/giancarlo/background/file1" > /home/giancarlo/background/file0

gsettings set org.gnome.desktop.background picture-uri file:///home/giancarlo/background/WallPaper.jpg

#backup libro
printf "\n| $(date '+%H:%M:%S') backup manuskript\n" >> ~/scriptsLog.log

cp /home/giancarlo/MEGAsync/GiancarloDropbox/Dropbox/ongoing/Scritti/tre_uno.msk /home/giancarlo/MEGAsync/GiancarloDropbox/Dropbox/ongoing/Scritti/tre_uno_backup.msk

cp -r /home/giancarlo/MEGAsync/GiancarloDropbox/Dropbox/ongoing/Scritti/tre_uno/ /home/giancarlo/MEGAsync/GiancarloDropbox/Dropbox/ongoing/Scritti/tre_uno_backup/


snapsToBeDeleted=$(snap list --all | awk '/disabled/{print $1, $3}')
if [ -n "$snapsToBeDeleted" ]; then
  printf "\n| $(date '+%H:%M:%S') Snaps to be manually deleted:
snap list --all   # the disabled ones can be deleted
sudo -s
snap list --all | while read snapname ver rev trk pub notes; do if [[ $notes = *disabled* ]]; then snap remove "$snapname" --revision="$rev"; fi; done
# then check and remove hard links
sudo rm -rfv /var/tmp/flatpak-cache-*
#exit sudo mode
exit" >> ~/scriptsLog.log
fi
