import git
import RPi.GPIO as GPIO
from sys import argv
import os
from os import environ

#festlegen der Pin-Benennung
#GPIO.setmode(GPIO.BOARD)
GPIO.setmode(GPIO.BCM)

#zuweisen der Pins
GPIO.setup(19,GPIO.OUT)
GPIO.setup(26,GPIO.IN)

#enviroment vars
os.environ['GIT_ASKPASS']= "/home/pi/WifiLamp/Lamp.py"
os.environ['GIT_USERNAME'] = "david.schwaninger@gmx.de"
os.environ['GIT_PASSWORD'] = "Githubnuria23!"
#refferenz-repository
repo = git.Repo(r'/home/pi/WifiLamp')

#initialisieren des remote
try:
    remote = repo.create_remote('origin', url='https://github.com/DavidEtit/Wifi-Lamp.git')
    print('had to create remote')
except git.exc.GitCommandError as error:
    print('didnt need to create repo')
    
#initialisieren random variablen
running = True
updated = False
switchPos = GPIO.input(26)
newState = ''
prevOnlineState = ''

while(running == True):
    #pull - Aktuelle Position
    try:
        repo.remotes.origin.pull()
    except git.exc.GitCommandError as error:
        print('could not pull')
    
    #Datei oeffnen und auslesen
    file =  open(r'/home/pi/WifiLamp/LampState.txt', 'r+')
    onlineState = file.readlines()

    #im Falle : Dokument leer
    if len(onlineState) == 0:
        print('file is empty')
        running = False
        file.close
        continue
    else:
        prevOnlineState = onlineState[0]
        file.close

    #aktualisieren der "LED"
    if 'an' in prevOnlineState:
        GPIO.output(19,GPIO.LOW)
        print('set pin to HIGH')
    elif 'aus' in prevOnlineState:
        GPIO.output(19,GPIO.HIGH)
        print('set pin to LOW') 
    else:
        print('invalide state of prevOnlineState:' + prevOnlineState)
        continue

    #check nach Aenderung des Schalters
    if switchPos == GPIO.input(26):
        newState = prevOnlineState
        continue
    if switchPos != GPIO.input(26):
        switchPos = GPIO.input(26)
        if 'an' in prevOnlineState:
            newState = 'aus'
        if 'aus' in prevOnlineState:
            newState = 'an'
        print('button pressed')

    #schreiben der neuen Position
    if newState == prevOnlineState:
        continue
    else:
        file =  open(r'/home/pi/WifiLamp/LampState.txt', 'w+')
        if newState == 'an' or newState == 'aus':
                file.write(newState)
                file.close()
                updated = True
        else:
                print('tried to write' + newState + 'to file')

    #check nach Updatebedarf
    if updated == False:
        continue

    #committen der Aenderung
    try:
        repo.index.add(['LampState.txt'])
        repo.index.commit('automatic commit')
    except git.exc.GitCommandError as error:
        print('could not add / commit')

    #pushen
    try:
        repo.remotes.origin.push()
    except git.exc.GitCommandError as error:
        print('could not push')    

    #command zuruecksetzen
    command = ''
GPIO.cleanup()
print('fuck')
