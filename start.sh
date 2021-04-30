#!/bin/sh
#this script will start update and startup the Wifi-Lamp Programm

#please set these variables according to your setup
repoPath="/home/pi/Lamp/Wifilamp-Code"
progrmPath="/home/pi/Lamp/Wifilamp-Code/Lamp.py"
lampPath="/home/pi/Lamp"
statePath="/home/pi/Lamp/Wifi-Lamp"
backupPath="/home/pi/Lamp/GitBackup/Wifi-Lamp"

#update program
if [ -d $statePath ]
	then
		sudo rm -r $statePath
		echo "deleted old Wifi-Lamp repo"
		sudo cp -r $backupPath $lampPath
		echo "copied backup repo"
	else
		echo "cant finde statePath : pls check start.sh"
fi
 
if [ -d $repoPath ]
	then
		cd $repoPath
		git pull
		echo "program is up to date"
		cd
	else
		echo "invalide repo path : pls update start.sh"
fi

#start program
if [ -e $progrmPath ]
	then
		echo "starting Lamp.py"
		sudo python3 $progrmPath 
	else
		echo "Lamp.py is missing : pls check Wifilamp-Code repo"
fi
