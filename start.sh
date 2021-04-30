#!/bin/sh
#this script will start the Wifi-Lamp Programm

#please set these variables according to your setup
repoPath="/home/pi/WifiLamp"
progrmPath="/home/pi/WifiLamp/Lamp.py"

#update update.sh
if [ -e /home/pi/update.sh ]
	then
    sudo rm /home/pi/update.sh
		echo "deleted update.sh"
		sudo cp /home/pi/WifiLamp/update.sh
    echo "updated update.sh"
	else
		echo "update.sh is missing : pls check Wifilamp-Code repo"
fi

#start program
if [ -e $progrmPath ]
	then
		echo "starting Lamp.py"
		sudo python3 $progrmPath 
	else
		echo "Lamp.py is missing : pls check Wifilamp-Code repo"
fi
