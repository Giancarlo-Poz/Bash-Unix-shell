#!/bin/bash

############################################################
#####  REMEMBER: to set firefox, open a webpage        #####
#####  and press ctrl+s and choose the following path  #####
#####  also a more or less xdotool key Tab cold be     #####
#####  required in the downloadWebpage function        #####
#####  also save file as tex file, not as webpage      #####
############################################################

cd ~/Dropbox/ongoing/italia/output/ #path where you save the html page, the email text and the running file

#file to be executed with a click
# to run in terminal, without the infinite loop, use
# watch -n 30 ./webAlertScript

emailRecipients="giancarlo.poz@gmail.com"

best1=1000 #initial price to go
best2=2000 #initial price to go back
bestAR=2000 #initial price to go and go back
#TODO use best1Next and best2Next to save the next-to-best prices, so you can check if best1 and best 2 are still available

loadPageTime=70

downloadWebpage () {
    firefox $1
    sleep $2 #wait to load the webpage and not be suspicious with too many requests to skyscanner.com
    gnome-screenshot -f screenshot.png -d 1
    sleep 2
    #xdotoold to save $website in 1.html
    xdotool key ctrl+s ; sleep 1 ; xdotool key Tab ; sleep 1; xdotool key Tab ; sleep 1
    xdotool key 1 ; sleep 1 ; xdotool key Return; sleep 1 ; xdotool key Return; sleep 1
    xdotool key ctrl+F4 ; sleep 1
}

set_price(){   
    price="$(sed -n '/Cheapest/,/[a-z]/p' 1.html | awk '/\$/'| tr -d '$' | tr -d ' ' | tr -d ',')"  
}
    
recordPriceWebsite1(){
    echo -n $1 >> prices1.txt #TODO check prices.txt is updated with another script
    echo -n ",$2," >>  prices1.txt
    echo "$(date)" >> prices1.txt #plot in Mathematica with DateListPlot
}

recordPriceWebsite2(){
    echo -n $1 >> prices2.txt #TODO check prices.txt is updated with another script
    echo -n ",$2," >>  prices2.txt
    echo "$(date)" >> prices2.txt #plot in Mathematica with DateListPlot
}

recordPriceWebsite3(){
    echo -n $1 >> prices3.txt #TODO check prices.txt is updated with another script
    echo -n ",$2," >>  prices3.txt
    echo "$(date)" >> prices3.txt #plot in Mathematica with DateListPlot
}

xdotool search --desktop 1 "Firefox" windowactivate --sync

#TODO usa random times

########## do an infinite loop ##########
while true; do



  #This is the copy of the previous snippet: see previous comment to understand it 
  input="../andataRitornoList.txt" 
  while IFS= read -r website; do

    downloadWebpage "$website" "$loadPageTime"
    
    set_price

    loadDifficultPage=60
    while [ $( echo $price | wc -w ) -eq 0 ] ; do #while price is empty
     mail -s "Problem" -a "From: Giancarlo" -A screenshot.png giancarlo.poz@gmail.com <<< 'price andata | wc -w == 0' 
     sleep 300
     downloadWebpage "$website" "$loadDifficultPage"
     set_price
     loadDifficultPage=$(( 2*$loadDifficultPage ))
    done

    recordPriceWebsite3 "$price" "$website"

    if [ "$price" -lt "$best3" ]; then 
      
      echo "Hi," > email.txt
      echo "" >> email.txt
      echo "Better price3 found!! Now to go and go back coasts" >> email.txt
      echo $price >> email.txt
      echo " AUD" >> email.txt
      echo "" >> email.txt
      echo "Check" >> email.txt
      echo "" >> email.txt
      echo "$website" >> email.txt
      echo "" >> email.txt
      
      mail -s "Better price3!!!" -a "From: Giancarlo" $emailRecipients < ./email.txt 
      
      echo $website >> memory.txt
      
      best3=$price
      
    fi
    
  done < $input
  ########## finish the first webpages3 loop ##########

  printf "$(date)," >> traceBestPrices3.txt
  echo -n $price >> traceBestPrices3.txt
  echo ",$website" >>  traceBestPrices3.txt #BUG this is the last website not the cheapest
  sleep 2
















  input="../andataList.txt" #file created with Mathematica
  while IFS= read -r website; do
    
    downloadWebpage "$website" "$loadPageTime"
    
    #extract Cheapest price from 1.html
    set_price

