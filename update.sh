#!/bin/sh
#this script will start update and startup the Wifi-Lamp Programm

#please set these variables according to your setup
repoPath="/home/pi/WifiLamp"
progrmPath="/home/pi/WifiLamp/start.sh"

#update program
if [ -d /home/pi/Backup/WifiLamp/ ]
	then
		sudo rm -r /home/pi/WifiLamp
		echo "deleted old repo"
		sudo cp -r /home/pi/Backup/WifiLamp /home/pi
		echo "copied backup repo"
	else
		echo "cant finde backup : pls check update.sh"
fi
 
if [ -d $repoPath ]
	then
		cd $repoPath
		sudo git pull
		echo "program is up to date"
		cd
	else
		echo "invalide repo path : pls update update.sh"
fi

#start program
if [ -e $progrmPath ]
	then
		echo "starting start.sh"
		sudo sh $progrmPath 
	else
		echo "start.sh is missing : pls check Wifilamp-Code repo"
fi
