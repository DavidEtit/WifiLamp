#!/bin/sh
#this script will start update and startup the Wifi-Lamp Programm

#please set these variables according to your setup
repoPath="/home/pi/WifiLamp"
progrmPath="/home/pi/WifiLamp/Lamp.py"
gitPath="/home/pi/WifiLamp"
statePath="/home/pi/WifiLamp/.git"
backupPath="/home/pi/GitBackup"
fuckoff="/home/pi/GitBackup/WifiLamp"
gitBackupPath="/home/pi/GitBackup/WifiLamp/.git"

#update program
if [ -d $statePath ]
	then
		sudo rm -r $fuckoff
		cd $backupPath
		sudo git clone https://github.com/DavidEtit/WifiLamp.git
		cd
		sudo rm -r $statePath
		echo "deleted old WifiLamp .git"
		sudo cp -r $gitBackupPath  $gitPath
		echo "copied backup .git"
	else
		echo "cant finde statePath : pls check start.sh"
fi
 
if [ -d $repoPath ]
	then
		cd $repoPath
		sudo git pull
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
