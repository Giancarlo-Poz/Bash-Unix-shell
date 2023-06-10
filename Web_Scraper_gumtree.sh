#!/bin/bash

#file to be executed with a click
# to run in terminal, without the infinite loop, use
# watch -n 30 ./webAlertScript

echo -n "  start the script " >> ~/cancella.txt
date >> ~/cancella.txt

mkdir ~/webAlert
cd ~/webAlert


########## do an infinite loop ##########
while true; do


# Arrays to be modified
#webpage=("https://www.gumtree.com.au/s-bicycles/melbourne/bike/k0c18560l3001317?sort=price_asc" "https://www.gumtree.com.au/s-clayton-melbourne/l3001603r2?sort=price_asc")
webpage=("https://www.gumtree.com.au/s-camping-hiking/melbourne/mattress/k0c18562l3001317?sort=price_asc" "https://www.gumtree.com.au/s-camping-hiking/melbourne/sleeping/k0c18562l3001317?sort=price_asc" "https://www.gumtree.com.au/s-camping-hiking/melbourne/tent/k0c18562l3001317?sort=price_asc")

#emailRecipients=("giancarlo.poz@gmail.com,jayshri.dumbre@monash.edu" "giancarlo.poz@gmail.com" "giancarlo.poz@gmail.com" "giancarlo.poz@gmail.com")
emailRecipients="giancarlo.poz@gmail.com"


# get the length of the arrays
length=${#webpage[@]}


########## only the first time create a file with the cheapest listings ##########
if [ ! -f memory.txt ]; then 
	for ((i=0;i<$length;i++)); do
	    lynx -dump -list_inline ${webpage[$i]} | sed -n '/ Cheapest/,$p' >> memory.txt
	done
fi


########## do the loop over webpages ##########
for ((i=0;i<$length;i++)); do


########## store the current cheapest entry ##########
now="$(lynx -dump -list_inline ${webpage[$i]} | awk '/ Cheapest/,/(BUTTON)/' | sed -e '$d' | sed -e '$d')"
nowNoLink="$(echo "$now" | sed -e 1,3d)"


########## check not empty ##########
if [ -n "$now" ]; then 

	touch memory.txt # update memory.txt's date: to check the script is running

	########## check new listing ##########
	if [[ "$(cat memory.txt)" != *"$nowNoLink"* ]]; then # chech if current listing is not included in memory

	link=$(echo "$now" | awk '/\[http/,/]/' | paste -sd "" | tr -d ' ' |tr -d "[" | tr -d "]")
	
#### use the following line if you want firefox to open the new listing as soon as it is found --->
	firefox $link # to directly open the link in firefox, you can comment this line
#### <---

	echo
	echo $link

	echo "Hi," > email.txt
	echo "" >> email.txt
	echo "Here there is a new listing, check" >> email.txt
	echo $link >> email.txt
	echo "" >> email.txt
	echo "$now" >> email.txt
	echo "" >> email.txt
	echo $link >> email.txt

#### use the following line if you want email without attachment, because shutter sometimes crashes and to not loose focus when firefox open the webpage --->
	mail -s "New Listing!!!" -a "From: Giancarlo" $emailRecipients < ./email.txt #CONTROLLA CHE FUNZIONI PER TUTTI I DESTINATARI: C'ERA UN BUG METTEVO UN INDICE i CHE PERO' E' L'INDICE DELLE PAGINE WEB
#### <---

##### use the following lines if you want email with attachment --->
#	shutter --web=$link -o image.png -n -e &>/dev/null # maybe you can avoid the image since shutter sometimes crashes
#
#	convert -crop 1024x730+0+330 image.png image.png
#
#	mail -s "New Listing!!!" -a "From: Giancarlo" -A image.png ${emailRecipients[$i]} < ./email.txt
##### <---

	echo "$now" >> memory.txt

	sleep 30 #gives more time to shutter command to finish

	fi
	########## finish if new listing ##########

fi
########## finish not empty ##########
	
done
########## finish the webpages loop ##########


sleep 60
done
########## finish the infinite loop ##########

mail -s "webAlertScript stopped" giancarlo.poz@gmail.com <<< 'It seems that webAlertScriptClick.sh crashed: the while true loop ended'

