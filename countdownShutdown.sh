#!/bin/bash

shutdownTime=$1
nowSeconds=$(date +%s)
shutdownSeconds=$(date -d $shutdownTime +%s); 
toShutdown=$(( $shutdownSeconds -$nowSeconds ))

echo -n "shutdown in "
date -d@$toShutdown -u +%Hh" "%Mm" "%Ss

toTenMinutes=$(( $toShutdown - 600 ))
toFiveMinutes=$(( $toShutdown - 300  ))
toThreeMinutes=$(( $toShutdown - 180  ))
toTwoMinutes=$(( $toShutdown - 120  ))
toOneMinute=$(( $toShutdown - 60  ))
toThirtySeconds=$(( $toShutdown - 30  ))

if [ $toTenMinutes -ge 0 ]; then
    sleep $toTenMinutes
    uxterm -e "echo shutdown in 10 minutes; sleep 298"
fi

nowSeconds=$(date +%s)
shutdownSeconds=$(date -d $shutdownTime +%s); 
toShutdown=$(( $shutdownSeconds -$nowSeconds ))
toFiveMinutes=$(( $toShutdown - 300  ))

if [ $toFiveMinutes -ge 0 ]; then
    sleep $toFiveMinutes
    uxterm -e "echo shutdown in 5 minutes; sleep 118"
fi

nowSeconds=$(date +%s)
shutdownSeconds=$(date -d $shutdownTime +%s); 
toShutdown=$(( $shutdownSeconds -$nowSeconds ))
toThreeMinutes=$(( $toShutdown - 180  ))

if [ $toThreeMinutes -ge 0 ]; then
    sleep $toThreeMinutes
    uxterm -e "echo shutdown in 3 minutes; sleep 58"
fi

nowSeconds=$(date +%s)
shutdownSeconds=$(date -d $shutdownTime +%s); 
toShutdown=$(( $shutdownSeconds -$nowSeconds ))
toTwoMinutes=$(( $toShutdown - 120  ))

if [ $toTwoMinutes -ge 0 ]; then
    sleep $toTwoMinutes
    uxterm -e "echo shutdown in 2 minutes; sleep 58"
fi

nowSeconds=$(date +%s)
shutdownSeconds=$(date -d $shutdownTime +%s); 
toShutdown=$(( $shutdownSeconds -$nowSeconds ))
toOneMinute=$(( $toShutdown - 60  ))

if [ $toOneMinute -ge 0 ]; then
    sleep $toOneMinute
    uxterm -e "echo shutdown in 1 minutes; sleep 28"
fi

nowSeconds=$(date +%s)
shutdownSeconds=$(date -d $shutdownTime +%s); 
toShutdown=$(( $shutdownSeconds -$nowSeconds ))
toThirtySeconds=$(( $toShutdown - 30  ))

if [ $toThirtySeconds -ge 0 ]; then
    sleep $toThirtySeconds
    uxterm -e "echo shutdown in 30 seconds;sleep 1;echo 29;sleep 1;echo 28;sleep 1;echo 27;sleep 1;echo 26;sleep 1;echo 25;sleep 1;echo 24;sleep 1;echo 23;sleep 1;echo 22;sleep 1;echo 21;sleep 1;echo 20;sleep 1;echo 19;sleep 1;echo 18;sleep 1;echo 17;sleep 1;echo 16;sleep 1;echo 15;sleep 1;echo 14;sleep 1;echo 13;sleep 1;echo 12;sleep 1;echo 11;sleep 1;echo 10;sleep 1;echo 9;sleep 1;echo 8;sleep 1;echo 7;sleep 1;echo 6;sleep 1;echo 5;sleep 1;echo 4;sleep 1;echo 3;sleep 1;echo 2;sleep 1;echo 1;sleep 1;echo SHUTDOWN NOW; sleep 2" 
fi

nowSeconds=$(date +%s)
shutdownSeconds=$(date -d $shutdownTime +%s); 
toShutdown=$(( $shutdownSeconds -$nowSeconds ))

if [ $toShutdown -ge 0 ]; then
    sleep $toShutdown
fi

. ~/Dropbox/script/shutdown

