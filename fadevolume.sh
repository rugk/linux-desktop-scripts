#!/bin/bash
currentSound=$(amixer get Master volume|grep "Playback.*%"|head -n 1|cut -d '[' -f 2|cut -d']' -f 1)

# fade out

fade=$( echo $currentSound | cut -d '%' -f 1 )
echo $fade
for ((; fade > 0; fade--)); do
	amixer set Master $fade%
	sleep 0.1
done

# kill music players
killall lollypop
killall rhythmbox

# reset volume
amixer set Master $currentSound

# suspend
#systemctl suspend&&exit 0

# force suspend later if it failed
#sleep 5
#systemctl suspend -i

#echo "error suspending"
