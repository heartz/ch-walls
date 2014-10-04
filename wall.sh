#!/bin/bash
# Script to randomly set background from files in a directory

#-----------------------------------------------------------------------
#CONFIGURATION
#Path to directory containing images
DIR="/home/$USER"
#Interval to change wallpaper in minutes
INTERVAL=1
#-----------------------------------------------------------------------

SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"

if [ "$1" = "stop" ]; then
	LINE=$(crontab -l | grep -n $0 | cut -f1 -d: > /dev/null)
	crontab -l | sed `echo $LINE`d | crontab -
	sed -i '3s/.*//' $SCRIPT_DIR/$0
	exit
fi
#Cron runs with limited environment variables apparently adn DBUS_SESSION_BUS_ADDRESS is needed for gsettings
PID=$(pgrep gnome-session)
export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-)

PIC=$(ls $DIR/* | egrep -i '*.(png|jpg|jpeg)' | shuf -n1)
# Command to set Background Image
gsettings set org.gnome.desktop.background draw-background false && gsettings set org.gnome.desktop.background picture-uri file:///$PIC && gsettings set org.gnome.desktop.background draw-background true

#Setting up a cron job
if [ -z $CRON_SET ]; then
	crontab -l | (cat; echo "*/$INTERVAL * * * * sh $SCRIPT_DIR/$0") | crontab -
	sed -i '3s/.*/CRON_SET=1/' $SCRIPT_DIR/$0
fi

