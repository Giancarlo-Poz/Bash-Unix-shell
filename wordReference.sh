#!/bin/bash

sleep 1 

xdotool key ctrl+c

# xdotool keydown --delay 500 Control_L keydown --delay 500 c keyup c keyup Control_L

#added --desktop 0 workaround
firefoxID=$(xdotool search --desktop 0 --class firefox | tail -1 ) #get ID of the focused window, that is firefox

#it was easier with xdotool getwindowgeometry --shell $firefoxID
firefoxPositionX=$(xdotool getwindowgeometry $firefoxID | awk '/Position/' | awk '{print $2}' | awk -F"," '{print $1}')

firefoxPositionY=$(xdotool getwindowgeometry $firefoxID | awk '/Position/' | awk '{print $2}' | awk -F"," '{print $2}')

#firefoxPosition=$(xdotool getwindowgeometry $firefoxID | awk '/Position/' | awk '{ gsub(","," ",$2); print $2 }')

firefoxLength=$(xdotool getwindowgeometry $firefoxID | awk '/Geometry/' | awk '{print $2}' | awk -F"x" '{print $1}')

# xdotool getmouselocation #to get current mouse location

mousePositionX=$(($firefoxPositionX + $firefoxLength - 50))
#mousePositionY=$(($firefoxPositionY + 15)) # if firefox shows the title bar
mousePositionY=$(($firefoxPositionY + 40)) # if firefox does not show the title bar

#xdotool windowactivate --sync $firefoxID
#workaround requires desktop 0 (and doesn't use firefox ID)
xdotool search --desktop 0 "Firefox" windowactivate --sync

xdotool mousemove --sync $mousePositionX $mousePositionY

xdotool click 1

xdotool mousemove_relative --sync --polar 270 200

xdotool mousemove_relative --sync --polar 180 40

xdotool click 1

sleep 1 

xdotool key ctrl+v

xdotool key Return