#    loadDifficultPage=30
#    while [ $( echo $price | wc -w ) -eq 0 ] ; do #while price is empty
#     gnome-screenshot -f screenshot.png -d 1
#     mail -s "Problem" -a "From: Giancarlo" -A screenshot.png giancarlo.poz@gmail.com <<< 'price andata | wc -w == 0' 
#     loadDifficultPage=$(( 2*$loadDifficultPage ))
#     downloadWebpage "$website" "$loadDifficultPage"
#    done

    loadDifficultPage=60
    while [ $( echo $price | wc -w ) -eq 0 ] ; do #while price is empty
     mail -s "Problem" -a "From: Giancarlo" -A screenshot.png giancarlo.poz@gmail.com <<< 'price andata | wc -w == 0' 
     sleep 300
     downloadWebpage "$website" "$loadDifficultPage"
     set_price
     loadDifficultPage=$(( 2*$loadDifficultPage ))
    done

    recordPriceWebsite1 "$price" "$website"

    #TODO use less or equal and check if the webpage is already send, so if it's in memory.txt
    if [ "$price" -lt "$best1" ]; then 
      
    #TODO function sendEmail
      echo "Hi," > email.txt
      echo "" >> email.txt
      echo "Better price1 found!! Now to go to Italy coasts" >> email.txt
      echo $price >> email.txt
      echo " AUD" >> email.txt
      echo "" >> email.txt
      echo "Check" >> email.txt
      echo "" >> email.txt
      echo "$website" >> email.txt
      echo "" >> email.txt
      
      mail -s "Better price1!!!" -a "From: Giancarlo" $emailRecipients < ./email.txt 
      
      echo $website >> memory.txt
      
      best1=$price
      
    fi
    
  done < $input
  ########## finish the first webpage1s loop ##########
  
  printf "$(date)," >> traceBestPrices1.txt #differently from echo, printf does not insert new line at the end
  echo -n $price >> traceBestPrices1.txt
  echo ",$website" >>  traceBestPrices1.txt #plot in Mathematica with DateListPlot #BUG this is the last website not the cheapest
  sleep 2  
  
  
  
  #This is the copy of the previous snippet: see previous comment to understand it 
  input="../ritornoList.txt" 
  while IFS= read -r website; do

    downloadWebpage "$website" "$loadPageTime"
    
    set_price

    loadDifficultPage=60
    while [ $( echo $price | wc -w ) -eq 0 ] ; do #while price is empty
     mail -s "Problem" -a "From: Giancarlo" -A screenshot.png giancarlo.poz@gmail.com <<< 'price andata | wc -w == 0' 
     sleep 300
     downloadWebpage "$website" "$loadDifficultPage"
     set_price
     loadDifficultPage=$(( 2*$loadDifficultPage ))
    done

    recordPriceWebsite2 "$price" "$website"

    if [ "$price" -lt "$best2" ]; then 
      
      echo "Hi," > email.txt
      echo "" >> email.txt
      echo "Better price2 found!! Now to go to Melbourne coasts" >> email.txt
      echo $price >> email.txt
      echo " AUD" >> email.txt
      echo "" >> email.txt
      echo "Check" >> email.txt
      echo "" >> email.txt
      echo "$website" >> email.txt
      echo "" >> email.txt
      
      mail -s "Better price2!!!" -a "From: Giancarlo" $emailRecipients < ./email.txt 
      
      echo $website >> memory.txt
      
      best2=$price
      
    fi
    
  done < $input
  ########## finish the first webpage2s loop ##########

  printf "$(date)," >> traceBestPrices2.txt
  echo -n $price >> traceBestPrices2.txt
  echo ",$website" >>  traceBestPrices2.txt #BUG this is the last website not the cheapest
  sleep 2





  
  sleep 25000 #time before starting another loop

  
done
########## finish the infinite loop ##########

mail -s "webAlertScript stopped" giancarlo.pozzo@monash.edu <<< 'It seems that webAlertScriptClick.sh crashed: the while true loop ended'

