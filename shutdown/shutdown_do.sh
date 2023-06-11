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
