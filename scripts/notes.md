#!/bin/bash

#Activate Cron Service on Raspberry
/etc/init.d/cron start

#remove Command Line Logo on startup
# Add "loglevel=3 quiet logo.nologo"
# Change Console Output to 3
sudo nano /boot/cmdline.txt //add "logo.nologo" at the end

install rfkill  

#Add line to the .profile in home folder to startup the window server
sleep 120
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && startx -- -nocursor &


#Create Huslogin File in Home Directory
cd 

#Manually Change the Graphic Memory to 3072 MB
sudo raspi-config

#Disable Wifi in config.txt
dtoverlay=disable-wifi

#Install Pitunnel and setup SSH and VNC Port
curl -s pitunnel.com/get/bP8fr3z2i | sudo bash

#add Startup Script to rc.local file
#Use Command "sudo nano /etc/rc.local"
Add the following
"
bash /home/arrenberg/quartiersdisplay-os/scripts/startup.sh &
#Suppress Kernel Messages
dmesg --console-off
"


