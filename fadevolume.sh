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
killall gnome-music
# flatpak support
command -v flatpak&&flatpak kill org.gnome.Lollypop
command -v flatpak&&flatpak kill org.gnome.Rhythmbox3
command -v flatpak&&flatpak kill org.gnome.Music

# reset/restore volume
# so the next time the volume is not set to 0%
sleep 0.1
amixer set Master $currentSound

# suspend
#systemctl suspend&&exit 0

# force suspend later if it failed
#sleep 5
#systemctl suspend -i

#echo "error suspending"
